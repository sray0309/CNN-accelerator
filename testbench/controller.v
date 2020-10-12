// `include "../verilog/register_sync.v"
module controller #(
    // parameter integer   MAX_FILTERNUM               = 8,
    parameter integer   MAX_KERNELNUM               = 8,
    // parameter integer   MAX_DATANUM                 = 16,
    // parameter integer   MAX_TIMESTEPNUM             = 90,

    parameter integer   FILTERNUM_WIDTH             = 8,
    parameter integer   KERNELNUM_WIDTH             = 8,
    parameter integer   DATANUM_WIDTH               = 8,
    parameter integer   TIMESTEP_WIDTH              = 8,

    parameter integer   ADDR_WIDTH                  = 10,
    parameter integer   DATA_RANGE                  = 100

)(
    input   wire                                    clk,
    input   wire                                    reset,
    input   wire                                    enable,
    input   wire    [ FILTERNUM_WIDTH   - 1 : 0 ]   num_filter,
    input   wire    [ KERNELNUM_WIDTH   - 1 : 0 ]   num_kernel,
    input   wire    [ DATANUM_WIDTH     - 1 : 0 ]   filter_length,
    input   wire    [ TIMESTEP_WIDTH    - 1 : 0 ]   num_total_conv,
    
    output  wire    [ FILTERNUM_WIDTH   - 1 : 0 ]   filter_cnt,
    output  wire    [ KERNELNUM_WIDTH   - 1 : 0 ]   kernel_cnt,
    output  wire    [ DATANUM_WIDTH     - 1 : 0 ]   cal_cnt,
    output  wire                                    filter_load,
    output  wire                                    input_load,
    output  wire                                    sys_start,
    output  wire                                    sum_timestep,
    output  wire                                    conv,

    output  wire    [ ADDR_WIDTH        - 1 : 0 ]   data_addr,
    output  wire    [ ADDR_WIDTH        - 1 : 0 ]   data_addr_n,
    output  wire    [ ADDR_WIDTH        - 1 : 0 ]   outmem_addr,
    output  wire                                    write_enable
);
    logic _write_enable;

    STATE   state, n_state;

    logic   [ FILTERNUM_WIDTH   - 1 : 0 ]   num_filter_cnt, n_num_filter_cnt;
    logic   [ KERNELNUM_WIDTH   - 1 : 0 ]   num_kernel_cnt, n_num_kernel_cnt;
    logic   [ DATANUM_WIDTH     - 1 : 0 ]   num_cal_cnt, n_num_cal_cnt;
    logic   [ TIMESTEP_WIDTH    - 1 : 0 ]   num_total_cnt, n_num_total_cnt;

    logic _sys_start;
    logic _filter_load, _input_load;
    logic _conv, _sum_timestep;
    logic LF;

    logic   [ ADDR_WIDTH        - 1 : 0 ]   data_addr;
    logic   [ ADDR_WIDTH        - 1 : 0 ]   data_addr_n;
    logic   [ ADDR_WIDTH        - 1 : 0 ]   _outmem_addr;
    logic   [ ADDR_WIDTH        - 1 : 0 ]   n_outmem_addr;  

    logic   [ FILTERNUM_WIDTH   - 1 : 0 ]   waddr;
    logic   [ $clog2(DATA_RANGE)- 1 : 0 ]   iaddr;
    logic   wvld;
    logic   ivld;

    counter #(.NUM_COUNT(DATA_RANGE)) wct(clk, reset, _filter_load, waddr, wvld);
    counter #(.NUM_COUNT(DATA_RANGE)) ict(clk, reset, _input_load, iaddr, ivld);
    
    assign data_addr_n = data_addr + 1;
    assign data_addr =  _filter_load ? waddr : (_input_load ? 100 + iaddr : 0);
    

    assign n_num_filter_cnt = (state == LOAD) ?  (num_filter_cnt == num_filter ? num_filter_cnt : num_filter_cnt + 1) : 0;
    assign n_num_kernel_cnt = (state == LOAD && ~LF) ?  (num_kernel_cnt == MAX_KERNELNUM ? num_kernel_cnt : num_kernel_cnt + 1) : 0;
    assign n_num_total_cnt  = (state == UPDATE) ?  num_total_cnt  + 1 : num_total_cnt;

    logic       cal_inc, cal_reset;
    assign cal_inc      = (state == CONV);
    assign cal_reset    = (state == UPDATE);
    assign n_num_cal_cnt = cal_inc ? num_cal_cnt + 1 : (cal_reset ? 0 : num_cal_cnt);



    always @(*) begin
        LF                              = 0;
        _conv                           = 0;
        _sum_timestep                   = 0;
        _sys_start                      = 0;
        _input_load                     = 0;
        _filter_load                    = 0;

        case(state)
            IDLE:begin
                if (enable) begin
                    n_state             = LOAD;
                end else begin
                    n_state             = IDLE;
                end
                _outmem_addr = 'b1111111111; 
                _write_enable = 1;
            end
            LOAD: begin
                if (num_filter_cnt == num_filter) begin
                    LF = 0;
                    if (num_kernel_cnt == MAX_KERNELNUM) begin
                        _input_load         = 0;
                    end else begin
                        _input_load        = 1;
                    end
                end else begin
                    LF = 1;
                    _filter_load        = 1;
                end

                if (num_filter_cnt == num_filter && num_kernel_cnt == MAX_KERNELNUM) begin
                    n_state             = CONV;
                end else begin
                    n_state             = LOAD;
                end
                _write_enable = 1;     
            end
            CONV: begin
                _sys_start              = 1;

                if (num_total_cnt == num_total_conv - 1) begin
                    _sys_start          = 0;
                    _conv               = 1;
                    n_state             = IDLE;
                end else if (num_cal_cnt == filter_length) begin
                    n_state             = UPDATE; 
                end else begin
                    n_state             = CONV;
                end
                _write_enable = 0; 
            end
            UPDATE: begin
                _sum_timestep           = 1;
                _input_load             = 1;
                n_state                 = CONV;
                n_outmem_addr           = _outmem_addr+1;
                _write_enable           = 1;
            end

        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;

            num_filter_cnt  <= #1 0;
            num_kernel_cnt  <= #1 0;
            num_total_cnt   <= #1 0;
            num_cal_cnt     <= #1 0;
            n_outmem_addr   <= #1 'b1111111111;
        end else begin
            state <= n_state;

            num_filter_cnt  <= #1 n_num_filter_cnt;
            num_kernel_cnt  <= #1 n_num_kernel_cnt;
            num_total_cnt   <= #1 n_num_total_cnt;
            num_cal_cnt     <= #1 n_num_cal_cnt;
            _outmem_addr    <= #1 n_outmem_addr;
        end
    end

    assign filter_cnt   = num_filter_cnt;
    assign kernel_cnt   = num_kernel_cnt;
    assign cal_cnt      = num_cal_cnt;
    assign sys_start    = _sys_start;
    assign input_load   = _input_load;
    assign filter_load  = _filter_load;
    assign sum_timestep = _sum_timestep;
    assign conv         = _conv;
    assign write_enable = _write_enable;
    assign outmem_addr = _outmem_addr;

    
