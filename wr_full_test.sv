class wr_full_test extends fifo_base_test;
  `uvm_component_utils(wr_full_test);
  fifo_wr_seq seq;
  
  function new(string name, uvm_component parent);
     super.new(name, parent);
   endfunction // new
  
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // create lower components
     seq = fifo_wr_seq::type_id::create("seq", this);
      //data_seq = dff_data_sequence::type_id::create("data_seq", this);

    endfunction
  
     virtual task run_phase(uvm_phase phase);
       `uvm_info("Wr rd test Class", "run_phase", UVM_MEDIUM)
        phase.raise_objection(this); //stay in run_phase untill the Test drop the objection
       seq.num_writes = 16;
       seq.start(env.agent.seqr);
       #40;
       phase.drop_objection(this);
    
  endtask 
endclass
