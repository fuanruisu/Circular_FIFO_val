class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env) // reg class to uvm factory
  
  fifo_agent agent;
  fifo_scoreboard scb;
  
  //standard constructor
  function new(string name ="fifo_env", uvm_component parent);
    super.new(name, parent);
    `uvm_info("env Class", "constructor", UVM_MEDIUM)
  endfunction
  
    //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //create the lower components
    agent = fifo_agent::type_id::create("agent", this);
    scb = fifo_scoreboard::type_id::create("scb", this);

  endfunction
  
  // connect phase
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     `uvm_info("agent Class", "connect phase", UVM_MEDIUM);
     agent.mon.item_collected_port.connect(scb.item_collected_export);

  endfunction
endclass
