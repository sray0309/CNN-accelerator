module test;
    parameter integer NUM_DATA          = 4;
    parameter integer DATA_WIDTH        = 8;     
    parameter integer BUF_WIDTH         = NUM_DATA * DATA_WIDTH;    

    reg                                     clk, enable;
    reg  [ BUF_WIDTH            - 1 : 0 ]   input_data;
    wire [ BUF_WIDTH            - 1 : 0 ]   out;

    signed_adder #(
        .NUM_ADD            ( NUM_DATA      ),
        .DATA_WIDTH         ( DATA_WIDTH    )
    ) sa(
        .enable             ( enable        ),
        .ibus_read_data     ( input_data    ),
        .obus_write_data    ( out           )
    );

    initial begin
        clk         = 0;
        enable      = 0;

        #4 enable   = 1;

        #100 $finish;
    end

    always #2 clk = ~clk;

    always @( posedge clk ) begin
        input_data = {$random(), $random()};
    end

    always @( negedge clk ) begin
        $display("enable:%b, A:%d, B:%d, C:%d, D:%d", enable,
                        input_data[0*DATA_WIDTH+:DATA_WIDTH],
                        input_data[1*DATA_WIDTH+:DATA_WIDTH],
                        input_data[2*DATA_WIDTH+:DATA_WIDTH],
                        input_data[3*DATA_WIDTH+:DATA_WIDTH]);
        $display("output: %d", out);

    end

endmodule
