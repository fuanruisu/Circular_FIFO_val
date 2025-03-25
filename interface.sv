//interface between DUT and Testbench

interface fifo_intf (input logic clk);
  //interface has all dut signals
  //Declare with logic type
  //clock is generating and comming from (testbench.sv) top module so it is input for interface
  //logic clk;
  
  logic rst;
  logic [7:0] buf_in;
  logic [7:0] buf_out;
  logic wr_en; 
  logic rd_en; 
  logic buf_empty;
  logic buf_full;
  logic [`BUF_WIDTH :0] fifo_counter;
  
endinterface
