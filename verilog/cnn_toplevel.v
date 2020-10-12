module cnn_toplevel #(
    parameter integer   MAX_CHANNELSNUM             = 8,
    parameter integer   MAX_KERNELNUM               = 8,
    parameter integer   MAX_FILTERNUM               = MAX_CHANNELSNUM * MAX_KERNELNUM,

    parameter integer   FILTERNUM_WIDTH             = 8,    //3
    parameter integer   KERNELNUM_WIDTH             = 8,    //3
    parameter integer   DATANUM_WIDTH               = 8,
    parameter integer   TIMESTEP_WIDTH              = 8,    //7

    parameter integer   DATA_WIDTH                  = 8,
    parameter integer   ACCU_WIDTH                  = 16,
    parameter integer   NUM_DATA                    = 16,
    parameter integer   IBUF_DATA_WIDTH             = NUM_DATA * DATA_WIDTH,
    parameter integer   FBUF_DATA_WIDTH             = NUM_DATA * DATA_WIDTH,
    parameter integer   OBUF_DATA_WIDTH             = MAX_CHANNELSNUM *  ACCU_WIDTH,

    parameter integer   PEA_OUT_WIDTH               = MAX_KERNELNUM * ACCU_WIDTH,
    parameter integer   CT                          = $clog2(NUM_DATA),
    parameter integer   SIGNED_ADDER_DELAY          = 2,

    parameter integer   ADDR_WIDTH                  = 10
)(
    input                                           clk, reset, enable,
    input     [ FILTERNUM_WIDTH       - 1 : 0 ]       num_filter,
    input     [ KERNELNUM_WIDTH       - 1 : 0 ]       num_kernel,
    input     [ DATANUM_WIDTH         - 1 : 0 ]       filter_length,
    input     [ TIMESTEP_WIDTH        - 1 : 0 ]       num_total_conv,
    output    [                        63 : 0 ]       mem_out
);

    reg                                             clk, reset, enable;
    reg     [ FILTERNUM_WIDTH       - 1 : 0 ]       num_filter;
    reg     [ KERNELNUM_WIDTH       - 1 : 0 ]       num_kernel;
    reg     [ DATANUM_WIDTH         - 1 : 0 ]       filter_length;
    reg     [ TIMESTEP_WIDTH        - 1 : 0 ]       num_total_conv;

    
    wire    [ FILTERNUM_WIDTH       - 1 : 0 ]       filter_cnt;
    wire    [ KERNELNUM_WIDTH       - 1 : 0 ]       kernel_cnt;
    wire    [ DATANUM_WIDTH         - 1 : 0 ]       cal_cnt;
    wire                                            sys_start;
    wire                                            conv;
    wire                                            filter_load;
    wire                                            input_load;
    wire                                            _input_load;
    wire                                            sum_timestep;

    wire    [ MAX_FILTERNUM     - 1 : 0 ]           filter_addr;
    wire    [ MAX_FILTERNUM     - 1 : 0 ]           _filter_addr;

    // =======================================================
    // PE ARRAY wires

    reg         [ IBUF_DATA_WIDTH   - 1 : 0 ]       ibuf_read_data;  //change every 16 cycles
    // reg         [ FBUF_DATA_WIDTH   - 1 : 0 ]       fbuf_read_data;  //when start triggered, change one time every cycle, until NUM_OUT_CHANNEL * NUM_KERNEL cycles

    wire                                            acc;
    wire        [ OBUF_DATA_WIDTH   - 1 : 0 ]       obuf_write_data;

    // DEBUG signal
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

    wire        [ ADDR_WIDTH        - 1 : 0 ]       data_addr;
    wire        [ ADDR_WIDTH        - 1 : 0 ]       data_addr_n;    
    wire        [ ADDR_WIDTH        - 1 : 0 ]       outmem_addr; 
    wire        [                     63: 0 ]       outmem_data;
    wire                                            write_enable;



controller #(
        .FILTERNUM_WIDTH                ( FILTERNUM_WIDTH   ),
        .KERNELNUM_WIDTH                ( KERNELNUM_WIDTH   ),
        .DATANUM_WIDTH                  ( DATANUM_WIDTH     ),
        .TIMESTEP_WIDTH                 ( TIMESTEP_WIDTH    )
    ) ctrl(
        .clk                            ( clk               ),        
        .reset                          ( reset             ),        
        .enable                         ( enable            ),        
        .num_filter                     ( num_filter        ),        
        .num_kernel                     ( num_kernel        ),        
        .filter_length                  ( filter_length     ),    
        .num_total_conv                 ( num_total_conv    ),

        .filter_cnt                     ( filter_cnt        ),
        .kernel_cnt                     ( kernel_cnt        ),
        .cal_cnt                        ( cal_cnt           ),
        .sys_start                      ( sys_start         ),
        .conv                           ( conv              ),
        .filter_load                    ( filter_load       ),
        .input_load                     ( input_load        ),
        .sum_timestep                   ( sum_timestep      ),
        .data_addr                     ( data_addr         ),
        .data_addr_n                    ( data_addr_n       ),
        .outmem_addr                    (outmem_addr        ),
        .write_enable                   ( write_enable      )

    );

pe_decoder #(
        .MAX_FILTERNUM              ( 64                ),
        .MAX_KERNELNUM              ( 8                 )
    ) pedr(
        .filter_cnt                 ( filter_cnt        ), //pe id to be decoded 
        .filter_load                ( filter_load       ), //when filter_load is high, no pe addr is seleced  
        .num_filter                 ( num_filter        ), //total number of PEs
        .num_kernel                 ( num_kernel        ),
        .filter_addr                ( filter_addr       )  //decoded pe addr
    );

register_sync #(MAX_FILTERNUM) filter_addr_delay(clk, reset, enable, filter_addr, _filter_addr);
register_sync #(1) input_load_delay(clk, reset, enable, input_load, _input_load);


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
        .filter_addr            ( _filter_addr      ), //an array denotes which PE needs to load filter data 
        .input_load             ( _input_load       ),
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
        .Q                          ( ibuf_read_data[IBUF_DATA_WIDTH-1:IBUF_DATA_WIDTH/2]         ),  // output 
        .A                          ( data_addr         ),    // 256 address (8 bits)(filter weight:00000000-00111111;    input data:01000000-11111111)
        .CEN                        ( 0                 )
    );

    CNN_ROM2 rom2(                                  //256 words, 64 bits memory. low 128 words: filter weight. high 128 words: input data
        .CLK                        ( clk               ),
        .Q                          ( ibuf_read_data[IBUF_DATA_WIDTH/2-1:0]         ),  // output 
        .A                          ( data_addr         ),    // 256 address (8 bits)(filter weight:00000000-00111111;    input data:01000000-11111111)
        .CEN                        ( 0                 )
    );

    assign outmem_data = {obuf_write_data[127],obuf_write_data[125:119],obuf_write_data[111],obuf_write_data[109:103],obuf_write_data[95],obuf_write_data[93:87],obuf_write_data[79],obuf_write_data[77:71],obuf_write_data[63],obuf_write_data[61:55],obuf_write_data[47],obuf_write_data[45:39],obuf_write_data[31],obuf_write_data[29:23],obuf_write_data[15],obuf_write_data[13:7]};

    CNN_outMEM outMEM(
        .Q                          ( mem_out           ),
        .CLK                        ( clk               ),
        .CEN                        ( 0                 ),
        .WEN                        ( write_enable      ),
        .A                          ( outmem_addr       ),
        .D                          ( outmem_data       )
    );


endmodule