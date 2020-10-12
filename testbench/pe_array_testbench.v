module pe_array_testbench;
    parameter integer   NUM_OUT_CHANNEL         = 8;
    parameter integer   NUM_KERNEL              = 4;
    parameter integer   DATA_WIDTH              = 8;
    parameter integer   ACCU_WIDTH              = 24;
    
    parameter integer   NUM_DATA                = 16;
    parameter integer   CT                      = $clog2(NUM_DATA);

    parameter integer   NUM_PES                 = NUM_OUT_CHANNEL * NUM_KERNEL;
    parameter integer   PEA_OUT_WIDTH           = NUM_KERNEL * ACCU_WIDTH;

    parameter integer   IBUF_DATA_WIDTH         = NUM_DATA * DATA_WIDTH;
    parameter integer   FBUF_DATA_WIDTH         = NUM_DATA * DATA_WIDTH;
    parameter integer   OBUF_DATA_WIDTH         = NUM_OUT_CHANNEL *  ACCU_WIDTH;

    reg                                             clk, reset, enable, start;

    reg         [ IBUF_DATA_WIDTH   - 1 : 0 ]        ibuf_read_data;  //change every 16 cycles
    reg         [ FBUF_DATA_WIDTH   - 1 : 0 ]        fbuf_read_data;  //when start triggered, change one time every cycle, until NUM_OUT_CHANNEL * NUM_KERNEL cycles

    wire                                            acc;
    wire        [ OBUF_DATA_WIDTH   - 1 : 0 ]       obuf_write_data;

    // DEBUG signal
    `ifdef DEBUG 
    wire                                            update;
    wire        [ CT                - 1 : 0 ]       pe_c_addr;
    wire                                            core_start;

    wire        [ NUM_PES           - 1 : 0 ]       pe_sel;
    wire        [ ACCU_WIDTH        - 1 : 0 ]       pe_out_10;
    wire        [ DATA_WIDTH        - 1 : 0 ]       pe_Bin_10;
    wire        [ IBUF_DATA_WIDTH   - 1 : 0 ]       pe_nextB_10;
    wire                                            pe_acc_valid_10;
    wire                                            pe_Aload_10;

    wire                                            input_vld;
    wire                                            shif_vld;


    wire        [ PEA_OUT_WIDTH     - 1 : 0 ]       pe_array_acc_in_1;
    wire        [ ACCU_WIDTH        - 1 : 0 ]       pe_array_acc_out_1;
    `endif



    reg         [ CT                - 1 : 0 ]       count;

    pe_array #(
        .ARRAY_M                ( NUM_OUT_CHANNEL   ),
        .ARRAY_N                ( NUM_KERNEL        ),

        .FILTER_WIDTH           ( DATA_WIDTH        ),
        .DATA_WIDTH             ( DATA_WIDTH        ),
        .ACCU_WIDTH             ( ACCU_WIDTH        ),
        .NUM_DATA               ( NUM_DATA          )
    ) DUT(
        .clk                    ( clk               ),
        .reset                  ( reset             ),
        .enable                 ( enable            ),

        .sys_start              ( sys_start         ), //denote when to start convolution, need to stop after # time_steps of time
        .filter_addr            ( filter_addr       ), //an array denotes which PE needs to load filter data 
        .filter_load            ( filter_load       ),   
        .input_load             ( input_load        ),
        .sum_timestep           ( sum_timestep      ),

        .num_filter             ( num_filter        ), //denote how many 
        .num_kernel             ( num_kernel        ),

        .ibuf_read_data         ( ibuf_read_data    ),
        .fbuf_read_data         ( fbuf_read_data    ),
        
        .acc                    ( acc               ),
        .obuf_write_data        ( obuf_write_data   )
        `ifdef DEBUG
        , .pe_update            ( update            )
        , .pe_c_addr            ( pe_c_addr         )
        , .pe_sel               ( pe_sel            )
        , .pe_out_10            ( pe_out_10         )     
        , .pe_Bin_10            ( pe_Bin_10         )
        , .pe_nextB_10          ( pe_nextB_10       )
        , .pe_acc_valid_10      ( pe_acc_valid_10   )
        , .pe_Aload_10          ( pe_Aload_10       )
        , .core_start           ( core_start        )
        , .vld_input_vld        ( input_vld         )
        , .vld_shif_vld         ( shif_vld          )

        , .pe_array_acc_in_1    ( pe_array_acc_in_1 )
        , .pe_array_acc_out_1   ( pe_array_acc_out_1)
        `endif
    );



    initial begin

        $dumpfile("pe_arr.dump");
        $dumpvars(0, pe_arr_tb);

        ibuf_read_data = {$random(), $random(), $random(), $random()}; //ibuf/fbuf should be ready when enable is high
        fbuf_read_data = 128'h11111111111111111111111111111111;

        clk         = 0;
        reset       = 1;
        enable      = 0;
        start       = 0;

        count       = 'b0;

        #2 reset    = 0;
        #4 enable   = 1; //rise with posedge clk

        #1000 $finish;


    end

    always #2 clk = ~clk;


    always @( posedge clk ) begin
        if ( ~enable )
            count <= 'b0;
        // else if ( count == NUM_KERNEL - 1 ) 
        //     start = 1;
        else if ( count == NUM_DATA - 1 )
            count <= 'b0;
        else
            count <= count + 1;


        if ( enable & ~start)
            ibuf_read_data <= {$random(), $random(), $random(), $random()};
        else if ( count == NUM_DATA -1 )
            ibuf_read_data <= {$random(), $random(), $random(), $random()};
        else begin
            ibuf_read_data <= ibuf_read_data;
        end
        
            
    end

endmodule