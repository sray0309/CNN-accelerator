module shifter #(
    parameter integer   WIDTH           = 16
)(
    input   wire                            clk,
    input   wire                            reset,
    input   wire                            enable,

    output  wire    [ WIDTH     - 1 : 0]    shifout,
    output  wire                            vld
);

    reg [ WIDTH          : 0 ]  shifout_reg;
    reg                         vld_reg;       

    always @ ( posedge clk ) begin
        if ( reset ) begin
            shifout_reg <= 'b1;
            vld_reg <= 0;
        end else if ( ~enable ) begin
            shifout_reg <= 'b1;
            vld_reg = 0;
        end else
            shifout_reg <= shifout_reg << 1;
    end

    assign shifout = shifout_reg[WIDTH:1];

    always @( posedge shifout_reg[WIDTH], posedge reset) begin
        if ( reset )
            vld_reg <= 0;
        else if ( shifout_reg[WIDTH] )
            vld_reg <= 1;
        else
            vld_reg <= vld_reg;
    end
    assign vld = vld_reg;

endmodule


// module test;

//     parameter integer ARRAY_M = 8;
//     parameter integer ARRAY_N = 4;


//     reg                                     clk, reset, enable;
//     wire [ ARRAY_M * ARRAY_N     - 1 : 0 ]   out;

//     shifter #(.WIDTH(ARRAY_M * ARRAY_N)) shif(
//         .clk            ( clk       ),
//         .reset          ( reset     ),
//         .enable         ( enable    ),
//         .shifout        ( out       )
//     );

//     initial begin
//         clk         = 0;
//         reset       = 1;
//         enable      = 0;

//         #2 reset    = 0;
//         #2 enable   = 1;

//         #100 $finish;
//     end

//     always #2 clk = ~clk;

//     always @( negedge clk ) begin
//       $display("out: %b", out);

//     end

// endmodule

