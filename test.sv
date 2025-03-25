//Test class is a uvm component
class fifo_test extends uvm_test;//uvm_test is the base test class
  `uvm_component_utils(fifo_test) // reg class to uvm factory
  
  fifo_env env;
  fifo_sequence seq;
  //dff_data_sequence data_seq;
  
  //standard constructor
  function new(string name ="fifo_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("Test Class", "constructor", UVM_MEDIUM)
  endfunction
  
  //build phase
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // create lower components
    env = fifo_env::type_id::create("env", this);
    seq = fifo_sequence::type_id::create("seq", this);
    //data_seq = dff_data_sequence::type_id::create("data_seq", this);

  endfunction
  
  //connect phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("Test Class", "connect phase", UVM_MEDIUM)
  endfunction
  
  //end of elaboration phase
  virtual function void end_of_elaboration();
    `uvm_info("Test Class", "elab phase", UVM_MEDIUM)
    print();
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info("test Class", "run_phase", UVM_MEDIUM)

    phase.raise_objection(this); //stay in run_phase untill the Test drop the objection
    seq.start(env.agent.seqr); 
    phase.drop_objection(this);
    
  endtask 
  
endclass
