module to_greyscale_tb();

    // to_greyscale values
    logic [10:0] iX_Cont;
    logic [10:0] iY_Cont;
    logic [11:0] iDATA;
    logic		 iDVAL;
    logic		 iCLK;
    logic		 iRST;
    logic        mDVAL;
    logic [11:0] oDATA;

    // testbench values
    logic [11:0] data_num;
    logic [10:0] x_count;
    logic [10:0] y_count;

    to_greyscale greyscale_inst(.iX_Cont(iX_Cont), .iY_Cont(iY_Cont), .iDATA(iDATA), .iDVAL(iDVAL), .iCLK(iCLK), .iRST(iRST),
                                .mDVAL(mDVAL), .oDATA(oDATA));

    initial begin
        iCLK = 1'b0;
        iRST = 1'b0;

        iDATA = 12'd0;
        data_num = 12'd0;

        iDVAL = 1'b1;

        iX_Cont = 11'd0;
        x_count = 11'd0;

        iY_Cont = 11'd0;
        y_count = 11'd0;

        @(posedge iCLK);
        @(negedge iCLK);
        iRST = 1'b1;

        // Send in at least two rows of pixel data for the greyscale
        for(x = 0; x < 2560; x = x + 1) begin
            @(posedge clk);

            @(negedge clk);
            iDATA = data_num + 1;
            iX_Cont = x_count + 1;
            iY_Cont = y_count + 1;
        end
 

    end

    always 
        #5 iCLK = ~iCLK;

endmodule