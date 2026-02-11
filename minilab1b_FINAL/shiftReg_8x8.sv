// 8x8 shift register that outputs 8 bits of b (the vector) to the MAC unit
// the first clock cycle it outputs the first 8 bits of b to the first MAC, second those 8 bits go to the second MAC
// (A10 * B00), and the second 8 bits should be shifted into q[0] to output to the first MAC again (A10 * B01)

module shiftReg_8x8(
    input logic clk,
    input logic rst_n,
    input logic [7:0] shift_in,
    input logic en,
    output logic [7:0] q [7:0]
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q[0] <= 8'b0;
            q[1] <= 8'b0;
            q[2] <= 8'b0;
            q[3] <= 8'b0;
            q[4] <= 8'b0;
            q[5] <= 8'b0;
            q[6] <= 8'b0;
            q[7] <= 8'b0;
        end    
        else if (en) begin
            q[0] <= shift_in;
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2];
            q[4] <= q[3];
            q[5] <= q[4];
            q[6] <= q[5];
            q[7] <= q[6];
        end
    end
endmodule