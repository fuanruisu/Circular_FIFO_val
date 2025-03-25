class fifo_agent extends uvm_agent;
  `uvm_component_utils(fifo_agent) // reg class to uvm factory
  
  fifo_driver drv;
  fifo_monitor mon;
  fifo_sequencer seqr;  
  
  //standard constructor
  function new(string name ="fifo_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("Agent Class", "constructor", UVM_MEDIUM)
  endfunction
  
    //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //create the lower components
    
    drv = fifo_driver ::type_id::create("fifo_driver", this);
    mon = fifo_monitor ::type_id::create("fifo_monitor", this);
    seqr = fifo_sequencer ::type_id::create("fifo_sequencer", this);
    
  endfunction
  
  //connect phase
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("agent Class", "connect phase", UVM_MEDIUM)
     
    drv.seq_item_port.connect(seqr.seq_item_export);

  endfunction
  
endclass
