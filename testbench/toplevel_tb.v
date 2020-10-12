`include "../verilog/Memory/Mem_cnnin/Mem_cnnin1.v"
`include "../verilog/Memory/Mem_cnnin/Mem_cnnin2.v"
`include "../verilog/Memory/Mem_cnnout/CNN_outMEM.v"
`include "../verilog/CNN_ROM1.v"
`include "../verilog/CNN_ROM2.v"
// `include "cnn_toplevel.v"

module toplevel_tb;

parameter integer   FILTERNUM_WIDTH             = 8;    //3
parameter integer   KERNELNUM_WIDTH             = 8;    //3
parameter integer   DATANUM_WIDTH               = 8;
parameter integer   TIMESTEP_WIDTH              = 8;    //7

logic     clk, reset, enable,conv;
logic     [ FILTERNUM_WIDTH       - 1 : 0 ]       num_filter;
logic     [ KERNELNUM_WIDTH       - 1 : 0 ]       num_kernel;
logic     [ DATANUM_WIDTH         - 1 : 0 ]       filter_length;
logic     [ TIMESTEP_WIDTH        - 1 : 0 ]       num_total_conv;
logic     [63:0]                                  mem_out;
logic     [9:0]                                   mem_addr_b;
logic                                             write_enable_b;

logic                                           write_enable_a;
logic [9:0]                                     outmem_addr;
// logic [63:0]                                    outmem_data;
// logic     [127:0]                                obuf_write_data;

// logic                                            inMEM_Write_en;
// logic      [9 : 0]                               inMEM_addr;
// logic      [63:0]                                inMEM_data1;
// logic      [63:0]                                inMEM_data2;

cnn_toplevel#() DUT(
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .num_filter(num_filter),
    .num_kernel(num_kernel),
    .filter_length(filter_length),
    .num_total_conv(num_total_conv),
    .mem_out(mem_out),
    .conv(conv),
    .write_enable_b(write_enable_b),
    .mem_addr_b(mem_addr_b),
    // .inMEM_Write_en(inMEM_Write_en),    
    // .inMEM_addr(inMEM_addr),
    // .inMEM_data1(inMEM_data1),
    // .inMEM_data2(inMEM_data2),

    .write_enable_a(write_enable_a),
    .outmem_addr(outmem_addr)
);


integer f;

    initial begin
        $dumpfile("toplevel.dump");
        $dumpvars(0, toplevel_tb);

        f = $fopen("output.txt", "w");

        

        clk         = 0;
        reset       = 1;
        enable      = 0;

        num_filter          = 32;
        num_kernel          = 4;
        filter_length       = 16;
        num_total_conv      = 16;
        write_enable_b = 0;
        mem_addr_b = 'b000000001;


        @(posedge clk);
        #1 reset       = 0;
        @(posedge clk);
        @(posedge clk);
        #1 enable      = 1;

        #5000
        mem_addr_b = 'b000000000;
        write_enable_b = 1;


        #1000 $fclose(f);
        $finish;
    end

    always #8 clk = ~clk;

    always @(posedge clk) begin
        if (conv)
            enable <=  0;
    end
endmodule