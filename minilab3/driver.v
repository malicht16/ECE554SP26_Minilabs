//////////////////////////////////////////////////////////////////////////////////
// Company: UW-Madison
// Engineer: Madi Licht
// 
// Create Date:    2/17/2026
// Design Name: 
// Module Name:    driver 
// Project Name:   minilab3
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
module driver(
    input clk,
    input rst,
    input [1:0] br_cfg,
    output iocs,
    output iorw,
    input rda,
    input tbr,
    output [1:0] ioaddr,
    inout [7:0] databus
    );

    localparam SEND_LB         = 3'b000;
    localparam SEND_HB         = 3'b001;
    localparam WAIT_FOR_SIGNAL = 3'b010;
    localparam TRANSFER        = 3'b011;
    localparam RECEIVE         = 3'b100;

    
    reg  [2:0]  state;
    wire [15:0] divisor;
    reg  [7:0]  dataout;
    reg  [7:0]  stored_data;

    //iocs (chipselect) is always 1 in this driver as there is only one uart we are communicating with
    assign iocs = 1'b1;

    //get the divisor based on switches and their associated baud rates
    assign divisor = br_cfg[1] ? br_cfg[0] ? 16'd80    //11
                                           : 16'd162   //10
                               : br_cfg[0] ? 16'd325   //01
                                           : 16'd650;  //00

    //assign the tristate of databus
    assign databus = iorw ? 8'bz : dataout;

    always @(posedge clk) begin
        if(~rst) begin
            //set ioaddr to send the low byte of the divisor
            ioaddr <= 2'b10;
            dataout <= divisor[7:0]
            state <= SEND_LB;
            iorw <= 1'b0;
        end else begin
            case(state)
                SEND_LB : begin
                    //set ioaddr to send the high byte of the divisor
                    ioaddr <= 2'b11;
                    dataout <= divisor[15:8];
                    state <= SEND_HB;
                end
                SEND_HB : begin
                    ioaddr <= 2'b01;
                    dataout <= {6'd0, tbr, rda};
                    state <= WAIT_FOR_SIGNAL;
                    iorw <= 1'b1;
                end
                WAIT_FOR_SIGNAL : begin
                    state <= tbr ? TRANSFER
                                 : rda ? RECEIVE 
                                       : WAIT_FOR_SIGNAL;
                    ioaddr <= (tbr | rda) ? 2'b00 : ioaddr;
                    iorw <= tbr ? 1'b0 : iorw;
                end
                TRANSFER : begin
                    ioaddr <= 2'b01;
                    dataout <= stored_data;
                    state <= WAIT_FOR_SIGNAL;
                    iorw <= 1'b1;
                end
                RECEIVE : begin
                    ioaddr <= 2'b01;
                    stored_data <= databus;
                    state <= WAIT_FOR_SIGNAL;
                end
            endcase
        end
        
    end


endmodule
