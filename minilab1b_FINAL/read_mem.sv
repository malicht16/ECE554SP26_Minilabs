module read_mem(clk, reset_n, rden, matrix_a, vector_b, read_done);

    input  logic        clk;
    input  logic        reset_n;
    input  logic        rden;
    output logic [63:0] matrix_a [7:0];
    output logic [63:0] vector_b;
    output logic        read_done;      //This signal indicates that the memory has been read and is ready to put into the fifos

    // number of addresses needed to be read (0-8)
    logic [31:0] address;
    logic [63:0] readdata;
    logic        readdatavalid;
    logic        waitrequest;

    // State machine 
    logic [1:0] state;
    localparam READ = 2'b00,
               WAIT    = 2'b01,
               DONE    = 2'b10;

    mem_wrapper mem(.clk(clk), .reset_n(reset_n), .address(address), .read(rden),
                    .readdata(readdata), .readdatavalid(readdatavalid), .waitrequest(waitrequest));

    always_ff @(posedge clk, negedge reset_n) begin
        if(~reset_n) begin
            // Start reading from address 0 next cycle
            address <= 32'd0;
            state <= READ;
            read_done <= 1'b0;
        end else begin
            case(state)
                READ : begin
                    // If the read data is valid put the 64 bits of data into the respective location
                    if(readdatavalid) begin
                        if(address[3]) begin
                            vector_b <= readdata;
                            state <= DONE;
                        end else begin
                            matrix_a[address[2:0]] <= readdata;
                            state <= WAIT;
                            address <= address + 32'd1;
                        end
                    end
                end

                WAIT : begin
                    // When there is no longer a wait request read the next address
                    if(~waitrequest) begin
                        state   <= READ;
                        //address <= address + 32'd1;
                    end
                end

                DONE : begin
                    read_done <= 1'b1;
                end
            endcase
        end 
    end

endmodule