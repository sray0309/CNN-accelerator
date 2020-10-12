module pe_decoder #(
    parameter integer   FILTERNUM_WIDTH             = $clog2(MAX_FILTERNUM) + 1,
    parameter integer   KERNELNUM_WIDTH             = $clog2(MAX_KERNELNUM) + 1,
    parameter integer   MAX_FILTERNUM               = 64,
    parameter integer   MAX_KERNELNUM               = 8,
    parameter integer   MAX_ROW_NUM                 = 8
    ) (
        input    [ FILTERNUM_WIDTH   - 1 : 0 ]      filter_cnt,       // from controller, showing the index of filter to be load           
        input                                       filter_load,       // "0" for load, "1" for compute
        input    [ FILTERNUM_WIDTH   - 1 : 0 ]      num_filter, // total number of filter to be used in pe_array
        input    [ KERNELNUM_WIDTH   - 1 : 0 ]      num_kernel, // total number of kernel to be used
        
        output   reg [ MAX_FILTERNUM     - 1 : 0 ]      filter_addr       // output of decoded filter_cnt, to enable one pe in pe_array
    );

        // reg     [ FILTERNUM_WIDTH   - 1 : 0 ]       cnt;
        reg     [  MAX_ROW_NUM  - 1 : 0 ]           num_row_target; // target filter size in y dimentsion
        reg     [  MAX_ROW_NUM  - 1 : 0 ]           cnt_row;
        reg     [  KERNELNUM_WIDTH -1 : 0 ]         cnt_kernel;

    always @ (posedge filter_load) begin
        num_row_target  =   num_filter/num_kernel;
        filter_addr <= 1;
    end

    always @ (filter_cnt)
    begin
        if (~filter_load || (cnt_row == num_row_target && cnt_kernel == num_kernel-1))
        begin
            cnt_row <= 1;
            cnt_kernel <= 0;
            filter_addr <= 0;
        end
    
        else if  (cnt_kernel == num_kernel-1) begin
                cnt_kernel <= 0;
                filter_addr <= (1 << (MAX_KERNELNUM * cnt_row));
                cnt_row <= cnt_row + 1;
            end
        else begin
                filter_addr <= filter_addr << 1;
                cnt_kernel <= cnt_kernel + 1;
        end 
        
    end

endmodule