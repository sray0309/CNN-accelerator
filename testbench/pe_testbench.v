module  pe_testbench();
    parameter integer   FILTER_WIDTH        = 8;
    parameter integer   INPUT_WIDTH         = 8;
    parameter integer   MULT_WIDTH          = FILTER_WIDTH + INPUT_WIDTH;
    parameter integer   PE_OUT_WIDTH        = 24;
    parameter integer   NUM_DATA            = 16;
    
    logic                                   clk,start,reset,Aload;
    logic     [FILTER_WIDTH*NUM_DATA-1:0]   A;
    logic     [INPUT_WIDTH    -1:0]         B;
    logic     [PE_OUT_WIDTH   -1:0]         Y;
    logic                                   acc_valid;
    /*test output*/
    // logic     [INPUT_WIDTH    -1:0]         TEST_INPUT;
    // logic     [FILTER_WIDTH   -1:0]         TEST_FILTER;
    // logic      [MULT_WIDTH    -1:0]         mult;
    integer i;

always begin
    #5 clk = !clk;
end

initial begin
    $dumpfile("pe.dump");
    $dumpvars(0, pe_testbench);

    clk     = 0;
    reset   = 1;
    start   = 0;
    Aload   = 0;
    A       = 128'h11111111111111111111111111111111;
    B       = 8'h01;
    @(posedge clk);
    reset = 0;
    @(posedge clk);
    Aload = 1;
    @(posedge clk);
    Aload = 0;
    @(posedge clk);

    for (i=0; i<64; i=i+1) begin
        @(posedge clk);
    end

    start = 1;
    
    #1000 $finish;
end

// always @(posedge clk) begin
//     #10 B = B + 8'h01;
// end

pe DUT(
    .clk(clk),
    .Aload(Aload),
    .start(start),
    .reset(reset),
    .A(A),
    .B(B),
    .Y(Y),
    // .Minput(TEST_INPUT),
    // .Mfilter(TEST_FILTER),
    // ._mult(mult),
    .acc_valid(acc_valid)
);

endmodule
