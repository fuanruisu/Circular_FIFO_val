class fifo_monitor extends uvm_monitor;//uvm_monitor is the base monitor class
  `uvm_component_utils(fifo_monitor) // reg class to uvm factory
  
  virtual fifo_intf intf;
  uvm_analysis_port #(fifo_seq_item) item_collected_port;
  fifo_seq_item tx;

  //standard constructor
  function new(string name ="fifo_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("monitor Class", "constructor", UVM_MEDIUM)
  endfunction
  
    //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
        item_collected_port = new("item_collected_port", this);

    if(!uvm_config_db#(virtual fifo_intf)::get(this, "", "vif", intf))
      `uvm_fatal("no_inif in driver","virtual interface get failed from config db");
  
  endfunction
  
  task run_phase(uvm_phase phase);
    tx = fifo_seq_item::type_id::create("tx");
    wait(!intf.rst)
    
    //sampling the output
    @(posedge intf.clk)
    tx.rst = intf.rst;
    //tx.d = intf.d;
    //tx.q = intf.q;
  endtask
endclass
