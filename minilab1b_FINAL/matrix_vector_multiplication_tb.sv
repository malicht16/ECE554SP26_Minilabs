module matrix_vector_multiplication_tb();
    logic        clk;
    logic        rst_n;
    logic        valid_data;
    logic [63:0] matrix_a [7:0];
    logic [63:0] vector_b;
    logic        mvm_done;
    logic [23:0] result [7:0];

    matrix_vector_multiplication mvm(.clk(clk), .rst_n(rst_n), .valid_data(valid_data), 
                                     .matrix_a(matrix_a), .vector_b(vector_b), .mvm_done(mvm_done), .result(result));

    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        valid_data = 1'b0;

        matrix_a[0] = 64'h07_06_05_04_03_02_01_00;
        matrix_a[1] = 64'h17_16_15_14_13_12_11_10;
        matrix_a[2] = 64'h27_26_25_24_23_22_21_20;
        matrix_a[3] = 64'h37_36_35_34_33_32_31_30;
        matrix_a[4] = 64'h47_46_45_44_43_42_41_40;
        matrix_a[5] = 64'h57_56_55_54_53_52_51_50;
        matrix_a[6] = 64'h67_66_65_64_63_62_61_60;
        matrix_a[7] = 64'h77_76_75_74_73_72_71_70;

        vector_b    = 64'h07_06_05_04_03_02_01_00;

        @(negedge clk);
        rst_n = 1'b1;

        @(posedge clk);
        valid_data = 1'b1;

        repeat(10) @(posedge clk);

        @(negedge clk);
        $display("Only fifo[0] should be high. fifo_rden\n expected: 0000_0001\n actual: %b", mvm.rden_fifo);
        // Check fifo[0]
        $display("Hex data value coming out of fifo[0](matrix a00)\n expected: 00\n actual: %h", mvm.dataout[0]);
        $display("Hex data value coming out of fifo[8](vector b00)\n expected: 00\n actual: %h", mvm.dataout[8]);

        @(negedge clk);
        $display("Only fifo[1:0] should be high. fifo_rden\n expected: 0000_0011\n actual: %b", mvm.rden_fifo);
        // Check fifo[0]
        $display("Hex data value coming out of fifo[0](matrix a01)\n expected: 01\n actual: %h", mvm.dataout[0]);
        $display("Hex data value coming out of fifo[8](vector b01)\n expected: 01\n actual: %h", mvm.dataout[8]);
        // Check fifo[1]
        $display("Hex data value coming out of fifo[1]            (matrix a10)\n expected: 10\n actual: %h", mvm.dataout[1]);
        $display("Hex data value coming out of shifted_b_vector[0](vector b00)\n expected: 00\n actual: %h", mvm.shifted_b_vector[0]);

        @(negedge clk);
        $display("Only fifo[2:0] should be high. fifo_rden\n expected: 0000_0111\n actual: %b", mvm.rden_fifo);
        // Check fifo[0]
        $display("Hex data value coming out of fifo[0](matrix a02)\n expected: 02\n actual: %h", mvm.dataout[0]);
        $display("Hex data value coming out of fifo[8](vector b02)\n expected: 02\n actual: %h", mvm.dataout[8]);
        // Check fifo[1]
        $display("Hex data value coming out of fifo[1]            (matrix a11)\n expected: 11\n actual: %h", mvm.dataout[1]);
        $display("Hex data value coming out of shifted_b_vector[0](vector b01)\n expected: 01\n actual: %h", mvm.shifted_b_vector[0]);
        // Check fifo[2]
        $display("Hex data value coming out of fifo[2]            (matrix a20)\n expected: 20\n actual: %h", mvm.dataout[2]);
        $display("Hex data value coming out of shifted_b_vector[1](vector b00)\n expected: 00\n actual: %h", mvm.shifted_b_vector[1]);

        @(negedge clk);
        $display("Only fifo[3:0] should be high. fifo_rden\n expected: 0000_1111\n actual: %b", mvm.rden_fifo);
        // Check fifo[0]
        $display("Hex data value coming out of fifo[0](matrix a03)\n expected: 03\n actual: %h", mvm.dataout[0]);
        $display("Hex data value coming out of fifo[8](vector b03)\n expected: 03\n actual: %h", mvm.dataout[8]);
        // Check fifo[1]
        $display("Hex data value coming out of fifo[1]            (matrix a12)\n expected: 12\n actual: %h", mvm.dataout[1]);
        $display("Hex data value coming out of shifted_b_vector[0](vector b02)\n expected: 02\n actual: %h", mvm.shifted_b_vector[0]);
        // Check fifo[2]
        $display("Hex data value coming out of fifo[2]            (matrix a21)\n expected: 21\n actual: %h", mvm.dataout[2]);
        $display("Hex data value coming out of shifted_b_vector[1](vector b01)\n expected: 01\n actual: %h", mvm.shifted_b_vector[1]);
        // Check fifo[3]
        $display("Hex data value coming out of fifo[3]            (matrix a30)\n expected: 30\n actual: %h", mvm.dataout[3]);
        $display("Hex data value coming out of shifted_b_vector[2](vector b00)\n expected: 00\n actual: %h", mvm.shifted_b_vector[2]);

        @(negedge clk);
        $display("Only fifo[4:0] should be high. fifo_rden\n expected: 0001_1111\n actual: %b", mvm.rden_fifo);
        // Check fifo[0]
        $display("Hex data value coming out of fifo[0](matrix a04)\n expected: 04\n actual: %h", mvm.dataout[0]);
        $display("Hex data value coming out of fifo[8](vector b04)\n expected: 04\n actual: %h", mvm.dataout[8]);
        // Check fifo[1]
        $display("Hex data value coming out of fifo[1]            (matrix a13)\n expected: 13\n actual: %h", mvm.dataout[1]);
        $display("Hex data value coming out of shifted_b_vector[0](vector b03)\n expected: 03\n actual: %h", mvm.shifted_b_vector[0]);
        // Check fifo[2]
        $display("Hex data value coming out of fifo[2]            (matrix a22)\n expected: 22\n actual: %h", mvm.dataout[2]);
        $display("Hex data value coming out of shifted_b_vector[1](vector b02)\n expected: 02\n actual: %h", mvm.shifted_b_vector[1]);
        // Check fifo[3]
        $display("Hex data value coming out of fifo[3]            (matrix a31)\n expected: 31\n actual: %h", mvm.dataout[3]);
        $display("Hex data value coming out of shifted_b_vector[2](vector b01)\n expected: 01\n actual: %h", mvm.shifted_b_vector[2]);
        // Check fifo[4]
        $display("Hex data value coming out of fifo[4]            (matrix a40)\n expected: 40\n actual: %h", mvm.dataout[4]);
        $display("Hex data value coming out of shifted_b_vector[3](vector b00)\n expected: 00\n actual: %h", mvm.shifted_b_vector[3]);

        @(negedge clk);
        $display("Only fifo[5:0] should be high. fifo_rden\n expected: 0011_1111\n actual: %b", mvm.rden_fifo);
        // Check fifo[0]
        $display("Hex data value coming out of fifo[0](matrix a05)\n expected: 05\n actual: %h", mvm.dataout[0]);
        $display("Hex data value coming out of fifo[8](vector b05)\n expected: 05\n actual: %h", mvm.dataout[8]);
        // Check fifo[1]
        $display("Hex data value coming out of fifo[1]            (matrix a14)\n expected: 14\n actual: %h", mvm.dataout[1]);
        $display("Hex data value coming out of shifted_b_vector[0](vector b04)\n expected: 04\n actual: %h", mvm.shifted_b_vector[0]);
        // Check fifo[2]
        $display("Hex data value coming out of fifo[2]            (matrix a23)\n expected: 23\n actual: %h", mvm.dataout[2]);
        $display("Hex data value coming out of shifted_b_vector[1](vector b03)\n expected: 03\n actual: %h", mvm.shifted_b_vector[1]);
        // Check fifo[3]
        $display("Hex data value coming out of fifo[3]            (matrix a32)\n expected: 32\n actual: %h", mvm.dataout[3]);
        $display("Hex data value coming out of shifted_b_vector[2](vector b02)\n expected: 02\n actual: %h", mvm.shifted_b_vector[2]);
        // Check fifo[4]
        $display("Hex data value coming out of fifo[4]            (matrix a41)\n expected: 41\n actual: %h", mvm.dataout[4]);
        $display("Hex data value coming out of shifted_b_vector[3](vector b01)\n expected: 01\n actual: %h", mvm.shifted_b_vector[3]);
        // Check fifo[5]
        $display("Hex data value coming out of fifo[5]            (matrix a50)\n expected: 50\n actual: %h", mvm.dataout[5]);
        $display("Hex data value coming out of shifted_b_vector[4](vector b00)\n expected: 00\n actual: %h", mvm.shifted_b_vector[4]);

        @(negedge clk);
        $display("Only fifo[6:0] should be high. fifo_rden\n expected: 0111_1111\n actual: %b", mvm.rden_fifo);
        // Check fifo[0]
        $display("Hex data value coming out of fifo[0](matrix a06)\n expected: 06\n actual: %h", mvm.dataout[0]);
        $display("Hex data value coming out of fifo[8](vector b06)\n expected: 06\n actual: %h", mvm.dataout[8]);
        // Check fifo[1]
        $display("Hex data value coming out of fifo[1]            (matrix a15)\n expected: 15\n actual: %h", mvm.dataout[1]);
        $display("Hex data value coming out of shifted_b_vector[0](vector b05)\n expected: 05\n actual: %h", mvm.shifted_b_vector[0]);
        // Check fifo[2]
        $display("Hex data value coming out of fifo[2]            (matrix a24)\n expected: 24\n actual: %h", mvm.dataout[2]);
        $display("Hex data value coming out of shifted_b_vector[1](vector b04)\n expected: 04\n actual: %h", mvm.shifted_b_vector[1]);
        // Check fifo[3]
        $display("Hex data value coming out of fifo[3]            (matrix a33)\n expected: 33\n actual: %h", mvm.dataout[3]);
        $display("Hex data value coming out of shifted_b_vector[2](vector b03)\n expected: 03\n actual: %h", mvm.shifted_b_vector[2]);
        // Check fifo[4]
        $display("Hex data value coming out of fifo[4]            (matrix a42)\n expected: 42\n actual: %h", mvm.dataout[4]);
        $display("Hex data value coming out of shifted_b_vector[3](vector b02)\n expected: 02\n actual: %h", mvm.shifted_b_vector[3]);
        // Check fifo[5]
        $display("Hex data value coming out of fifo[5]            (matrix a51)\n expected: 51\n actual: %h", mvm.dataout[5]);
        $display("Hex data value coming out of shifted_b_vector[4](vector b01)\n expected: 01\n actual: %h", mvm.shifted_b_vector[4]);
        // Check fifo[6]
        $display("Hex data value coming out of fifo[6]            (matrix a60)\n expected: 60\n actual: %h", mvm.dataout[6]);
        $display("Hex data value coming out of shifted_b_vector[5](vector b00)\n expected: 00\n actual: %h", mvm.shifted_b_vector[5]);

        @(negedge clk);
        $display("fifo[7:0] should be high. fifo_rden\n expected: 1111_1111\n actual: %b", mvm.rden_fifo);
        // Check fifo[0]
        $display("Hex data value coming out of fifo[0](matrix a07)\n expected: 07\n actual: %h", mvm.dataout[0]);
        $display("Hex data value coming out of fifo[8](vector b07)\n expected: 07\n actual: %h", mvm.dataout[8]);
        // Check fifo[1]
        $display("Hex data value coming out of fifo[1]            (matrix a16)\n expected: 16\n actual: %h", mvm.dataout[1]);
        $display("Hex data value coming out of shifted_b_vector[0](vector b06)\n expected: 06\n actual: %h", mvm.shifted_b_vector[0]);
        // Check fifo[2]
        $display("Hex data value coming out of fifo[2]            (matrix a25)\n expected: 25\n actual: %h", mvm.dataout[2]);
        $display("Hex data value coming out of shifted_b_vector[1](vector b05)\n expected: 05\n actual: %h", mvm.shifted_b_vector[1]);
        // Check fifo[3]
        $display("Hex data value coming out of fifo[3]            (matrix a34)\n expected: 34\n actual: %h", mvm.dataout[3]);
        $display("Hex data value coming out of shifted_b_vector[2](vector b04)\n expected: 04\n actual: %h", mvm.shifted_b_vector[2]);
        // Check fifo[4]
        $display("Hex data value coming out of fifo[4]            (matrix a43)\n expected: 43\n actual: %h", mvm.dataout[4]);
        $display("Hex data value coming out of shifted_b_vector[3](vector b03)\n expected: 03\n actual: %h", mvm.shifted_b_vector[3]);
        // Check fifo[5]
        $display("Hex data value coming out of fifo[5]            (matrix a52)\n expected: 52\n actual: %h", mvm.dataout[5]);
        $display("Hex data value coming out of shifted_b_vector[4](vector b02)\n expected: 02\n actual: %h", mvm.shifted_b_vector[4]);
        // Check fifo[6]
        $display("Hex data value coming out of fifo[6]            (matrix a61)\n expected: 61\n actual: %h", mvm.dataout[6]);
        $display("Hex data value coming out of shifted_b_vector[5](vector b01)\n expected: 01\n actual: %h", mvm.shifted_b_vector[5]);
        // Check fifo[7]
        $display("Hex data value coming out of fifo[7]            (matrix a70)\n expected: 70\n actual: %h", mvm.dataout[7]);
        $display("Hex data value coming out of shifted_b_vector[6](vector b00)\n expected: 00\n actual: %h", mvm.shifted_b_vector[6]);

        @(negedge clk);
        $display("Only fifo[7:1] should be high. fifo_rden\n expected: 1111_1110\n actual: %b", mvm.rden_fifo);
        // Check result[0]
        $display("CHECK FINISHED MAC VALUES");
        $display("Hex data value coming out of macout[0](vector c00)\n expected: 00008c\n actual: %h", mvm.macout[0]);

        
        $display("CHECK FIFO VALUES");
        // Check fifo[1]
        $display("Hex data value coming out of fifo[1]            (matrix a17)\n expected: 17\n actual: %h", mvm.dataout[1]);
        $display("Hex data value coming out of shifted_b_vector[0](vector b07)\n expected: 07\n actual: %h", mvm.shifted_b_vector[0]);
        // Check fifo[2]
        $display("Hex data value coming out of fifo[2]            (matrix a26)\n expected: 26\n actual: %h", mvm.dataout[2]);
        $display("Hex data value coming out of shifted_b_vector[1](vector b06)\n expected: 06\n actual: %h", mvm.shifted_b_vector[1]);
        // Check fifo[3]
        $display("Hex data value coming out of fifo[3]            (matrix a35)\n expected: 35\n actual: %h", mvm.dataout[3]);
        $display("Hex data value coming out of shifted_b_vector[2](vector b05)\n expected: 05\n actual: %h", mvm.shifted_b_vector[2]);
        // Check fifo[4]
        $display("Hex data value coming out of fifo[4]            (matrix a44)\n expected: 44\n actual: %h", mvm.dataout[4]);
        $display("Hex data value coming out of shifted_b_vector[3](vector b04)\n expected: 04\n actual: %h", mvm.shifted_b_vector[3]);
        // Check fifo[5]
        $display("Hex data value coming out of fifo[5]            (matrix a53)\n expected: 53\n actual: %h", mvm.dataout[5]);
        $display("Hex data value coming out of shifted_b_vector[4](vector b03)\n expected: 03\n actual: %h", mvm.shifted_b_vector[4]);
        // Check fifo[6]
        $display("Hex data value coming out of fifo[6]            (matrix a62)\n expected: 62\n actual: %h", mvm.dataout[6]);
        $display("Hex data value coming out of shifted_b_vector[5](vector b02)\n expected: 02\n actual: %h", mvm.shifted_b_vector[5]);
        // Check fifo[7]
        $display("Hex data value coming out of fifo[7]            (matrix a71)\n expected: 71\n actual: %h", mvm.dataout[7]);
        $display("Hex data value coming out of shifted_b_vector[6](vector b01)\n expected: 01\n actual: %h", mvm.shifted_b_vector[6]);

        @(negedge clk);
        $display("Only fifo[7:2] should be high. fifo_rden\n expected: 1111_1100\n actual: %b", mvm.rden_fifo);
        $display("CHECK FINISHED MAC VALUES");
        // Check result[0]
        $display("Hex data value coming out of macout[0](vector c00)\n expected: 00008c\n actual: %h", mvm.macout[0]);
        // Check result[1]
        $display("Hex data value coming out of macout[1](vector c01)\n expected: 00024c\n actual: %h", mvm.macout[1]);
        

        $display("CHECK FIFO VALUES");
        // Check fifo[2]
        $display("Hex data value coming out of fifo[2]            (matrix a27)\n expected: 27\n actual: %h", mvm.dataout[2]);
        $display("Hex data value coming out of shifted_b_vector[1](vector b07)\n expected: 07\n actual: %h", mvm.shifted_b_vector[1]);
        // Check fifo[3]
        $display("Hex data value coming out of fifo[3]            (matrix a36)\n expected: 36\n actual: %h", mvm.dataout[3]);
        $display("Hex data value coming out of shifted_b_vector[2](vector b06)\n expected: 06\n actual: %h", mvm.shifted_b_vector[2]);
        // Check fifo[4]
        $display("Hex data value coming out of fifo[4]            (matrix a45)\n expected: 45\n actual: %h", mvm.dataout[4]);
        $display("Hex data value coming out of shifted_b_vector[3](vector b05)\n expected: 05\n actual: %h", mvm.shifted_b_vector[3]);
        // Check fifo[5]
        $display("Hex data value coming out of fifo[5]            (matrix a54)\n expected: 54\n actual: %h", mvm.dataout[5]);
        $display("Hex data value coming out of shifted_b_vector[4](vector b04)\n expected: 04\n actual: %h", mvm.shifted_b_vector[4]);
        // Check fifo[6]
        $display("Hex data value coming out of fifo[6]            (matrix a63)\n expected: 63\n actual: %h", mvm.dataout[6]);
        $display("Hex data value coming out of shifted_b_vector[5](vector b03)\n expected: 03\n actual: %h", mvm.shifted_b_vector[5]);
        // Check fifo[7]
        $display("Hex data value coming out of fifo[7]            (matrix a72)\n expected: 72\n actual: %h", mvm.dataout[7]);
        $display("Hex data value coming out of shifted_b_vector[6](vector b02)\n expected: 02\n actual: %h", mvm.shifted_b_vector[6]);

        @(negedge clk);
        $display("Only fifo[7:3] should be high. fifo_rden\n expected: 1111_1000\n actual: %b", mvm.rden_fifo);
        $display("CHECK FINISHED MAC VALUES");
        // Check result[0]
        $display("Hex data value coming out of macout[0](vector c00)\n expected: 00008c\n actual: %h", mvm.macout[0]);
        // Check result[1]
        $display("Hex data value coming out of macout[1](vector c01)\n expected: 00024c\n actual: %h", mvm.macout[1]);
        // Check result[2]
        $display("Hex data value coming out of macout[2](vector c02)\n expected: 00040c\n actual: %h", mvm.macout[2]);
        

        $display("CHECK FIFO VALUES");
        $display("Hex data value coming out of fifo[3]            (matrix a37)\n expected: 37\n actual: %h", mvm.dataout[3]);
        $display("Hex data value coming out of shifted_b_vector[2](vector b07)\n expected: 07\n actual: %h", mvm.shifted_b_vector[2]);
        // Check fifo[4]
        $display("Hex data value coming out of fifo[4]            (matrix a46)\n expected: 46\n actual: %h", mvm.dataout[4]);
        $display("Hex data value coming out of shifted_b_vector[3](vector b06)\n expected: 06\n actual: %h", mvm.shifted_b_vector[3]);
        // Check fifo[5]
        $display("Hex data value coming out of fifo[5]            (matrix a55)\n expected: 55\n actual: %h", mvm.dataout[5]);
        $display("Hex data value coming out of shifted_b_vector[4](vector b05)\n expected: 05\n actual: %h", mvm.shifted_b_vector[4]);
        // Check fifo[6]
        $display("Hex data value coming out of fifo[6]            (matrix a64)\n expected: 64\n actual: %h", mvm.dataout[6]);
        $display("Hex data value coming out of shifted_b_vector[5](vector b04)\n expected: 04\n actual: %h", mvm.shifted_b_vector[5]);
        // Check fifo[7]
        $display("Hex data value coming out of fifo[7]            (matrix a73)\n expected: 73\n actual: %h", mvm.dataout[7]);
        $display("Hex data value coming out of shifted_b_vector[6](vector b03)\n expected: 03\n actual: %h", mvm.shifted_b_vector[6]);

        @(negedge clk);
        $display("Only fifo[7:4] should be high. fifo_rden\n expected: 1111_0000\n actual: %b", mvm.rden_fifo);
        $display("CHECK FINISHED MAC VALUES");
        // Check result[0]
        $display("Hex data value coming out of macout[0](vector c00)\n expected: 00008c\n actual: %h", mvm.macout[0]);
        // Check result[1]
        $display("Hex data value coming out of macout[1](vector c01)\n expected: 00024c\n actual: %h", mvm.macout[1]);
        // Check result[2]
        $display("Hex data value coming out of macout[2](vector c02)\n expected: 00040c\n actual: %h", mvm.macout[2]);
        // Check result[3]
        $display("Hex data value coming out of macout[3](vector c03)\n expected: 0005cc\n actual: %h", mvm.macout[3]);
        

        $display("CHECK FIFO VALUES");
        // Check fifo[4]
        $display("Hex data value coming out of fifo[4]            (matrix a47)\n expected: 47\n actual: %h", mvm.dataout[4]);
        $display("Hex data value coming out of shifted_b_vector[3](vector b07)\n expected: 07\n actual: %h", mvm.shifted_b_vector[3]);
        // Check fifo[5]
        $display("Hex data value coming out of fifo[5]            (matrix a56)\n expected: 56\n actual: %h", mvm.dataout[5]);
        $display("Hex data value coming out of shifted_b_vector[4](vector b06)\n expected: 06\n actual: %h", mvm.shifted_b_vector[4]);
        // Check fifo[6]
        $display("Hex data value coming out of fifo[6]            (matrix a65)\n expected: 65\n actual: %h", mvm.dataout[6]);
        $display("Hex data value coming out of shifted_b_vector[5](vector b05)\n expected: 05\n actual: %h", mvm.shifted_b_vector[5]);
        // Check fifo[7]
        $display("Hex data value coming out of fifo[7]            (matrix a74)\n expected: 74\n actual: %h", mvm.dataout[7]);
        $display("Hex data value coming out of shifted_b_vector[6](vector b04)\n expected: 04\n actual: %h", mvm.shifted_b_vector[6]);

        @(negedge clk);
        $display("Only fifo[7:5] should be high. fifo_rden\n expected: 1110_0000\n actual: %b", mvm.rden_fifo);
        $display("CHECK FINISHED MAC VALUES");
        // Check result[0]
        $display("Hex data value coming out of macout[0](vector c00)\n expected: 00008c\n actual: %h", mvm.macout[0]);
        // Check result[1]
        $display("Hex data value coming out of macout[1](vector c01)\n expected: 00024c\n actual: %h", mvm.macout[1]);
        // Check result[2]
        $display("Hex data value coming out of macout[2](vector c02)\n expected: 00040c\n actual: %h", mvm.macout[2]);
        // Check result[3]
        $display("Hex data value coming out of macout[3](vector c03)\n expected: 0005cc\n actual: %h", mvm.macout[3]);
        // Check result[4]
        $display("Hex data value coming out of macout[4](vector c04)\n expected: 00078c\n actual: %h", mvm.macout[4]);
        

        $display("CHECK FIFO VALUES");
        // Check fifo[5]
        $display("Hex data value coming out of fifo[5]            (matrix a57)\n expected: 57\n actual: %h", mvm.dataout[5]);
        $display("Hex data value coming out of shifted_b_vector[4](vector b07)\n expected: 07\n actual: %h", mvm.shifted_b_vector[4]);
        // Check fifo[6]
        $display("Hex data value coming out of fifo[6]            (matrix a66)\n expected: 66\n actual: %h", mvm.dataout[6]);
        $display("Hex data value coming out of shifted_b_vector[5](vector b06)\n expected: 06\n actual: %h", mvm.shifted_b_vector[5]);
        // Check fifo[7]
        $display("Hex data value coming out of fifo[7]            (matrix a75)\n expected: 75\n actual: %h", mvm.dataout[7]);
        $display("Hex data value coming out of shifted_b_vector[6](vector b05)\n expected: 05\n actual: %h", mvm.shifted_b_vector[6]);

        @(negedge clk);
        $display("Only fifo[7:6] should be high. fifo_rden\n expected: 1100_0000\n actual: %b", mvm.rden_fifo);
        $display("CHECK FINISHED MAC VALUES");
        // Check result[0]
        $display("Hex data value coming out of macout[0](vector c00)\n expected: 00008c\n actual: %h", mvm.macout[0]);
        // Check result[1]
        $display("Hex data value coming out of macout[1](vector c01)\n expected: 00024c\n actual: %h", mvm.macout[1]);
        // Check result[2]
        $display("Hex data value coming out of macout[2](vector c02)\n expected: 00040c\n actual: %h", mvm.macout[2]);
        // Check result[3]
        $display("Hex data value coming out of macout[3](vector c03)\n expected: 0005cc\n actual: %h", mvm.macout[3]);
        // Check result[4]
        $display("Hex data value coming out of macout[4](vector c04)\n expected: 00078c\n actual: %h", mvm.macout[4]);
        // Check result[5]
        $display("Hex data value coming out of macout[5](vector c05)\n expected: 00094c\n actual: %h", mvm.macout[5]);
        

        $display("CHECK FIFO VALUES");
        // Check fifo[6]
        $display("Hex data value coming out of fifo[6]            (matrix a67)\n expected: 67\n actual: %h", mvm.dataout[6]);
        $display("Hex data value coming out of shifted_b_vector[5](vector b07)\n expected: 07\n actual: %h", mvm.shifted_b_vector[5]);
        // Check fifo[7]
        $display("Hex data value coming out of fifo[7]            (matrix a76)\n expected: 76\n actual: %h", mvm.dataout[7]);
        $display("Hex data value coming out of shifted_b_vector[6](vector b06)\n expected: 06\n actual: %h", mvm.shifted_b_vector[6]);


        @(negedge clk);
        $display("Only fifo[7] should be high. fifo_rden\n expected: 1000_0000\n actual: %b", mvm.rden_fifo);
        $display("CHECK FINISHED MAC VALUES");
        // Check result[0]
        $display("Hex data value coming out of macout[0](vector c00)\n expected: 00008c\n actual: %h", mvm.macout[0]);
        // Check result[1]
        $display("Hex data value coming out of macout[1](vector c01)\n expected: 00024c\n actual: %h", mvm.macout[1]);
        // Check result[2]
        $display("Hex data value coming out of macout[2](vector c02)\n expected: 00040c\n actual: %h", mvm.macout[2]);
        // Check result[3]
        $display("Hex data value coming out of macout[3](vector c03)\n expected: 0005cc\n actual: %h", mvm.macout[3]);
        // Check result[4]
        $display("Hex data value coming out of macout[4](vector c04)\n expected: 00078c\n actual: %h", mvm.macout[4]);
        // Check result[5]
        $display("Hex data value coming out of macout[5](vector c05)\n expected: 00094c\n actual: %h", mvm.macout[5]);
        // Check result[6]
        $display("Hex data value coming out of macout[6](vector c06)\n expected: 000b0c\n actual: %h", mvm.macout[6]);
        

        $display("CHECK FIFO VALUES");
        // Check fifo[7]
        $display("Hex data value coming out of fifo[7]            (matrix a77)\n expected: 77\n actual: %h", mvm.dataout[7]);
        $display("Hex data value coming out of shifted_b_vector[6](vector b07)\n expected: 07\n actual: %h", mvm.shifted_b_vector[6]);

        @(negedge clk);
        $display("Shouldnt be reading out of fifos. fifo_rden\n expected: 0000_0000\n actual: %b", mvm.rden_fifo);
        $display("CHECK FINISHED MAC VALUES");
        // Check result[0]
        $display("Hex data value coming out of macout[0](vector c00)\n expected: 00008c\n actual: %h", mvm.macout[0]);
        // Check result[1]
        $display("Hex data value coming out of macout[1](vector c01)\n expected: 00024c\n actual: %h", mvm.macout[1]);
        // Check result[2]
        $display("Hex data value coming out of macout[2](vector c02)\n expected: 00040c\n actual: %h", mvm.macout[2]);
        // Check result[3]
        $display("Hex data value coming out of macout[3](vector c03)\n expected: 0005cc\n actual: %h", mvm.macout[3]);
        // Check result[4]
        $display("Hex data value coming out of macout[4](vector c04)\n expected: 00078c\n actual: %h", mvm.macout[4]);
        // Check result[5]
        $display("Hex data value coming out of macout[5](vector c05)\n expected: 00094c\n actual: %h", mvm.macout[5]);
        // Check result[6]
        $display("Hex data value coming out of macout[6](vector c06)\n expected: 000b0c\n actual: %h", mvm.macout[6]);
        // Check result[7]
        $display("Hex data value coming out of macout[7](vector c07)\n expected: 000ccc\n actual: %h", mvm.macout[7]);


        repeat(100) @(posedge clk);

        $stop();
    end

    always
        #5 clk = ~clk;
endmodule