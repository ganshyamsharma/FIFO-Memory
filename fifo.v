
module FIFO #(parameter DEPTH = 8, WIDTH = 8)(
	input clk, rst_n,
	input w_en, r_en,
	input [WIDTH - 1 : 0] w_data_ip,
	output [WIDTH - 1 : 0] r_data_op,
	output empty, full
);
	reg [2:0] w_ptr, r_ptr;
	reg [WIDTH - 1 : 0] fifo_reg[DEPTH];
	
	always @(posedge clk) begin
		if(~rst_n) begin
			w_ptr <= 3'd0;
			r_ptr <= 3'd0;
			r_data_op <= 0;
		end
	end
	
	always @(posedge clk) begin
		if(r_en & ~empty) begin
			r_data_op <= fifo_reg[r_ptr];
			r_ptr <= r_ptr + 1'b1;
		end
	end
	
	always @(posedge clk) begin
		if(w_en & ~full) begin
			fifo_reg[w_ptr] <= w_data_ip;
			w_ptr <= w_ptr + 1'b1;
		end
	end
	
	assign empty = (r_ptr == w_ptr);
	assign full = ((w_ptr+1'b1) == r_ptr);

endmodule
			
			
			