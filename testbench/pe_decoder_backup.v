`include "../verilog/counter.v"

module pe_decoder #(
    parameter integer   FILTERNUM_WIDTH             = $clog2(MAX_FILTERNUM) + 1,
    parameter integer   KERNELNUM_WIDTH             = $clog2(MAX_KERNELNUM) + 1,
    parameter integer   MAX_FILTERNUM               = 64,
    parameter integer   MAX_KERNELNUM               = 8
    ) (
        input   wire                                    clk,
        input   wire                                    reset,
        input   wire    [ FILTERNUM_WIDTH   - 1 : 0 ]   filter_cnt,       // from controller, showing the index of filter to be load           
        input   wire                                    filter_load,       // "0" for load, "1" for compute
        input   wire    [ FILTERNUM_WIDTH   - 1 : 0 ]   num_filter, // total number of filter to be used in pe_array
        input   wire    [ KERNELNUM_WIDTH   - 1 : 0 ]   num_kernel, // total number of kernel to be used
        
        output   reg [ MAX_FILTERNUM     - 1 : 0 ]      filter_addr       // output of decoded filter_cnt, to enable one pe in pe_array
    );

        reg     [ MAX_FILTERNUM         : 0 ]       addr;
        reg     [ KERNELNUM_WIDTH   - 1 : 0 ]       cnt_kernel;
        wire                                        vld;
        wire                                        counter_reset;
        wire    [ MAX_FILTERNUM         : 0 ]       _addr;

        always @(posedge clk) begin
            if (reset)
                addr <= 'b1;
            else
                addr <= {filter_addr, 1'b1};
        end

        counter #(.NUM_COUNT(MAX_KERNELNUM)) jump_ct(clk, reset | counter_reset, filter_load, cnt_kernel, vld);

        assign counter_reset = (cnt_kernel == num_kernel - 1) ? 1 : 0;
        assign _addr = addr << (MAX_KERNELNUM - num_kernel);
        assign filter_addr = filter_load ? ((cnt_kernel == num_kernel - 1) ? _addr[MAX_FILTERNUM:1] : addr << 1) : 'b0;

endmodule