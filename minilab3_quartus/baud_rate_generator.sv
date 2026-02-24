module baud_rate_generator(
    input  logic       clk,
    input  logic       rst,         //active low
    input  logic [1:0] ioaddr,
    input  logic [7:0] databus,
    output logic       br_en
    );

    localparam LOAD_NEW_DATA     = 1'b0;
    localparam COUNT_DOWN        = 1'b1;

    logic        state;
    logic [15:0] divisor_buffer;
    logic [15:0] divisor_buffer_old;
    logic [15:0] counter;
    logic        reload;

    
    assign divisor_buffer = (ioaddr == 2'b10) ? {divisor_buffer_old[15:8], databus}
                                              : (ioaddr == 2'b11) ? {databus, divisor_buffer_old[7:0]}
                                                                  : divisor_buffer_old;

    always @(posedge clk) begin
        divisor_buffer_old <= divisor_buffer;
    end

    always @(posedge clk) begin
        if(~rst) begin
            state   <= LOAD_NEW_DATA;
            counter <= 16'd0;
            reload  <= 1'b0;
            br_en   <= 1'b0;
        end else begin
            case(state)
                LOAD_NEW_DATA : begin
                    state <= (ioaddr == 2'b11) ? COUNT_DOWN : state;
                    counter <= divisor_buffer;
                end
                COUNT_DOWN : begin
                    counter <= reload ? divisor_buffer : (counter - 1'b1);
                    br_en <= (counter == 16'd0) ? 1'b1 : 1'b0;
                    reload <= (counter == 16'd0) ? 1'b1 : 1'b0;
                end
            endcase
        end
    end
endmodule