module FIFO
#(
  parameter DEPTH=8,
  parameter DATA_WIDTH=8
)
(
  input  logic clk,
  input  logic rst_n,
  input  logic rden,
  input  logic wren,
  input  logic [DATA_WIDTH-1:0] i_data,
  output logic [DATA_WIDTH-1:0] o_data,
  output logic full,
  output logic empty
);

  // This is found in Minilab0.v which means wren and rden aren't at the same time. Writing whenever filling fifo and reading whenever emptying it
  // assign wren[0] = state == FILL;
  // assign wren[1] = wren[0];
  // assign rden[0] = state == EXEC;
  // assign rden[1] = rden[0];
  
  // only full whenever we have stored up to the death and only empty when no longer storing anything
  logic [$clog2(DEPTH)-1:0] filled, emptied;
  logic [DATA_WIDTH-1:0] mem [DEPTH-1:0];
  
  assign full = &filled;
  assign empty = &emptied;
  assign o_data = mem[emptied];
  
  always_ff @ (posedge clk) begin
  	if(!rst_n) begin
  		//indexes into memory
  		filled  <= '0;
  		emptied <= '0;
  	end else if(wren) begin
  		mem[filled] <= i_data;
  		filled      <= filled + 1;
  	end else if(rden) begin
  		emptied <= emptied + 1;
  	end
  end

endmodule