endmodule


// module convtoller_testbench;

//     parameter integer   FILTERNUM_WIDTH             = 8;    //3
//     parameter integer   KERNELNUM_WIDTH             = 8;    //3
//     parameter integer   DATANUM_WIDTH               = 8;
//     parameter integer   TIMESTEP_WIDTH              = 8;    //7

//     reg                                             clk, reset, enable;
//     reg     [ FILTERNUM_WIDTH       - 1 : 0 ]       num_filter;
//     reg     [ KERNELNUM_WIDTH       - 1 : 0 ]       num_kernel;
//     reg     [ DATANUM_WIDTH         - 1 : 0 ]       filter_length;
//     reg     [ TIMESTEP_WIDTH        - 1 : 0 ]       num_total_conv;

    
//     wire    [ FILTERNUM_WIDTH       - 1 : 0 ]       filter_cnt;
//     wire    [ KERNELNUM_WIDTH       - 1 : 0 ]       kernel_cnt;
//     wire    [ DATANUM_WIDTH         - 1 : 0 ]       cal_cnt;
//     wire                                            sys_start;
//     wire                                            conv;
//     wire                                            filter_load;
//     wire                                            input_load;
//     wire                                            sum_timestep;


//     controller DUT(
//         .clk                            ( clk               ),        
//         .reset                          ( reset             ),        
//         .enable                         ( enable            ),        
//         .num_filter              ( num_filter ),        
//         .num_kernel              ( num_kernel ),        
//         .filter_length                  ( filter_length     ),    
//         .num_total_conv                 ( num_total_conv    ),

//         .filter_cnt                     ( filter_cnt        ),
//         .kernel_cnt                     ( kernel_cnt        ),
//         .cal_cnt                        ( cal_cnt           ),
//         .sys_start                      ( sys_start         ),
//         .conv                           ( conv              ),
//         .filter_load                    ( filter_load       ),
//         .input_load                     ( input_load        ),
//         .sum_timestep                   ( sum_timestep      )

//     );

//     initial begin
//         $dumpfile("controller.dump");
//         $dumpvars(0, convtoller_testbench);
//         clk         = 0;
//         reset       = 1;
//         enable      = 0;

//         num_filter   = 64;
//         num_kernel   = 8;
//         filter_length       = 16;
//         num_total_conv      = 16;
        
//         @(negedge clk);
//         reset       = 0;
//         @(negedge clk);
//         @(negedge clk);
//         enable      = 1;

//         #2000 $finish;
//     end


//     always #2 clk = ~clk;

//     always @(posedge clk) begin
//         if (conv)
//             enable <=  0;
//     end

// endmodule
