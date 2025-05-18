
module FIFO #(parameter DEPTH = 8, WIDTH = 8)(
	input i_clk, i_rst_n,
	input i_wr_en, i_rd_en,
	input [WIDTH - 1 : 0] i_wr_data,
	output [WIDTH - 1 : 0] o_rd_data,
	output o_empty, o_mem_full
);
	reg [2:0] r_wr_ptr, r_rd_ptr;
	reg [WIDTH - 1 : 0] r_fifo_reg[DEPTH];
	
	always @(posedge i_clk) begin
		if(~i_rst_n) begin
			r_wr_ptr <= 3'd0;
			r_rd_ptr <= 3'd0;
			o_rd_data <= 0;
		end
	end
	
	always @(posedge i_clk) begin
		if(i_rd_en & ~o_empty) begin
			o_rd_data <= r_fifo_reg[r_rd_ptr];
			r_rd_ptr <= r_rd_ptr + 1'b1;
		end
	end
	
	always @(posedge i_clk) begin
		if(i_wr_en & ~o_mem_full) begin
			r_fifo_reg[r_wr_ptr] <= i_wr_data;
			r_wr_ptr <= r_wr_ptr + 1'b1;
		end
	end
	
	assign o_empty = (r_rd_ptr == r_wr_ptr);
	assign o_mem_full = ((r_wr_ptr+1'b1) == r_rd_ptr);

endmodule
			
			
			