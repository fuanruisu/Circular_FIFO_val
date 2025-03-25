//uvm object class
class fifo_sequence extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_sequence) // reg class to uvm factory
  
  fifo_seq_item tx;
  
  //standard constructor
  function new(string name ="fifo_sequence");
    super.new(name);
    `uvm_info("sequence Class", "constructor", UVM_MEDIUM)
  endfunction
  
  //no phase
  
  task body();
    repeat(5) begin
      
    tx = fifo_seq_item ::type_id::create("tx");
    
    wait_for_grant();
    tx.randomize();// with (rst==1);
    send_request(tx);
    wait_for_item_done();
    
    end
  endtask
    
endclass

