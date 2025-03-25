class fifo_sequencer extends uvm_sequencer#(fifo_seq_item);
  `uvm_component_utils(fifo_sequencer) // reg class to uvm factory
  
  //standard constructor
  function new(string name ="fifo_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("sequencer Class", "constructor", UVM_MEDIUM)
  endfunction
  
  
endclass
