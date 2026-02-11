// 8 bit shift register that outputs rden for the fifos
// q[0] outputs rden for the 0th fifo, q[1] for the 1st fifo, etc.

module shiftReg(
    input  logic       clk,
    input  logic       rst_n,
    input  logic       shift_in,
    input  logic       en,
    output logic [7:0] q
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 8'b0;
        end else if (en) begin
            q <= {q[6:0], shift_in};
        end
    end

endmodule