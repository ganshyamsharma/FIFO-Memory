
module FIFO #(parameter DEPTH = 8, WIDTH = 8)(
	input i_clk, i_rst_n,
	input i_wi_rd_en, i_rd_en,
	input [WIDTH - 1 : 0] i_wr_data,
	output [WIDTH - 1 : 0] o_rd_data,
	output o_empty, o_mem_full
);
	reg [2:0] w_ptr, r_ptr;
	reg [WIDTH - 1 : 0] fifo_reg[DEPTH];
	
	always @(posedge i_clk) begin
		if(~i_rst_n) begin
			w_ptr <= 3'd0;
			r_ptr <= 3'd0;
			o_rd_data <= 0;
		end
	end
	
	always @(posedge i_clk) begin
		if(i_rd_en & ~o_empty) begin
			o_rd_data <= fifo_reg[r_ptr];
			r_ptr <= r_ptr + 1'b1;
		end
	end
	
	always @(posedge i_clk) begin
		if(i_wi_rd_en & ~o_mem_full) begin
			fifo_reg[w_ptr] <= i_wr_data;
			w_ptr <= w_ptr + 1'b1;
		end
	end
	
	assign o_empty = (r_ptr == w_ptr);
	assign o_mem_full = ((w_ptr+1'b1) == r_ptr);

endmodule
			
			
			