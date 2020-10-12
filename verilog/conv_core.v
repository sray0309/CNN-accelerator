module conv_core #(
    parameter integer   MAX_CHANNELSNUM             = 8,
    parameter integer   MAX_KERNELNUM               = 8,

    parameter integer   MAX_FILTERNUM               = MAX_CHANNELSNUM * MAX_KERNELNUM,
    parameter integer   MAX_DATANUM                 = 16,
    parameter integer   MAX_TIMESTEPNUM             = 90,

    parameter integer   CHANNELNUM_WIDTH            = $clog2(MAX_CHANNELSNUM) + 1,
    parameter integer   FILTERNUM_WIDTH             = $clog2(MAX_OUTCHANNELNUM) + 1,
    parameter integer   KERNELNUM_WIDTH             = $clog2(MAX_KERNELNUM) + 1,
    parameter integer   DATANUM_WIDTH               = $clog2(MAX_DATANUM) + 1,
    parameter integer   TIMESTEP_WIDTH              = $clog2(MAX_TIMESTEPNUM) + 1,

    parameter integer   DATA_WIDTH                  = 8,
    parameter integer   ACCU_WIDTH                  = 24,

    parameter integer   ADDR_WIDTH                  = 10
)(
    input   wire                                    clk,
    input   wire                                    reset,
    input   wire                                    enable,
    input   wire    [ CHANNELNUM_WIDTH  - 1 : 0 ]   num_outchannel,
    input   wire    [ KERNELNUM_WIDTH   - 1 : 0 ]   num_kernel,
    input   wire    [ DATANUM_WIDTH     - 1 : 0 ]   filter_length,
    input   wire    [ TIMESTEP_WIDTH    - 1 : 0 ]   num_total_conv


);
    
    wire        [ FILTERNUM_WIDTH   - 1 : 0 ]       filter_cnt;
    wire        [ KERNELNUM_WIDTH   - 1 : 0 ]       kernel_cnt;
    wire        [ DATANUM_WIDTH     - 1 : 0 ]       cal_cnt;
    wire                                            filter_load;
    wire                                            input_load;
    wire                                            sys_start;
    wire                                            sum_timestep;
    wire                                            conv;

    wire        [ MAX_FILTERNUM     - 1 : 0 ]       filter_addr;

    wire        [ FILTERNUM_WIDTH   - 1 : 0 ]       num_filter;
    assign                                          num_filter = num_outchannel * num_kernel;

    wire        [ ADDR_WIDTH        - 1 : 0 ]       data_addr;
    wire        [ ADDR_WIDTH        - 1 : 0 ]       data_addr_n;

    wire        [ IBUF_DATA_WIDTH   - 1 : 0 ]       ibuf_read_data;  //change every 16 cycles
    // reg         [ FBUF_DATA_WIDTH   - 1 : 0 ]       fbuf_read_data;  //when start triggered, change one time every cycle, until NUM_OUT_CHANNEL * NUM_KERNEL cycles

    wire                                            acc;
    wire        [ OBUF_DATA_WIDTH   - 1 : 0 ]       obuf_write_data;


    // PE_ARRAY DEBUG signal
    `ifdef DEBUG
    wire        [ CT                - 1 : 0 ]       pe_c_addr;
    wire        [ ACCU_WIDTH        - 1 : 0 ]       pe_out_00;
    wire        [ DATA_WIDTH        - 1 : 0 ]       pe_Bin_00;
    wire        [ IBUF_DATA_WIDTH   - 1 : 0 ]       pe_nextB_00;
    wire                                            pe_acc_valid_00;
    wire                                            pe_Aload_00;


    wire        [ PEA_OUT_WIDTH     - 1 : 0 ]       pe_array_acc_in_0;
    wire        [ ACCU_WIDTH        - 1 : 0 ]       pe_array_acc_out_0;
    wire        [ SIGNED_ADDER_DELAY- 1 : 0 ]       pe_adder_enable_0;
    `endif

    // =======================================================     

    controller #(
        .FILTERNUM_WIDTH        ( FILTERNUM_WIDTH   ),
        .KERNELNUM_WIDTH        ( KERNELNUM_WIDTH   ),
        .DATANUM_WIDTH          ( DATANUM_WIDTH     ),
        .TIMESTEP_WIDTH         ( TIMESTEP_WIDTH    )
    ) ctrl(
        .clk                    ( clk               ),        
        .reset                  ( reset             ),        
        .enable                 ( enable            ),        
        .num_filter             ( num_filter        ),        
        .num_kernel             ( num_kernel        ),        
        .filter_length          ( filter_length     ),    
        .num_total_conv         ( num_total_conv    ),

        .filter_cnt             ( filter_cnt        ),
        .kernel_cnt             ( kernel_cnt        ),
        .cal_cnt                ( cal_cnt           ),
        .sys_start              ( sys_start         ),
        .conv                   ( conv              ),
        .filter_load            ( filter_load       ),
        .input_load             ( input_load        ),
        .sum_timestep           ( sum_timestep      ),
        .conv                   ( conv              ),
        .data_addr              ( data_addr         ),
        .data_addr_n            ( data_addr_n       )

    );

    pe_decoder #(
        .MAX_FILTERNUM          ( 64                ),
        .MAX_KERNELNUM          ( 8                 )
    ) pedr(
        .filter_cnt             ( filter_cnt        ), //pe id to be decoded 
        .filter_load            ( filter_load       ), //when filter_load is high, no pe addr is seleced  
        .num_filter             ( num_filter        ), //total number of PEs
        .num_kernel             ( num_kernel        ),
        .filter_addr            ( filter_addr       )  //decoded pe addr
    );


    pe_array #(
        .ARRAY_M                ( MAX_CHANNELSNUM   ),
        .ARRAY_N                ( MAX_KERNELNUM     ),

        .FILTER_WIDTH           ( DATA_WIDTH        ),
        .DATA_WIDTH             ( DATA_WIDTH        ),
        .ACCU_WIDTH             ( ACCU_WIDTH        ),
        .NUM_DATA               ( NUM_DATA          )
    ) pea(
        .clk                    ( clk               ),
        .reset                  ( reset             ),
        .enable                 ( enable            ),

        .sys_start              ( sys_start         ), //denote when to start convolution, need to stop after # time_steps of time
        .filter_addr            ( filter_addr       ), //an array denotes which PE needs to load filter data 
        .input_load             ( input_load        ),
        .sum_timestep           ( sum_timestep      ),

        .num_filter             ( num_filter        ), //denote how many 
        .num_kernel             ( num_kernel        ),

        .ibuf_read_data         ( ibuf_read_data    ),
        // .fbuf_read_data         ( fbuf_read_data    ),
        
        .acc                    ( acc               ),
        .obuf_write_data        ( obuf_write_data   )
        `ifdef DEBUG
        , .pe_c_addr            ( pe_c_addr         )
        , .pe_out_00            ( pe_out_00         )     
        , .pe_Bin_00            ( pe_Bin_00         )
        , .pe_nextB_00          ( pe_nextB_00       )
        , .pe_acc_valid_00      ( pe_acc_valid_00   )
        , .pe_Aload_00          ( pe_Aload_00       )
        , .pe_array_acc_in_0    ( pe_array_acc_in_0 )
        , .pe_array_acc_out_0   ( pe_array_acc_out_0)
        , .pe_adder_enable_0    ( pe_adder_enable_0 )
        `endif
    );


    CNN_ROM1 rom1(                                  //256 words, 64 bits memory. low 128 words: filter weight. high 128 words: input data
        .CLK                        ( clk               ),
        .Q                          ( ibuf_read_data[IBUF_DATA_WIDTH-1:IBUF_DATA_WIDTH/2]   ),  // output 
        .A                          ( data_addr         ),    // 256 address (8 bits)(filter weight:00000000-00111111;    input data:01000000-11111111)
        .CEN                        ( 0                 )
    );

    CNN_ROM2 rom2(                                  //256 words, 64 bits memory. low 128 words: filter weight. high 128 words: input data
        .CLK                        ( clk               ),
        .Q                          ( ibuf_read_data[IBUF_DATA_WIDTH/2-1:0]                 ),  // output 
        .A                          ( data_addr_n       ),    // 256 address (8 bits)(filter weight:00000000-00111111;    input data:01000000-11111111)
        .CEN                        ( 0                 )
    );


endmodule