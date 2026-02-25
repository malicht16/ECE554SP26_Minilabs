module driver_brg_busint_tb();

    //global data
    logic       clk;
    logic       rst;              //active low
    
    //output/input
    wire  [7:0] databus;
    reg   [7:0] databus_driver;

    // inputs to driver 
    logic [1:0] br_cfg;

    //inputs to driver and bus interface
    logic       rda;
    logic       tbr;

    //output of driver input to bus interface and baud rate
    logic       iocs;
    logic       iorw;
    logic [1:0] ioaddr;

    //bus interface signals
    wire  [7:0] databus_bus_int;

    //brg output
    logic br_en;

    //module instantiation
    driver driver_inst(.clk(clk), .rst(rst), .br_cfg(br_cfg), .iocs(iocs), .iorw(iorw), .rda(rda), .tbr(tbr), .ioaddr(ioaddr), .databus(databus));
    bus_interface bus_inst(.databus(databus_bus_int), .rec_buffer(databus), .ioaddr(ioaddr), .rda(rda), .tbr(tbr), .iocs(iocs), .iorw(iorw));
    baud_rate_generator brg_inst(.clk(clk), .rst(rst), .ioaddr(ioaddr), .databus(databus_bus_int), .br_en(br_en));

    assign databus = databus_driver;

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        databus_driver = 8'bz;

        //test both switches (baud rate 38400)
        br_cfg = 2'b11;
        rda    = 1'b0;
        tbr    = 1'b0;

        @(negedge clk);
        rst = 1'b1;

        repeat(100) @(negedge clk);

        $stop();
    end

    always
        #5 clk = ~clk;
    
endmodule