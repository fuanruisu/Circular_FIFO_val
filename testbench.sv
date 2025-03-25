// Code your testbench here
// or browse Examples
`timescale 1ns/1ns

`include "uvm_macros.svh" // contains all uvm macros
import uvm_pkg::*; // contains all uvm base classes

//include classes in order
`include "fifo_pkg.sv"

module top;
  
  logic clk;
  
  //..instantiation of lower modules.. Mainly DUT,Interface
  
  Sync_FIFO dut (
    .clk (intf.clk),
    .rst(intf.rst),
    .buf_in(intf.buf_in),
    .buf_out(intf.buf_out),
    .wr_en (intf.clk),
    .rd_en(intf.rst),
    .buf_empty (intf.buf_empty),
    .buf_full(intf.buf_full),
    .fifo_counter (intf.fifo_counter)
  );
  
  fifo_intf intf(.clk(clk)); //(.interface clk(topmodule clk))
  
  initial begin 
    uvm_config_db#(virtual fifo_intf)::set(null,"*","vif",intf);
  end
  
  initial  begin
    clk = 0;
    //rst = 1;
    //#20 rst = 0;
  end
    always #10 clk = ~clk;
   
  initial begin
    $monitor($time, "clk = %d", clk);
     //enable wave dump
    $dumpfile("dump.vcd"); 
    $dumpvars;
    //#100 $finish;//uncomment to dump waveform
  end
   
  initial begin 
    run_test("fifo_test");
  end
  
endmodule
