`timescale 1 ps / 1 ps
module read_mem_tb();

    logic        clk;
    logic        reset_n;
    logic        rden;
    logic [63:0] matrix_a [7:0];
    logic [63:0] vector_b;
    logic        read_done;

    read_mem read_mem(.clk(clk), .reset_n(reset_n), .rden(rden), .matrix_a(matrix_a), .vector_b(vector_b), .read_done(read_done));

    initial begin
        clk = 1'b0;
        reset_n = 1'b0;
        rden = 1'b0;

        @ (negedge clk);
        reset_n = 1'b1;
        rden = 1'b1;

        repeat(300) @(posedge clk);


        $stop();
    end


    always 
        #5 clk = ~clk;

endmodule