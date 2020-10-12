module pe_decoder_testbench;

    parameter integer   FILTERNUM_WIDTH             = $clog2(MAX_FILTERNUM) + 1;
    parameter integer   KERNELNUM_WIDTH             = $clog2(MAX_KERNELNUM) + 1;
    parameter integer   MAX_FILTERNUM               = 64;
    parameter integer   MAX_KERNELNUM               = 8;
    parameter integer   MAX_ROW_NUM                 = 8;

    reg    [ FILTERNUM_WIDTH   - 1 : 0 ]      filter_cnt;       // from controller, showing the index of filter to be load           
    reg                                       filter_load;       // "0" for load, "1" for compute
    reg    [ FILTERNUM_WIDTH   - 1 : 0 ]      num_filter; // total number of filter to be used in pe_array
    reg    [ KERNELNUM_WIDTH   - 1 : 0 ]      num_kernel; // total number of kernel to be used
    reg     clk, reset;
    wire   [ MAX_FILTERNUM     - 1 : 0 ]      filter_addr  ;

    pe_decoder DUT(
        .clk                        ( clk               ),
        .reset                      ( reset             ),
        .filter_cnt                 ( filter_cnt        ), //pe id to be decoded 
        .filter_load                ( filter_load       ), //when filter_load is high, no pe addr is seleced  
        .num_filter                 ( num_filter        ), //total number of PEs
        .num_kernel                 ( num_kernel        ),
        .filter_addr                ( filter_addr       )  //decoded pe addr
    );

    initial begin
        $dumpfile("pe_decoder.dump");
        $dumpvars(0, pe_decoder_testbench);
        filter_cnt  =   0;
        filter_load =   0;
        num_filter  =   32;
        num_kernel  =   4;
        clk         =   0;
        reset       =   1;
        @(negedge clk);
        reset       =   0;
        @(negedge clk);
        @(negedge clk);
        filter_load =   1;
        
        #1000 $finish;
    end

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (filter_cnt == num_filter)
            filter_cnt <= 0;

        else begin
        filter_cnt <= filter_cnt + 1;
        $display("add: %b", filter_addr);
        end
    end

endmodule