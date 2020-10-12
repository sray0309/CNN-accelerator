module last_adder#(
    parameter integer input_bits = 16,
    parameter integer output_bits = 16
)(
    input  wire signed [input_bits - 1 : 0 ]      in,
    input                                        clk,
    input                                        enable,
    input                                        reset,
    output wire  signed [output_bits - 1 : 0 ]    out
);

reg [output_bits - 1 : 0 ] out_buf;

always @(posedge clk)begin
    if (reset)begin
      out_buf <= 'h0000;
    end
    else begin 
    if (enable)
    out_buf <= out_buf + in;
    else out_buf <= out_buf; 
    end
end

assign out = out_buf;

endmodule