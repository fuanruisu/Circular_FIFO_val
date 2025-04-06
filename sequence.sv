//uvm object class
class fifo_base_sequence extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_base_sequence) // reg class to uvm factory
  
  //fifo_seq_item tx;
  
  //standard constructor
  function new(string name ="fifo_base_sequence");
    super.new(name);
    `uvm_info("sequence Class", "constructor", UVM_MEDIUM)
  endfunction
  
  //no phase
    
endclass


//uvm object class
class  fifo_wr_seq extends fifo_base_sequence;
  rand int num_writes;
  `uvm_object_utils(fifo_wr_seq) // reg class to uvm factory
  
  
  constraint num_wr_c { num_writes > 0;  num_writes < 20;}; 
  
  //standard constructor
  function new(string name ="fifo_wr_seq");
    super.new(name);
    `uvm_info(get_full_name(), "constructor", UVM_MEDIUM)
  endfunction
  
  //no phase
  
 virtual task body();
   	`uvm_info(get_full_name(), "Writing", UVM_MEDIUM)
   repeat(num_writes) begin
     `uvm_do_with(req,{req.wr_en == 1; req.rd_en == 0;})   
   end
   //`uvm_info(get_full_name(), "Reading", UVM_MEDIUM)
   //`uvm_do_with(req,{req.rd_en == 1;req.wr_en == 0;})   
  endtask
    
endclass

//uvm object class
class  fifo_rd_seq extends fifo_base_sequence;
  rand int num_reads;
  `uvm_object_utils(fifo_rd_seq) // reg class to uvm factory
  
  
  constraint num_rd_c { num_reads > 0;  num_reads < 20;}; 
  
  //standard constructor
  function new(string name ="fifo_rd_seq");
    super.new(name);
    `uvm_info(get_full_name(), "constructor", UVM_MEDIUM)
  endfunction
  
  //no phase
  
 virtual task body();
   `uvm_info(get_full_name(), "Reading", UVM_MEDIUM)
   repeat(num_reads) begin
     `uvm_do_with(req,{req.rd_en == 1;req.wr_en == 0;})
   end
  endtask
    
endclass

class  fifo_wr_rd_seq extends fifo_base_sequence;
  fifo_wr_seq wr_seq;
  fifo_rd_seq rd_seq;
  rand int repeat_n_times;
  bit random_mode;
  
  `uvm_object_utils(fifo_wr_rd_seq) // reg class to uvm factory
  
  constraint repeat_n_times_c { !random_mode -> repeat_n_times == 1; random_mode -> repeat_n_times inside {[2:8]};}; 
  
  
  //standard constructor
  function new(string name ="fifo_wr_rd_seq");
    super.new(name);
    `uvm_info(get_full_name(), "constructor", UVM_MEDIUM)
    random_mode = 0;
   
     wr_seq = fifo_wr_seq::type_id::create("wr_seq");
     rd_seq = fifo_rd_seq::type_id::create("rd_seq");
  endfunction
  
   function void post_randomize();
    `uvm_info(get_full_name(), $sformatf("post_randomize(): repeat_n_times = %0d", repeat_n_times), UVM_LOW)
    // You can also compute things based on repeat_n_times here
  endfunction
  
  //no phase
  
 virtual task body();
    repeat(repeat_n_times) begin
      wr_seq.start(m_sequencer);
      rd_seq.start(m_sequencer);
    end
   //`uvm_do(fifo_rd_seq);
   #40;
  endtask
    
endclass
