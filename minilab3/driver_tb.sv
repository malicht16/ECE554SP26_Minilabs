module driver_tb();

    
    logic       clk;
    logic       rst;        //active low
    logic [1:0] br_cfg;     //switches
    logic       iocs;       //output
    logic       iorw;       //output
    logic       rda;        //read data available
    logic       tbr;        //transfer buffer ready
    logic [1:0] ioaddr;     //output
    wire  [7:0] databus;    //inout

    driver driver_inst(.clk(clk), .rst(rst), .br_cfg(br_cfg), .iocs(iocs), .iorw(iorw), .rda(rda), .tbr(tbr), .ioaddr(ioaddr), .databus(databus));

    //can't assign databus a value so need to use the driver
    reg [7:0] databus_driver;
    assign databus = databus_driver;

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        databus_driver = 8'bz;

        //test no switches (baud rate 4800)
        br_cfg = 2'b00;
        rda    = 1'b0;
        tbr    = 1'b0;

        @(negedge clk);
        rst = 1'b1;

        //650 is 00000010_10001010
        if(databus != 8'b10001010) begin
            $display("incorrect low byte tranmitted");
        end
        if(ioaddr != 2'b10) begin
            $display("incorrect address being written to");
        end

        @(negedge clk);
        //650 is 00000010_10001010
        if(databus != 8'b00000010) begin
            $display("incorrect high byte tranmitted");
        end
        if(ioaddr != 2'b11) begin
            $display("incorrect address being written to");
        end

        @(negedge clk);
        if(ioaddr != 2'b01) begin
            $display("should be in status register waiting");
        end

        repeat(5) @(negedge clk);
        @(posedge clk)
        //set the driver to accept data
        rda = 1'b1;
        databus_driver = 8'b01010101;

        @(negedge clk);
        if(ioaddr != 2'b00) begin
            $display("incorrect ioaddr for a read");
        end
        if(driver_inst.stored_data != 8'b01010101) begin
            $display("incorrect stored data from bus");
        end

        @(posedge clk);
        //only sets for one cycle
        rda = 1'b0;
        databus_driver = 8'bz;


        repeat(5) @(negedge clk);
        @(posedge clk);
        tbr = 1'b1;

        @(negedge clk);
        if(ioaddr != 2'b00) begin
            $display("incorrect ioaddr for a write");
        end
        if(databus != 8'b01010101) begin
            $display("incorrect data on databus");
        end

        @(posedge clk);
        tbr = 1'b0;

        repeat(5) @(posedge clk);
        //test 1 switches (baud rate 9600)
        br_cfg = 2'b01;

        @(negedge clk);
        rst = 1'b0;

        @(negedge clk);
        rst = 1'b1;

        //325 is 00000001_01000101
        if(databus != 8'b01000101) begin
            $display("incorrect low byte tranmitted");
        end
        if(ioaddr != 2'b10) begin
            $display("incorrect address being written to");
        end

        @(negedge clk);
        //325 is 00000001_01000101
        if(databus != 8'b00000001) begin
            $display("incorrect high byte tranmitted");
        end
        if(ioaddr != 2'b11) begin
            $display("incorrect address being written to");
        end

        repeat(5) @(negedge clk);

        $stop();
    end

    always
        #5 clk = ~clk;

endmodule