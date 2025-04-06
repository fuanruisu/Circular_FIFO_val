// Code your testbench here
// or browse Examples
`timescale 1ns/1ns

`include "uvm_macros.svh" // contains all uvm macros
import uvm_pkg::*; // contains all uvm base classes

//include classes in order
`include "fifo_pkg.sv"

module top;
  
  logic clk;
  logic rst;
  
  //..instantiation of lower modules.. Mainly DUT,Interface
  
  Sync_FIFO dut (
    .clk (intf.clk),
    .rst(intf.rst),
    .buf_in(intf.buf_in),
    .buf_out(intf.buf_out),
    .wr_en (intf.wr_en),
    .rd_en(intf.rd_en),
    .buf_empty (intf.buf_empty),
    .buf_full(intf.buf_full),
    .fifo_counter (intf.fifo_counter)
  );
  
  fifo_intf intf(.clk(clk), .rst(rst)); //(.interface clk(topmodule clk))
  
  initial begin 
    uvm_config_db#(virtual fifo_intf)::set(null,"*","vif",intf);
  end
  
  initial  begin
    clk = 0;
    rst = 1;//nota: drivear el reset en el seq item hace que la primer seq se pierda, como haciamos en los proyectos para drivear el reset? I mean podiamos resetear durante la simulacion para terminos de PM
    #1 rst = 0;
  end
    always #10 clk = ~clk;
   
  initial begin
    $monitor($time, "clk = %d", clk);
     //enable wave dump
    $dumpfile("dump.vcd"); 
    $dumpvars;
   // #300 $finish;//uncomment to dump waveform
  end
   
  initial begin 
    run_test("fifo_base_test");
  end
  
endmodule
