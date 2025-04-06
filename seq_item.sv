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
  logic [7:0] num_pkt;
  
  
  //standard constructor
  function new(string name ="fifo_seq_item");
    super.new(name);
    `uvm_info("sequence item Class", "constructor", UVM_MEDIUM)
  endfunction
  
  //no phases
  
  constraint wr_rd_c { rst != 1; }; 
  //constraint buf_in_c { wr_en == 1 -> buf_in == 0};};
  
  
   // Backup current data before randomization
 // function void pre_randomize();
   // `uvm_info(get_type_name(), $sformatf("Copying buf_in = %d", buf_in), UVM_MEDIUM)
     //buf_in_backup = buf_in;
  //endfunction

  // Restore data if wr_en == 0
  //function void post_randomize();
  //  if (wr_en == 0)
    //  buf_in_backup = buf_in;
  //endfunction
  
  virtual function fifo_seq_item clone();
  fifo_seq_item new_obj;
  new_obj = fifo_seq_item::type_id::create("new_obj");

  if (new_obj == null) begin
    `uvm_error(get_type_name(), "Clone failed: new_obj is NULL")
    return null;
  end

  new_obj.copy(this);  // Should call copy()
  
  `uvm_info(get_type_name(), "Clone function executed", UVM_MEDIUM)
  
  return new_obj;
endfunction
  
  virtual function void copy(uvm_object rhs);
  fifo_seq_item rhs_cast;
  if (!$cast(rhs_cast, rhs)) begin
    `uvm_error(get_type_name(), "Copy failed: type mismatch")
    return;
  end
  
  this.buf_out = rhs_cast.buf_out;  // Copy the data
  this.rst = rhs_cast.rst;
  this.wr_en = rhs_cast.wr_en;
  this.rd_en = rhs_cast.rd_en;
  this.fifo_counter = rhs_cast.fifo_counter;
  this.buf_in = rhs_cast.buf_in;
  this.buf_empty = rhs_cast.buf_empty;
  this.buf_full = rhs_cast.buf_full; 
  this.fifo_counter = rhs_cast.fifo_counter;
    

  // Debugging prints
  `uvm_info(get_type_name(), $sformatf("Copying buf_out = %d", rhs_cast.buf_out), UVM_MEDIUM)
endfunction
 
endclass
