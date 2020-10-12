module test;

    logic [127:0] a;
    logic [127:0] b;

    logic signed [15:0] c;
    logic signed [15:0] o1;
    logic signed [15:0] o2;

    parameter DATA_WIDTH = 8;

    integer i;
    initial begin

        a = 'hF8F500EAFE03040702F6FD08E514F2F1;
        b = 'h8054F3251A0105060412FBFB0E0B05FF;
        c = 'h0;

        // for (i=0; i<16; i=i+1) begin
        //     o1 = a[i*DATA_WIDTH+:DATA_WIDTH];
        //     o2 = b[i*DATA_WIDTH+:DATA_WIDTH];
        //     // $display("a:%5.0x, b:%5.0x", a[i*DATA_WIDTH+:DATA_WIDTH], b[i*DATA_WIDTH+:DATA_WIDTH]);
        //     c = c + o1*o2;
        //     // $display("multi: %10.0x", a[i*DATA_WIDTH+:DATA_WIDTH] * b[i*DATA_WIDTH+:DATA_WIDTH]);
        //     $display("accu: %6x", c);
        // end

        o1 = 'h002EFD;
        o2 = 'hFFFBA9;
        c =o1+o2;
        $display("c:%6x", c);
    //FFFBA9
    //001599
    //000946
    //00101E
    end


endmodule