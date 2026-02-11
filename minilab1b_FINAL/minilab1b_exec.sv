module minilab1b_exec(
    input  logic        clk,
    input  logic        rst_n,
    output logic        done,
    output logic [23:0] result0,
    output logic [23:0] result1,
    output logic [23:0] result2,
    output logic [23:0] result3,
    output logic [23:0] result4,
    output logic [23:0] result5,
    output logic [23:0] result6,
    output logic [23:0] result7,
    output logic [1:0]  state_led
    );




localparam DATA_WIDTH = 8;
localparam DEPTH = 8;


localparam READ          = 2'b00;
localparam FILL_AND_EXEC = 2'b01;
localparam DONE          = 2'b10;

//=======================================================
//  REG/WIRE declarations
//=======================================================

logic [1:0] state;

// There will be a vector with 8 results (24 bits each)
//logic [DATA_WIDTH*3-1:0] result [7:0];

// read_mem signals
logic        rden_mem;
logic [63:0] matrix_a [7:0];
logic [63:0] vector_b;
logic [63:0] matrix_a_flop [7:0];
logic [63:0] vector_b_flop;
logic        read_done;

// matrix vector multiplication signals
logic        valid_matrix_data;
logic        mvm_done;
logic [23:0] mvm_result [7:0];

//=======================================================
//  Module instantiation
//=======================================================

read_mem read_mem(.clk(clk), .reset_n(rst_n), .rden(rden_mem), .matrix_a(matrix_a), .vector_b(vector_b), .read_done(read_done));

matrix_vector_multiplication mvm(.clk(clk), .rst_n(rst_n), .valid_data(valid_matrix_data),
                                 .matrix_a(matrix_a_flop), .vector_b(vector_b_flop), .mvm_done(mvm_done), .result(mvm_result));

//=======================================================
//  Structural coding
//=======================================================

always_ff @(posedge clk, negedge rst_n) begin
    if(~rst_n) begin
        state <= READ;
        state_led <= READ;
        rden_mem <= 1'b1;
        valid_matrix_data <= 1'b0;
        done <= 1'b0;

        result0 <= {(DATA_WIDTH*3){1'b0}};
        result1 <= {(DATA_WIDTH*3){1'b0}};
        result2 <= {(DATA_WIDTH*3){1'b0}};
        result3 <= {(DATA_WIDTH*3){1'b0}};
        result4 <= {(DATA_WIDTH*3){1'b0}};
        result5 <= {(DATA_WIDTH*3){1'b0}};
        result6 <= {(DATA_WIDTH*3){1'b0}};
        result7 <= {(DATA_WIDTH*3){1'b0}};

    end else begin
        case(state)
            READ : begin
                if(read_done) begin
                    state <= FILL_AND_EXEC;
                    state_led <= FILL_AND_EXEC;
                    rden_mem <= 1'b0;
                    valid_matrix_data <= 1'b1;
                    matrix_a_flop <= matrix_a;
                    vector_b_flop <= vector_b;
                end
            end
            FILL_AND_EXEC : begin
                if(mvm_done) begin
                    state <= DONE;
                    state_led <= DONE;
                end
            end
            DONE : begin
                done    <= 1'b1;
                result0 <= mvm_result[0];
                result1 <= mvm_result[1];
                result2 <= mvm_result[2];
                result3 <= mvm_result[3];
                result4 <= mvm_result[4];
                result5 <= mvm_result[5];
                result6 <= mvm_result[6];
                result7 <= mvm_result[7];
            end
        endcase
    end
end
endmodule