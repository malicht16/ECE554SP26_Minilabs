module simulation_tb();
    //global signals
    logic       clk;
    logic       rst;
    logic [1:0] br_cfg;
    logic [7:0] databus;

    //spart0 input signals
    logic       iocs0;
    logic       iorw0;
    logic [1:0] ioaddr0;
    logic       rxd0;
    
    //spart0 output signals
    logic       rda0;
    logic       tbr0;
    logic       txd0;

    //spart1 input signals
    logic       iocs1;
    logic       iorw1;
    logic [1:0] ioaddr1;
    logic       rxd1;

    //spart 1 output signals
    logic       rda1;
    logic       tbr1;
    logic       txd1;

    // outputs are rda, tbr, and txd
    spart spart0(.clk(clk), .rst(rst), .iocs(iocs0), .iorw(iorw0), .rda(rda0), .tbr(tbr0), .ioaddr(ioaddr0), .databus(databus), .txd(txd0), .rxd(rxd0));

    // outputs are iocs, iorw, ioaddr
    driver driver1(.clk(clk), .rst(rst), .br_cfg(br_cfg), .iocs(iocs1), .iorw(iorw1), .rda(rda1), .tbr(tbr1), .ioaddr(ioaddr1), .databus(databus));

    // outputs are rda, tbr, and txd
    spart spart1(.clk(clk), .rst(rst), .iocs(iocs1), .iorw(iorw1), .rda(rda1), .tbr(tbr1), .ioaddr(ioaddr1), .databus(databus), .txd(txd1), .rxd(rxd1));
endmodule