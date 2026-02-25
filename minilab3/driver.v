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
    input  wire       clk,
    input  wire       rst,              //active low
    input  wire [1:0] br_cfg,
    output wire       iocs,
    output reg        iorw,
    input  wire       rda,
    input  wire       tbr,
    output reg  [1:0] ioaddr,
    inout       [7:0] databus
    );

    localparam SEND_LB         = 3'b000;
    localparam SEND_HB         = 3'b001;
    localparam WAIT_FOR_SIGNAL = 3'b010;
    localparam TRANSMIT        = 3'b011;
    localparam RECEIVE         = 3'b100;

    
    reg  [2:0]  state;
    wire [15:0] divisor;
    reg  [7:0]  stored_data;
    reg  [7:0]  stored_data_old;
    reg         have_data_to_transmit;

    reg         iorw_flop;
    reg  [1:0]  ioaddr_flop;

    //iocs (chipselect) is always 1 in this driver as there is only one uart we are communicating with
    assign iocs = 1'b1;

    //get the divisor based on switches and their associated baud rates
    assign divisor = br_cfg[1] ? br_cfg[0] ? 16'd80    //11
                                           : 16'd162   //10
                               : br_cfg[0] ? 16'd325   //01
                                           : 16'd650;  //00

    //assign the tristate of databus
    assign databus = iorw ? 8'bz
                          : (ioaddr == 2'b10) ? divisor[7:0]                            //sending lowbyte
                                              : (ioaddr == 2'b11) ? divisor[15:8]       //sending highbyte
                                                                  : (state == 3'b011) ? stored_data   //transmit data previously received
                                                                                        : 8'd0;

    //if we are receiving data store the eight bits
    //assign stored_data = (state == 3'b100) ? databus : stored_data_old;
    //always @(posedge clk) begin
    //    if(~rst) begin
    //        stored_data_old <= 8'd0;
    //    end else begin
    //        stored_data_old <= stored_data;
    //    end
    //end

    //needed an immediate pulse whenever seeing the tbr and rda signals
    //assign iorw   = tbr ? 1'b0 : iorw_flop;
    //assign ioaddr = (tbr | rda) ? 2'b00 : ioaddr_flop;
    //assign ioaddr = ((tbr | rda) & (state == WAIT_FOR_SIGNAL)) ? 2'b00 : ioaddr_flop;

    always @(posedge clk) begin
        if(~rst) begin
            //set ioaddr to send the low byte of the divisor
            ioaddr <= 2'b10;
            //dataout <= divisor[7:0];
            state <= SEND_LB;
            iorw <= 1'b0;
            stored_data = 8'd0;
            have_data_to_transmit = 1'b0;
        end else begin
            case(state)
                SEND_LB : begin
                    //set ioaddr to send the high byte of the divisor
                    ioaddr <= 2'b11;
                    state <= SEND_HB;
                end
                SEND_HB : begin
                    ioaddr <= 2'b01;
                    state <= WAIT_FOR_SIGNAL;
                    iorw <= 1'b1;
                end
                WAIT_FOR_SIGNAL : begin
                    state <= (tbr & have_data_to_transmit) ? TRANSMIT
                                                           : rda ? RECEIVE 
                                                                 : WAIT_FOR_SIGNAL;
                    //ioaddr_flop <= 2'b01;
                    ioaddr <= ((tbr & have_data_to_transmit) | rda) ? 2'b00 : 2'b01;
                    //iorw_flop <= 1'b1;
                    iorw <= (tbr & have_data_to_transmit) ? 1'b0 : 1'b1;
                end
                TRANSMIT : begin
                    ioaddr <= 2'b01;
                    state <= WAIT_FOR_SIGNAL;
                    iorw <= 1'b1;
                    have_data_to_transmit <= 1'b0;
                end
                RECEIVE : begin
                    stored_data <= databus;
                    ioaddr <= 2'b01;
                    state <= WAIT_FOR_SIGNAL;
                    have_data_to_transmit <= 1'b1;
                end
            endcase
        end
        
    end


endmodule
