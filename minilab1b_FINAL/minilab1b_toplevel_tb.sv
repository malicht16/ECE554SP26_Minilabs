
`timescale 1 ps / 1 ps
module minilab1b_toplevel_tb();

//////////// CLOCK //////////
	logic 		         	clk0;
	logic 		         	clk1;
	logic 		         	clk2;
	logic 		         	clk;

	//////////// SEG7 //////////
	logic	     [6:0]		hex0;
	logic	     [6:0]		hex1;
	logic	     [6:0]		hex2;
	logic	     [6:0]		hex3;
	logic	     [6:0]		hex4;
	logic	     [6:0]		hex5;
	
	//////////// LED //////////
	logic		 [9:0]		ledr;

	//////////// KEY //////////
	logic 		 [3:0]		key;

	//////////// SW //////////
	logic 		 [9:0]		sw;

minilab1b_FINAL iDUT( .CLOCK2_50(clk0), .CLOCK3_50(clk1), .CLOCK4_50(clk2), .CLOCK_50(clk),
                .HEX0(hex0), .HEX1(hex1), .HEX2(hex2), .HEX3(hex3), .HEX4(hex4), .HEX5(hex5),
                .LEDR(ledr), .KEY(key), .SW(sw));

initial begin
	clk = 1'b0;
    key = 4'd0;
	sw = 10'b00_0000_0000;

    @(posedge clk);

    @(negedge clk);
    key = 4'd1;


    repeat(400) @(posedge clk);

    // Should display result 0 which is 12cc 
	@(posedge clk);
    sw = 10'b00_0000_0001;

    @(posedge clk);
    if(hex0 == 7'b1000110) begin
		$display("hex0 is correct");
	end

	if(hex1 == 7'b1000110) begin
		$display("hex1 is correct");
	end

	if(hex2 == 7'b0100100) begin
		$display("hex2 is correct");
	end

	if(hex3 == 7'b1111001) begin
		$display("hex3 is correct");
	end

    // Should display result 1 which is 550c 
    repeat(4) @(posedge clk);
    sw = 10'b00_0000_0010;

    @(posedge clk);
    if(hex0 == 7'b1000110) begin
		$display("hex0 is correct");
	end

	if(hex1 == 7'b1000000) begin
		$display("hex1 is correct");
	end

	if(hex2 == 7'b0010010) begin
		$display("hex2 is correct");
	end

	if(hex3 == 7'b0010010) begin
		$display("hex3 is correct");
	end

    // Should display result 2 which is 974c 
    repeat(4) @(posedge clk);
    sw = 10'b00_0000_0100;

    @(posedge clk);
    if(hex0 == 7'b1000110) begin
		$display("hex0 is correct");
	end

	if(hex1 == 7'b0011001) begin
		$display("hex1 is correct");
	end

	if(hex2 == 7'b1111000) begin
		$display("hex2 is correct");
	end

	if(hex3 == 7'b0011000) begin
		$display("hex3 is correct");
	end

    // Should display result 3 which is d98c 
    repeat(4) @(posedge clk);
    sw = 10'b00_0000_1000;

    @(posedge clk);
    if(hex0 == 7'b1000110) begin
		$display("hex0 is correct");
	end

	if(hex1 == 7'b0000000) begin
		$display("hex1 is correct");
	end

	if(hex2 == 7'b0011000) begin
		$display("hex2 is correct");
	end

	if(hex3 == 7'b0100001) begin
		$display("hex3 is correct");
	end

    // Should display result 4 which is 116cc 
    repeat(4) @(posedge clk);
    sw = 10'b00_0001_0000;

    @(posedge clk);
    if(hex0 == 7'b1000110) begin
		$display("hex0 is correct");
	end

	if(hex1 == 7'b1000110) begin
		$display("hex1 is correct");
	end

	if(hex2 == 7'b0000010) begin
		$display("hex2 is correct");
	end

	if(hex3 == 7'b1111001) begin
		$display("hex3 is correct");
	end

	if(hex4 == 7'b1111001) begin
		$display("hex4 is correct");
	end

    // Should display result 5 which is 15e0c 
    repeat(4) @(posedge clk);
    sw = 10'b00_0010_0000;

    @(posedge clk);
    if(hex0 == 7'b1000110) begin
		$display("hex0 is correct");
	end

	if(hex1 == 7'b1000000) begin
		$display("hex1 is correct");
	end

	if(hex2 == 7'b0000110) begin
		$display("hex2 is correct");
	end

	if(hex3 == 7'b0010010) begin
		$display("hex3 is correct");
	end

	if(hex4 == 7'b1111001) begin
		$display("hex4 is correct");
	end

    // Should display result 6 which is 1a04c 
    repeat(4) @(posedge clk);
    sw = 10'b00_0100_0000;

    @(posedge clk);
    if(hex0 == 7'b1000110) begin
		$display("hex0 is correct");
	end

	if(hex1 == 7'b0011001) begin
		$display("hex1 is correct");
	end

	if(hex2 == 7'b1000000) begin
		$display("hex2 is correct");
	end

	if(hex3 == 7'b0001000) begin
		$display("hex3 is correct");
	end

    if(hex4 == 7'b1111001) begin
		$display("hex4 is correct");
	end

    // Should display result 7 which is 1e28c 
    repeat(4) @(posedge clk);
    sw = 10'b00_1000_0000;

    @(posedge clk);
    if(hex0 == 7'b1000110) begin
		$display("hex0 is correct");
	end

	if(hex1 == 7'b0000000) begin
		$display("hex1 is correct");
	end

	if(hex2 == 7'b0100100) begin
		$display("hex2 is correct");
	end

	if(hex3 == 7'b0000110) begin
		$display("hex3 is correct");
	end

    if(hex4 == 7'b1111001) begin
		$display("hex4 is correct");
	end

	$stop();
end
always 
    #5 clk = ~clk;

endmodule