module signed_adder #(
    parameter integer   MAX_NUM_ADD     = 4,
    parameter integer   DATA_WIDTH      = 8,
    parameter integer   OUT_WIDTH       = 16,
    
    parameter integer   IBUS_WIDTH      = MAX_NUM_ADD * DATA_WIDTH,
    parameter integer   NUM_ADD_WIDTH   = $clog2(MAX_NUM_ADD) + 1
)(
    input   wire                                        enable,
    input   wire    [ NUM_ADD_WIDTH     - 1 : 0 ]       num_kernel,
    input   wire    [ IBUS_WIDTH        - 1 : 0 ]       ibus_read_data,

    output  wire    [ OUT_WIDTH         - 1 : 0 ]       obus_write_data
);
    wire    [ MAX_NUM_ADD       - 1 : 0 ]       _acc;

    genvar i;
    generate;
        for (i=0; i<MAX_NUM_ADD; i=i+1)
        begin: ADD_KERNEL
            wire signed     [ OUT_WIDTH         - 1 : 0 ]       a;
            wire signed     [ OUT_WIDTH         - 1 : 0 ]       b;
            wire signed     [ OUT_WIDTH         - 1 : 0 ]       c;

            if (i == 0)
                assign a = 0;
            else
                assign a = ADD_KERNEL[i - 1].c;
            assign b = i >= num_kernel ? 'b0 : ibus_read_data[DATA_WIDTH*i+:DATA_WIDTH];
            assign c = enable ? a + b : 'b0;
        end
    endgenerate
    assign obus_write_data = ADD_KERNEL[MAX_NUM_ADD - 1].c;
    
endmodule


// module test;
//     parameter integer MAX_NUM_ADD       = 8;
//     parameter integer DATA_WIDTH        = 8;     
//     parameter integer BUF_WIDTH         = MAX_NUM_ADD * DATA_WIDTH;    

//     reg                                     clk, enable;
//     reg  [ BUF_WIDTH            - 1 : 0 ]   input_data;
//     wire [ BUF_WIDTH            - 1 : 0 ]   out;

//     signed_adder #(
//         .MAX_NUM_ADD        ( MAX_NUM_ADD   ),
//         .DATA_WIDTH         ( DATA_WIDTH    )
//     ) sa(
//         .enable             ( enable        ),
//         .num_kernel         ( 2             ),
//         .ibus_read_data     ( input_data    ),
//         .obus_write_data    ( out           )
//     );

//     initial begin
//         clk         = 0;
//         enable      = 0;
//         input_data  = {$random(), $random()};

//         @(posedge clk);
//         enable      = 1;
//         @(posedge clk);
//         @(posedge clk);
//         enable      = 0;

//         #100 $finish;
//     end

//     always #2 clk = ~clk;

//     always @( negedge clk ) begin
//         $display("enable:%b, A:%d, B:%d, C:%d, D:%d", enable,
//                         input_data[0*DATA_WIDTH+:DATA_WIDTH],
//                         input_data[1*DATA_WIDTH+:DATA_WIDTH],
//                         input_data[2*DATA_WIDTH+:DATA_WIDTH],
//                         input_data[3*DATA_WIDTH+:DATA_WIDTH]);
//         $display("output: %d", out);

//     end

// endmodule
