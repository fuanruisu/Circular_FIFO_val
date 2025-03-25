//uvm object class

class fifo_seq_item extends uvm_sequence_item;
  `uvm_object_utils(fifo_seq_item) // reg class to uvm factory
  
  rand logic rst;
  rand logic [7:0] buf_in;
  rand logic wr_en;
  rand logic rd_en;
  logic buf_empty;
  logic buf_full;
  logic [7:0] buf_out;
  logic [`BUF_WIDTH :0] fifo_counter;
  
  //standard constructor
  function new(string name ="fifo_seq_item");
    super.new(name);
    `uvm_info("sequence item Class", "constructor", UVM_MEDIUM)
  endfunction
  
  //no phases
  
  constraint wr_rd_c { rst != 1; }; 
 
endclass
