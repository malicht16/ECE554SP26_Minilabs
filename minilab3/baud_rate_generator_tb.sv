module baud_rate_generator_tb();
    logic       clk;
    logic       rst;
    logic [1:0] ioaddr;
    logic [7:0] databus;
    logic       br_en;

    baud_rate_generator iDUT(.clk(clk), .rst(rst), .ioaddr(ioaddr), .databus(databus), .br_en(br_en));

    logic [15:0] divisor;

    initial begin
        clk = 1'b0;
        rst = 1'b0;

        //on the reset set the divisor to the baud rate of 38400
        divisor = 16'd80;

        ioaddr = 2'b10;
        databus = divisor[7:0];

        @(negedge clk);
        rst = 1'b1;
        ioaddr = 2'b11;
        databus = divisor[15:8];

        repeat(100) @(posedge clk);

        $stop();
    end

    always
        #5 clk = ~clk;

endmodule