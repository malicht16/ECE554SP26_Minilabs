module simulation_tb();
    //global signals
    logic       clk;
    logic       rst;
    logic [1:0] br_cfg;

    //spart0 input signals
    logic       iocs0;
    logic       iorw0;
    logic [1:0] ioaddr0;
    
    //spart0 output signals
    logic       rda0;
    logic       tbr0;

    //spart1 input signals
    logic       iocs1;
    logic       iorw1;
    logic [1:0] ioaddr1;

    //spart 1 output signals
    logic       rda1;
    logic       tbr1;

    //transmit and receive signals
    logic       txd0_rxd1;
    logic       txd1_rxd0;


    //databus signals
    wire  [7:0] databus0;
    logic [7:0] databus0_driver;
    wire  [7:0] databus1;

    // outputs are rda, tbr, and txd
    spart spart0(.clk(clk), .rst(rst), .iocs(iocs0), .iorw(iorw0), .rda(rda0), .tbr(tbr0), .ioaddr(ioaddr0), .databus(databus0), .txd(txd0_rxd1), .rxd(txd1_rxd0));

    // outputs are iocs, iorw, ioaddr
    driver driver1(.clk(clk), .rst(rst), .br_cfg(br_cfg), .iocs(iocs1), .iorw(iorw1), .rda(rda1), .tbr(tbr1), .ioaddr(ioaddr1), .databus(databus1));

    // outputs are rda, tbr, and txd
    spart spart1(.clk(clk), .rst(rst), .iocs(iocs1), .iorw(iorw1), .rda(rda1), .tbr(tbr1), .ioaddr(ioaddr1), .databus(databus1), .txd(txd1_rxd0), .rxd(txd0_rxd1));

    assign databus0 = databus0_driver;

    initial begin
        //global declarations
        clk = 1'b0;
        rst = 1'b0;
        br_cfg = 2'b11;

        //chipselect for spart0
        iocs0 = 1'b1;

        //enables for spart0
        //write the baudrate
        iorw0 = 1'b0;

        @(posedge clk);
        //data for spart0
        ioaddr0 = 2'b10;
        databus0_driver = 8'b01010000;

        @(negedge clk);
        rst = 1'b1;

        @(posedge clk);
        ioaddr0 = 2'b11;
        databus0_driver = 8'b00000000;

        @(posedge clk);
        iorw0 = 1'b1;
        ioaddr0 = 2'b01;
        databus0_driver = 8'bz;

        //check to make sure baud rate generator shows up
        repeat(82) @(posedge clk);

        @(posedge clk);
        ioaddr0  <= 2'b00;
        iorw0    <= 1'b0;
        databus0_driver <= "A";

        @(posedge clk);
        ioaddr0  <= 2'b01;
        iorw0    <= 1'b1;
        databus0_driver <= 8'bz;

        repeat(1600) @(posedge clk);

        $stop();
    end

    always
        #5 clk = ~clk;

endmodule