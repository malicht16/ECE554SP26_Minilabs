module ml_transmitter_tb();

    
    logic clk;
    logic reset;
    logic baud_rate_generator; 
    logic transmit_enable;  
    logic [1:0] ioaddr;
    logic [7:0] transmit_buffer;
    logic TBR;
    logic TxD;

    transmitter transmitter_inst(.clk(clk), .reset(reset), .baud_rate_generator(baud_rate_generator), .transmit_enable(transmit_enable),
                                 .ioaddr(ioaddr), .transmit_buffer(transmit_buffer), .TBR(TBR), .TxD(TxD));

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        baud_rate_generator = 1'b0;
        transmit_enable = 1'b0;
        ioaddr = 2'b01;
        transmit_buffer = 8'bz;

        @(negedge clk);
        reset = 1'b0;

        repeat(5) @(posedge clk);
        ioaddr = 2'b00;
        transmit_enable = 1'b1;
        transmit_buffer = 8'b10101000;

        @(posedge clk);
        ioaddr = 2'b01;
        transmit_enable = 1'b0;
        transmit_buffer = 8'bz;

        repeat(2) @(posedge clk);
        baud_rate_generator = 1'b1;

        @(posedge clk);
        baud_rate_generator = 1'b0;

        @(negedge clk);
        if(TxD != 1'b0) begin
            $display("not outputting start bit");
        end

        repeat(5) @(posedge clk);
        baud_rate_generator = 1'b1;

        @(posedge clk);
        baud_rate_generator = 1'b0;

        @(negedge clk);
        if(TxD != 1'b0) begin
            $display("incorrect output of bit 0");
        end

        repeat(5) @(posedge clk);
        baud_rate_generator = 1'b1;

        @(posedge clk);
        baud_rate_generator = 1'b0;

        @(negedge clk);
        if(TxD != 1'b0) begin
            $display("incorrect output of bit 1");
        end

        repeat(5) @(posedge clk);
        baud_rate_generator = 1'b1;

        @(posedge clk);
        baud_rate_generator = 1'b0;

        @(negedge clk);
        if(TxD != 1'b0) begin
            $display("incorrect output of bit 2");
        end

        repeat(5) @(posedge clk);
        baud_rate_generator = 1'b1;

        @(posedge clk);
        baud_rate_generator = 1'b0;

        @(negedge clk);
        if(TxD != 1'b1) begin
            $display("incorrect output of bit 3");
        end

        repeat(5) @(posedge clk);
        baud_rate_generator = 1'b1;

        @(posedge clk);
        baud_rate_generator = 1'b0;

        @(negedge clk);
        if(TxD != 1'b0) begin
            $display("incorrect output of bit 4");
        end

        repeat(5) @(posedge clk);
        baud_rate_generator = 1'b1;

        @(posedge clk);
        baud_rate_generator = 1'b0;

        @(negedge clk);
        if(TxD != 1'b1) begin
            $display("incorrect output of bit 5");
        end

        repeat(5) @(posedge clk);
        baud_rate_generator = 1'b1;

        @(posedge clk);
        baud_rate_generator = 1'b0;

        @(negedge clk);
        if(TxD != 1'b0) begin
            $display("incorrect output of bit 6");
        end

        repeat(5) @(posedge clk);
        baud_rate_generator = 1'b1;

        @(posedge clk);
        baud_rate_generator = 1'b0;

        @(negedge clk);
        if(TxD != 1'b1) begin
            $display("incorrect output of bit 7");
        end

        repeat(5) @(posedge clk);
        $stop();
    end

    always
        #5 clk = ~clk;
endmodule