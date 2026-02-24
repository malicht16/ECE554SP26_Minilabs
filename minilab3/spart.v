//////////////////////////////////////////////////////////////////////////////////
// Company: UW-Madison
// Engineer: Madi Licht
// 
// Create Date:   
// Design Name: 
// Module Name:    spart 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spart(
    input clk,
    input rst,
    input iocs,
    input iorw,
    output rda,
    output tbr,
    input [1:0] ioaddr,
    inout [7:0] databus,
    output txd,
    input rxd
    );

    wire [7:0] databus_bus_int;
    wire       br_en;
    wire [7:0] receiver_databus;
    wire [7:0] bus_int_input_data;

    assign bus_int_input_data = ((ioaddr == 2'b00) & iorw) ? receiver_databus : databus;
    assign databus = ((ioaddr == 2'b00) & iorw) ? databus_bus_int : 8'bz;

    bus_interface bus_inst(.databus(databus_bus_int), .rec_buffer(bus_int_input_data), .ioaddr(ioaddr), .rda(rda), .tbr(tbr), .iocs(iocs), .iorw(iorw));
    baud_rate_generator brg_inst(.clk(clk), .rst(rst), .ioaddr(ioaddr), .databus(databus_bus_int), .br_en(br_en));
    transmitter transmitter_inst(.clk(clk), .reset(~rst), .baud_rate_generator(br_en), 
                                 .transmit_enable(~iorw), .ioaddr(ioaddr), .transmit_buffer(databus_bus_int), .TBR(tbr), .TxD(txd));
    receiver receiver_inst(.clk(clk), .reset(~rst), .RxD(rxd), .baud_rate_generator(br_en), .receiver_buffer(receiver_databus), .RDA(rda));

endmodule
