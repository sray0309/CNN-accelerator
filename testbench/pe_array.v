`include "../verilog/register_sync.v"
`include "../verilog/counter.v"
`include "../verilog/signed_adder.v"
`include "../verilog/shifter.v"
`include "../verilog/pe.v"

module pe_array #(
    parameter integer   ARRAY_M             = 8,
    parameter integer   ARRAY_N             = 8,
    parameter integer   NUM_PES             = ARRAY_M * ARRAY_N,

    parameter integer   FILTER_WIDTH        = 8,
    parameter integer   DATA_WIDTH          = 8,
    parameter integer   ACCU_WIDTH          = 24,
    parameter integer   NUM_DATA            = 16,

    parameter integer   IBUF_DATA_WIDTH     = NUM_DATA * DATA_WIDTH,
    parameter integer   FBUF_DATA_WIDTH     = NUM_DATA * FILTER_WIDTH,
    parameter integer   OBUF_DATA_WIDTH     = ARRAY_M *  ACCU_WIDTH,
    parameter integer   PEA_OUT_WIDTH       = ARRAY_N * ACCU_WIDTH,

    parameter integer   CT_ADDR             = $clog2(NUM_DATA),
    parameter integer   NUM_PE_WIDTH        = $clog2(NUM_PES) + 1,
    parameter integer   NUM_KERNEL_WIDTH    = $clog2(ARRAY_N) + 1,

    parameter integer   SIGNED_ADDER_DELAY  = 2
)(
    input   wire                                    clk,
    input   wire                                    reset,
    // input   wire                                    start,      // determine when to start convolution, high after ARRAY_N cycles && shif complete, when all data are load to ibuf && filters are loaded
    input   wire                                    enable,     // 1 while convolution
    input   wire                                    sys_start,
    input   wire                                    input_load,
    input   wire                                    sum_timestep,

    input   wire    [ NUM_PES           - 1 : 0 ]   filter_addr,
    input   wire    [ NUM_PE_WIDTH      - 1 : 0 ]   num_filter,
    input   wire    [ NUM_KERNEL_WIDTH  - 1 : 0 ]   num_kernel,

    input   wire    [ IBUF_DATA_WIDTH   - 1 : 0 ]   ibuf_read_data,
    // input   wire    [ FBUF_DATA_WIDTH   - 1 : 0 ]   fbuf_read_data,

    output  wire                                    acc,
    output  wire    [ OBUF_DATA_WIDTH   - 1 : 0 ]   obuf_write_data

    `ifdef DEBUG
    , output wire   [ CT_ADDR           - 1 : 0 ]   pe_c_addr

    , output wire   [ ACCU_WIDTH        - 1 : 0 ]   pe_out_00
    , output wire   [ DATA_WIDTH        - 1 : 0 ]   pe_Bin_00
    , output wire   [ IBUF_DATA_WIDTH   - 1 : 0 ]   pe_nextB_00
    , output wire                                   pe_acc_valid_00
    , output wire                                   pe_Aload_00

    , output wire   [ PEA_OUT_WIDTH     - 1 : 0 ]   pe_array_acc_in_0
    , output wire   [ ACCU_WIDTH        - 1 : 0 ]   pe_array_acc_out_0
    , output wire   [ SIGNED_ADDER_DELAY- 1 : 0 ]   pe_adder_enable_0

    `endif

);

    wire    [ OBUF_DATA_WIDTH   - 1 : 0 ]           _obuf_write_data;
    wire    [ CT_ADDR           - 1 : 0 ]           c_addr;

    wire                                            _acc;
    wire                                            _update;

    `ifdef DEBUG
        assign pe_c_addr = c_addr;
    `endif

    counter #(.NUM_COUNT(NUM_DATA)) filter_count(clk, ~sys_start, enable, c_addr, _update); //determine which number in the filter will be used
    
    genvar m, n;
    generate;
        for(m=0; m<ARRAY_M; m=m+1)   
        begin: OUT_CHANNELS
            wire    [ PEA_OUT_WIDTH         - 1 : 0 ]       pe_arr_out;

            wire    [ SIGNED_ADDER_DELAY    - 1 : 0 ]       _adder_enable;
            for(n=0; n<ARRAY_N; n=n+1)
            begin: KERNEL
                wire                                                acc_valid;
                wire                                                Aload;
                wire    [ IBUF_DATA_WIDTH           - 1 : 0 ]       prev_B;
                wire    [ IBUF_DATA_WIDTH           - 1 : 0 ]       next_B;
                wire    [ ACCU_WIDTH                - 1 : 0 ]       Y;

                assign Aload = filter_addr[ARRAY_N*m+n];

                if ( n == ARRAY_N-1 )
                    assign prev_B = ibuf_read_data;
                else
                    assign prev_B = OUT_CHANNELS[m].KERNEL[n+1].next_B;
                register_sync #(IBUF_DATA_WIDTH) input_data_update(clk, reset, input_load, prev_B, next_B);   //shift 16 8bit data to next  

                wire    [ DATA_WIDTH        - 1 : 0 ]       Bin;
                assign  Bin = next_B[DATA_WIDTH*c_addr+:DATA_WIDTH];   //extract one 8bit data to be calculated from loaded input
                                
                pe #(
                    .FILTER_WIDTH       ( FILTER_WIDTH      ),
                    .INPUT_WIDTH        ( DATA_WIDTH        ),
                    .PE_OUT_WIDTH       ( ACCU_WIDTH        ),
                    .NUM_DATA           ( NUM_DATA          )
                ) mpe(
                    .clk                ( clk               ),
                    .reset              ( reset             ), 
                    .Aload              ( Aload             ), // Aload when pe starts to load filter data
                    .start              ( sys_start         ), // sys_start when pe starts to processing data
                    .A                  ( ibuf_read_data    ),
                    .B                  ( Bin               ),
                    .Y                  ( Y                 ),
                    .acc_valid          ()
                );

                register_sync #(ACCU_WIDTH) pe_out(clk, reset, sum_timestep, Y, OUT_CHANNELS[m].pe_arr_out[n*ACCU_WIDTH+:ACCU_WIDTH]);
            end

            register_sync #(1) addder_delay(clk, reset, enable, sum_timestep, OUT_CHANNELS[m]._adder_enable[0]);
            for (n=1; n<SIGNED_ADDER_DELAY; n=n+1)
            begin: ADDER_DELAY
                register_sync #(1) adder_delay_series(clk, reset, enable, OUT_CHANNELS[m]._adder_enable[n-1], OUT_CHANNELS[m]._adder_enable[n]);
            end

            wire    [ ACCU_WIDTH            - 1 : 0 ]       acc_out;

            // accmulate #ARRAY_N PEs output, give 2 clks to compute the result
            signed_adder #(
                .MAX_NUM_ADD        ( ARRAY_N                   ),
                .DATA_WIDTH         ( ACCU_WIDTH                ),
                .OUT_WIDTH          ( ACCU_WIDTH                )
            ) msa(
                .enable             ( |_adder_enable            ),
                .num_kernel         ( num_kernel                ),    
                .ibus_read_data     ( pe_arr_out                ),
                .obus_write_data    ( acc_out                   )
            );

            register_sync #(ACCU_WIDTH) acc_out_delay(clk, reset, |_adder_enable, OUT_CHANNELS[m].acc_out, _obuf_write_data[ACCU_WIDTH*m+:ACCU_WIDTH]);
        end

        `ifdef DEBUG
            assign pe_out_00        = OUT_CHANNELS[0].KERNEL[1].Y;
            assign pe_nextB_00      = OUT_CHANNELS[0].KERNEL[1].next_B;
            assign pe_Bin_00        = OUT_CHANNELS[0].KERNEL[1].Bin;
            assign pe_acc_valid_00  = OUT_CHANNELS[0].KERNEL[0].acc_valid;
            assign pe_Aload_00      = OUT_CHANNELS[7].KERNEL[3].Aload;
            
            assign pe_adder_enable_0    = OUT_CHANNELS[0]._adder_enable;
            assign pe_array_acc_in_0    = OUT_CHANNELS[0].pe_arr_out;
            assign pe_array_acc_out_0   = OUT_CHANNELS[0].acc_out;
        `endif
    endgenerate

    register_sync #(1) acc_valid_delay(clk, reset, enable, sum_timestep, _acc);
    register_sync #(1) acc_valid_delay2(clk, reset, enable, _acc, acc);
    // register_sync #(OBUF_DATA_WIDTH) conv_out(clk, reset, _obuf_write_data, obuf_write_data);
    assign obuf_write_data = _obuf_write_data;
        
endmodule

