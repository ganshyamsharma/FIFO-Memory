# FIFO
Synthesizable verilog code for first in first out type memory. The depth and width of memory can be changed by adjusting the values of parameters **DEPTH** & **WIDTH**.
## I/O Description
- i_clk		         : Input clock; optional fastest clock, can be tied to i_rd_clk or i_wr_clk
- i_rd_clk           : Data read clock
- i_wr_clk           : Data write clock
- i_rst_n	         : Active low reset signal, reset the fifo read & write pointers to zero
- i_wr_en	         : Write enable signal, assert high to write data in the fifo memory
- i_rd_en	         : Read enable signal, assert high to read the fifo memory
- i_wr_data	         : Input data to be written in the memory, assert **i_wr_en** high signal to write in memory
- i_almost_full_lim  : Limit for setting the almost full flag
- i_almost_empty_lim : Limit for setting the almost empty flag
- o_rd_data	         : Output data to be read from the memory, assert **i_rd_en** high signal to write in memory
- o_empty	         : This signal is asserted high when fifo is empty, can not read from fifo if it is empty
- o_full             : This signal is asserted high when fifo is full, can not write new data to fifo if it is full
- o_almost_full      : Almost full flag; set when filled memory locations are greater than or equal to **i_almost_full_lim**
- o_almost_empty     : Almost empty flag; set when filled memory locations are less than or equal to **i_almost_empty_lim**
