module fifo_64 #(parameter DEPTH = 64, parameter WIDTH = 8)(
	input i_clk, i_wr_clk, i_rd_clk, i_rst_n, i_wr_en, i_rd_en,
	input [$clog2(DEPTH)-1:0] i_almost_full_lim, i_almost_empty_lim,
	input [WIDTH-1:0] i_wr_data,
	output o_almost_full, o_almost_empty, o_full, o_empty,
	output [WIDTH-1:0] o_rd_data
);
	
	reg [WIDTH-1:0] r_fifo_mem [DEPTH-1 : 0];
	reg [$clog2(DEPTH)-1:0]r_wr_ptr = 0, r_rd_ptr = 0;
	
	reg [WIDTH-1:0] r_rd_data;
	
	assign o_rd_data = r_rd_data;
	
	always @(posedge i_clk) begin
		if(~i_rst_n) begin
			r_wr_ptr 	<= 0;
			r_rd_ptr 	<= 0;
			r_rd_data 	<= 0;
		end
		else begin
			r_wr_ptr 	<= r_wr_ptr;
			r_rd_ptr 	<= r_rd_ptr;
			r_rd_data 	<= r_rd_data;
		end
	end
	
	always @(posedge i_wr_clk) begin
		if(i_wr_en & ~o_full) begin
			r_fifo_mem[r_wr_ptr] <= i_wr_data;
			r_wr_ptr <= r_wr_ptr + 1;
		end
		else begin
			r_wr_ptr <= r_wr_ptr;
		end
	end
	
	always @(posedge i_rd_clk) begin
		if(i_rd_en & ~i_wr_en & ~o_empty) begin
			r_rd_data <= r_fifo_mem[r_rd_ptr];
			r_rd_ptr <= r_rd_ptr + 1;
		end
		else begin
			r_rd_ptr <= r_rd_ptr;
		end
	end
	
	assign o_almost_full 	= ((r_wr_ptr - r_rd_ptr) < i_almost_full_lim) ? 1'b0 : 1'b1;
	assign o_almost_empty 	= ((r_wr_ptr - r_rd_ptr) > i_almost_empty_lim) ? 1'b0 : 1'b1;
	assign o_full 			= ((r_wr_ptr + 1'b1) == r_rd_ptr);
	assign o_empty 			= (r_wr_ptr == r_rd_ptr);
	
endmodule
			
			
			