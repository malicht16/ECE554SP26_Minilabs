module MAC #
(
    parameter DATA_WIDTH = 8
)
(
    input  logic clk,
    input  logic rst_n,
    input  logic En,
    input  logic Clr,
    input  logic [DATA_WIDTH-1:0] Ain,
    input  logic [DATA_WIDTH-1:0] Bin,
    input  logic finish_calc,
    output logic [DATA_WIDTH*3-1:0] Cout
);

    logic [DATA_WIDTH-1:0] correct_ain;
    logic [DATA_WIDTH-1:0] correct_bin;
    logic [DATA_WIDTH-1:0] new_ain;
    logic [DATA_WIDTH-1:0] new_bin;

    logic [DATA_WIDTH*2-1:0] product;
    logic [DATA_WIDTH*2-1:0] new_product;

    logic [DATA_WIDTH*3-1:0] accumulate;
    logic [DATA_WIDTH*3-1:0] new_accumulate;
    //logic [DATA_WIDTH*3-1:0] new_accumulate_rst;

    //assign Cout = new_accumulate;
    assign new_product = new_ain * new_bin;
    assign new_accumulate = accumulate + product;

    //assign new_ain = En ? Ain : '0;
    //assign new_bin = En ? Bin : '0;

    always_ff @ (posedge clk) begin
        if(!rst_n || Clr) begin
            product <= '0;
            accumulate <= '0;
            //new_accumulate_rst <= '0;
            Cout <= '0;
        end else if(En) begin
            new_ain <= Ain;
            new_bin <= Bin;
            product     <= new_product;
            accumulate <= new_accumulate;
            Cout <= new_accumulate;
        end else begin
            new_ain <= '0;
            new_bin <= '0;
            product <= new_product;
            accumulate <= ~finish_calc ? '0 : new_accumulate;
            Cout <= new_accumulate;
        end
    end

endmodule