module counter #(
    parameter integer NUM_COUNT         = 16,
    parameter integer COUNTER_WIDTH     = $clog2(NUM_COUNT)
)( 
    input   wire                                clk,
    input   wire                                reset,
    input   wire                                enable,
    output  wire   [ COUNTER_WIDTH - 1 : 0 ]    out,
    output  wire                                vld               
);

    reg [ COUNTER_WIDTH     - 1 : 0 ]   counter;
    always @( posedge clk ) begin
        if ( reset )
            counter <= 'b0;
        else if ( enable )
            counter <= counter + 1;
        else
            counter <= counter;
    end

    assign vld = counter == NUM_COUNT-1 ? 1'b1 : 1'b0;
    assign out = counter;
    
endmodule


// module test;

// parameter integer NUM_TOTAL     = 8;

// reg     clk, reset, enable;
// wire    vld;

// counter #(.NUM_COUNT(8)) ct(
//     .clk(clk),
//     .reset(reset),
//     .enable(enable),
//     .vld(vld)
// );

// always #2 clk = ~clk;

// initial begin
//     clk = 0;
//     reset = 1;
//     enable = 0;
    
//     #4 reset = 2;
//     enable = 1;

//     #100 $finish;
// end

// always @(posedge clk) begin
//     $display("reset:%b enable: %b valid signal:%b", reset, enable, vld);
// end

// endmodule

