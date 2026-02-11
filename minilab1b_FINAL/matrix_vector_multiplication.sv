module matrix_vector_multiplication(
    input  logic         clk,
    input  logic         rst_n,
    input  logic         valid_data,
    input  logic [63:0]  matrix_a [7:0],
    input  logic [63:0]  vector_b,
    output logic         mvm_done,
    output logic [23:0]  result [7:0]
    );

    localparam DATA_WIDTH = 8;
    localparam DEPTH = 8;

    localparam IDLE = 3'b000;
    localparam FILL = 3'b001;
    localparam EXEC = 3'b010;
    localparam WAIT_FOR_MAC = 3'b011;
    localparam DONE = 3'b100;

    //=======================================================
    //  REG/WIRE declarations
    //=======================================================

    logic [2:0] state;

    // There are 9 data values going into and coming out of the fifos
    logic [DATA_WIDTH-1:0] datain [8:0];
    logic [DATA_WIDTH-1:0] dataout [8:0];
    logic [DATA_WIDTH-1:0] dataout_flop [8:0];

    // What index of the fifo is being filled
    logic [2:0] fill_index;

    // There will be a vector with 8 results (24 bits each)
    logic [DATA_WIDTH*3-1:0] macout [7:0];

    // Signals for all 8 fifos
    logic [8:0] wren;
    logic [8:0] full;
    logic [8:0] empty;

    // ShiftReg signals
    // Number to shift into the fifo(whenever fifo[0] is empty begin to fill it with 0)
    logic        shift_in_rden_fifo;
    // Should we begin shifting
    logic        shift_en;
    // 8 bit value to determine which flops should be read out of
    logic [7:0]  rden_fifo;
    logic [7:0]  rden_fifo_flop;

    //shiftReg_8x8 signals
    logic       shift_b_vector_en;
    logic [7:0] shifted_b_vector [7:0];
    logic [7:0] shifted_b_vector_flop [7:0];

    // Extra cycles for mac to finish
    logic [1:0] count_mac_cycles;

    logic [7:0] finish_calc;
    logic [7:0] finish_calc_early;

    //=======================================================
    //  Module instantiation
    //=======================================================

    genvar i;

    generate
      for (i=0; i<8; i=i+1) begin : fifo_gen
        FIFO
        #(
        .DEPTH(DEPTH),
        .DATA_WIDTH(DATA_WIDTH)
        ) input_fifo
        (
        .clk(clk),
        .rst_n(rst_n),
        .rden(rden_fifo[i]),
        .wren(wren[i]),
        .i_data(datain[i]),
        .o_data(dataout[i]),
        .full(full[i]),
        .empty(empty[i])
        );
      end
    endgenerate

    FIFO
    #(
    .DEPTH(DEPTH),
    .DATA_WIDTH(DATA_WIDTH)
    ) vector_b_fifo
    (
    .clk(clk),
    .rst_n(rst_n),
    .rden(rden_fifo[0]),
    .wren(wren[8]),
    .i_data(datain[8]),
    .o_data(dataout[8]),
    .full(full[8]),
    .empty(empty[8])
    );

    MAC #(.DATA_WIDTH(DATA_WIDTH)) mac0
    (
    .clk(clk),
    .rst_n(rst_n),
    .En(rden_fifo_flop[0]),
    .Clr(1'b0),
    .Ain(dataout_flop[0]),
    .Bin(dataout_flop[8]),
    .finish_calc(finish_calc_early[0]),
    .Cout(macout[0])
    );

    MAC #(.DATA_WIDTH(DATA_WIDTH)) mac1
    (
    .clk(clk),
    .rst_n(rst_n),
    .En(rden_fifo_flop[1]),
    .Clr(1'b0),
    .Ain(dataout_flop[1]),
    .Bin(shifted_b_vector[0]),
    .finish_calc(finish_calc_early[1]),
    .Cout(macout[1])
    );

    MAC #(.DATA_WIDTH(DATA_WIDTH)) mac2
    (
    .clk(clk),
    .rst_n(rst_n),
    .En(rden_fifo_flop[2]),
    .Clr(1'b0),
    .Ain(dataout_flop[2]),
    .Bin(shifted_b_vector[1]),
    .finish_calc(finish_calc_early[2]),
    .Cout(macout[2])
    );

    MAC #(.DATA_WIDTH(DATA_WIDTH)) mac3
    (
    .clk(clk),
    .rst_n(rst_n),
    .En(rden_fifo_flop[3]),
    .Clr(1'b0),
    .Ain(dataout_flop[3]),
    .Bin(shifted_b_vector[2]),
    .finish_calc(finish_calc_early[3]),
    .Cout(macout[3])
    );

    MAC #(.DATA_WIDTH(DATA_WIDTH)) mac4
    (
    .clk(clk),
    .rst_n(rst_n),
    .En(rden_fifo_flop[4]),
    .Clr(1'b0),
    .Ain(dataout_flop[4]),
    .Bin(shifted_b_vector[3]),
    .finish_calc(finish_calc_early[4]),
    .Cout(macout[4])
    );

    MAC #(.DATA_WIDTH(DATA_WIDTH)) mac5
    (
    .clk(clk),
    .rst_n(rst_n),
    .En(rden_fifo_flop[5]),
    .Clr(1'b0),
    .Ain(dataout_flop[5]),
    .Bin(shifted_b_vector[4]),
    .finish_calc(finish_calc_early[5]),
    .Cout(macout[5])
    );

    MAC #(.DATA_WIDTH(DATA_WIDTH)) mac6
    (
    .clk(clk),
    .rst_n(rst_n),
    .En(rden_fifo_flop[6]),
    .Clr(1'b0),
    .Ain(dataout_flop[6]),
    .Bin(shifted_b_vector[5]),
    .finish_calc(finish_calc_early[6]),
    .Cout(macout[6])
    );

    MAC #(.DATA_WIDTH(DATA_WIDTH)) mac7
    (
    .clk(clk),
    .rst_n(rst_n),
    .En(rden_fifo_flop[7]),
    .Clr(1'b0),
    .Ain(dataout_flop[7]),
    .Bin(shifted_b_vector[6]),
    .finish_calc(finish_calc_early[7]),
    .Cout(macout[7])
    );

    shiftReg shiftReg_en(.clk(clk), .rst_n(rst_n), .shift_in(shift_in_rden_fifo_early), .en(shift_en), .q(rden_fifo));

    shiftReg_8x8 shift_b_vector(.clk(clk), .rst_n(rst_n), .shift_in(dataout_flop[8]), .en(shift_b_vector_en), .q(shifted_b_vector));

    //=======================================================
    //  Structural coding
    //=======================================================
    
    //assign all wren when we are in the fill state
    assign wren[8:0] = {9{state == FILL}};

    //shift in a 0 as soon as empty[0]
    assign shift_in_rden_fifo_early = empty[0] ? 1'b0 : shift_in_rden_fifo;

    assign finish_calc_early[0] = empty[0] ? 1'b1 : finish_calc[0];
    assign finish_calc_early[1] = empty[1] ? 1'b1 : finish_calc[1];
    assign finish_calc_early[2] = empty[2] ? 1'b1 : finish_calc[2];
    assign finish_calc_early[3] = empty[3] ? 1'b1 : finish_calc[3];
    assign finish_calc_early[4] = empty[4] ? 1'b1 : finish_calc[4];
    assign finish_calc_early[5] = empty[5] ? 1'b1 : finish_calc[5];
    assign finish_calc_early[6] = empty[6] ? 1'b1 : finish_calc[6];
    assign finish_calc_early[7] = empty[7] ? 1'b1 : finish_calc[7];

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            state <= IDLE;
            fill_index <= 3'd0;

            result[0] <= {(DATA_WIDTH*3){1'b0}};
            result[1] <= {(DATA_WIDTH*3){1'b0}};
            result[2] <= {(DATA_WIDTH*3){1'b0}};
            result[3] <= {(DATA_WIDTH*3){1'b0}};
            result[4] <= {(DATA_WIDTH*3){1'b0}};
            result[5] <= {(DATA_WIDTH*3){1'b0}};
            result[6] <= {(DATA_WIDTH*3){1'b0}};
            result[7] <= {(DATA_WIDTH*3){1'b0}};

            shift_in_rden_fifo <= 1'b1;
            shift_en <= 1'b0;

            shift_b_vector_en <= 1'b0;

            mvm_done <= 1'b0;

            count_mac_cycles <= 2'b00;

            finish_calc <= 1'b0;
        end else begin
            case(state)
                IDLE : begin
                    if(valid_data) begin
                        state <= FILL;

                        datain[0] <= matrix_a[0][7:0];
                        datain[1] <= matrix_a[1][7:0];
                        datain[2] <= matrix_a[2][7:0];
                        datain[3] <= matrix_a[3][7:0];
                        datain[4] <= matrix_a[4][7:0];
                        datain[5] <= matrix_a[5][7:0];
                        datain[6] <= matrix_a[6][7:0];
                        datain[7] <= matrix_a[7][7:0];

                        datain[8] <= vector_b[7:0];
                    end
                end
                FILL : begin
                    if(full == 9'b1_1111_1111) begin
                        state <= EXEC;
                        shift_en <= 1'b1;
                    end else if(fill_index == 3'd0) begin
                        datain[0] <= matrix_a[0][15:8];
                        datain[1] <= matrix_a[1][15:8];
                        datain[2] <= matrix_a[2][15:8];
                        datain[3] <= matrix_a[3][15:8];
                        datain[4] <= matrix_a[4][15:8];
                        datain[5] <= matrix_a[5][15:8];
                        datain[6] <= matrix_a[6][15:8];
                        datain[7] <= matrix_a[7][15:8];

                        datain[8] <= vector_b[15:8];

                    end else if(fill_index == 3'd1) begin
                        datain[0] <= matrix_a[0][23:16];
                        datain[1] <= matrix_a[1][23:16];
                        datain[2] <= matrix_a[2][23:16];
                        datain[3] <= matrix_a[3][23:16];
                        datain[4] <= matrix_a[4][23:16];
                        datain[5] <= matrix_a[5][23:16];
                        datain[6] <= matrix_a[6][23:16];
                        datain[7] <= matrix_a[7][23:16];

                        datain[8] <= vector_b[23:16];

                    end else if(fill_index == 3'd2) begin
                        datain[0] <= matrix_a[0][31:24];
                        datain[1] <= matrix_a[1][31:24];
                        datain[2] <= matrix_a[2][31:24];
                        datain[3] <= matrix_a[3][31:24];
                        datain[4] <= matrix_a[4][31:24];
                        datain[5] <= matrix_a[5][31:24];
                        datain[6] <= matrix_a[6][31:24];
                        datain[7] <= matrix_a[7][31:24];

                        datain[8] <= vector_b[31:24];

                    end else if(fill_index == 3'd3) begin
                        datain[0] <= matrix_a[0][39:32];
                        datain[1] <= matrix_a[1][39:32];
                        datain[2] <= matrix_a[2][39:32];
                        datain[3] <= matrix_a[3][39:32];
                        datain[4] <= matrix_a[4][39:32];
                        datain[5] <= matrix_a[5][39:32];
                        datain[6] <= matrix_a[6][39:32];
                        datain[7] <= matrix_a[7][39:32];

                        datain[8] <= vector_b[39:32];

                    end else if(fill_index == 3'd4) begin
                        datain[0] <= matrix_a[0][47:40];
                        datain[1] <= matrix_a[1][47:40];
                        datain[2] <= matrix_a[2][47:40];
                        datain[3] <= matrix_a[3][47:40];
                        datain[4] <= matrix_a[4][47:40];
                        datain[5] <= matrix_a[5][47:40];
                        datain[6] <= matrix_a[6][47:40];
                        datain[7] <= matrix_a[7][47:40];

                        datain[8] <= vector_b[47:40];

                    end else if(fill_index == 3'd5) begin
                        datain[0] <= matrix_a[0][55:48];
                        datain[1] <= matrix_a[1][55:48];
                        datain[2] <= matrix_a[2][55:48];
                        datain[3] <= matrix_a[3][55:48];
                        datain[4] <= matrix_a[4][55:48];
                        datain[5] <= matrix_a[5][55:48];
                        datain[6] <= matrix_a[6][55:48];
                        datain[7] <= matrix_a[7][55:48];

                        datain[8] <= vector_b[55:48];

                    end else if(fill_index == 3'd6) begin
                        datain[0] <= matrix_a[0][63:56];
                        datain[1] <= matrix_a[1][63:56];
                        datain[2] <= matrix_a[2][63:56];
                        datain[3] <= matrix_a[3][63:56];
                        datain[4] <= matrix_a[4][63:56];
                        datain[5] <= matrix_a[5][63:56];
                        datain[6] <= matrix_a[6][63:56];
                        datain[7] <= matrix_a[7][63:56];
                        
                        datain[8] <= vector_b[63:56];

                    end 

                    fill_index <= fill_index + 3'd1;
                end
                EXEC : begin
                    // If fifo is enabled use the new dataout
                    if(rden_fifo[0]) begin
                        //rden_fifo_flop[0] <= rden_fifo[0];
                        dataout_flop[0]            <= dataout[0];
                        dataout_flop[8]            <= dataout[8];
                        shift_b_vector_en <= 1'b1;
                    end 

                    if(rden_fifo[1]) begin
                        //rden_fifo_flop[1]          <= rden_fifo[1];
                        dataout_flop[1]            <= dataout[1];
                        shifted_b_vector_flop[0]   <= shifted_b_vector[0];
                    end

                    if(rden_fifo[2]) begin
                        //rden_fifo_flop[2]          <= rden_fifo[2];
                        dataout_flop[2]            <= dataout[2];
                        shifted_b_vector_flop[1]   <= shifted_b_vector[1];
                    end

                    if(rden_fifo[3]) begin
                        //rden_fifo_flop[3]          <= rden_fifo[3];
                        dataout_flop[3]            <= dataout[3];
                        shifted_b_vector_flop[2]   <= shifted_b_vector[2];
                    end

                    if(rden_fifo[4]) begin
                        //rden_fifo_flop[4]          <= rden_fifo[4];
                        dataout_flop[4]            <= dataout[4];
                        shifted_b_vector_flop[3]   <= shifted_b_vector[3];
                    end

                    if(rden_fifo[5]) begin
                        //rden_fifo_flop[5]          <= rden_fifo[5];
                        dataout_flop[5]            <= dataout[5];
                        shifted_b_vector_flop[4]   <= shifted_b_vector[4];
                    end

                    if(rden_fifo[6]) begin
                        //rden_fifo_flop[6]          <= rden_fifo[6];
                        dataout_flop[6]            <= dataout[6];
                        shifted_b_vector_flop[5]   <= shifted_b_vector[5];
                    end

                    if(rden_fifo[7]) begin
                        //rden_fifo_flop[7]          <= rden_fifo[7];
                        dataout_flop[7]            <= dataout[7];
                        shifted_b_vector_flop[6]   <= shifted_b_vector[6];
                    end

                    // If fifo7 is empty mac calculations are done
                    if (empty[7]) begin
                        state <= WAIT_FOR_MAC;
                        shift_en <= 1'b0;
                        shift_b_vector_en <= 1'b0;
                        finish_calc[7] <= 1'b1;
                    end else if(empty[6]) begin
                        finish_calc[6] <= 1'b1;
                    end else if(empty[5]) begin
                        finish_calc[5] <= 1'b1;
                    end else if(empty[4]) begin
                        finish_calc[4] <= 1'b1;
                    end else if(empty[3]) begin
                        finish_calc[3] <= 1'b1;
                    end else if(empty[2]) begin
                        finish_calc[2] <= 1'b1;
                    end else if(empty[1]) begin
                        finish_calc[1] <= 1'b1;
                    end else if(empty[0]) begin
                        shift_in_rden_fifo <= 1'b0;
                        finish_calc[0] <= 1'b1;
                    end 

                    rden_fifo_flop <= rden_fifo;

                end
                WAIT_FOR_MAC : begin
                    rden_fifo_flop <= rden_fifo;
                    
                    if(count_mac_cycles == 2'b01) begin
                        state <= DONE;
                        shift_en <= 1'b0;
                    end else begin
                        count_mac_cycles <= count_mac_cycles + 1;
                    end
                end
                DONE : begin
                    rden_fifo_flop <= rden_fifo;

                    result[0] <= macout[0];
                    result[1] <= macout[1];
                    result[2] <= macout[2];
                    result[3] <= macout[3];
                    result[4] <= macout[4];
                    result[5] <= macout[5];
                    result[6] <= macout[6];
                    result[7] <= macout[7];

                    mvm_done <= 1'b1;
                end
            endcase
        end
    end

endmodule