// uvm component class
class fifo_scoreboard extends uvm_scoreboard ;
  `uvm_component_utils(fifo_scoreboard) // reg class to uvm factory
  
  uvm_analysis_imp#(fifo_seq_item, fifo_scoreboard) item_collected_export;

  fifo_seq_item fifo_q[$];
  logic [7:0] wr_data_q[$];
  logic [7:0] rd_data_q[$];

  //standard constructor
  function new(string name ="fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("scoreboard Class", "constructor", UVM_MEDIUM)
  endfunction
  
    //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);

  endfunction
  
  // write task - recives the pkt from monitor and pushes into queue
  virtual function void write(fifo_seq_item tx);
    fifo_seq_item fifo_i;
    //tx.print();
    $cast(fifo_i, tx.clone());
    
    `uvm_info(get_type_name (), $sformatf("wr_en %d", fifo_i.wr_en), UVM_LOW)
    `uvm_info(get_type_name (), $sformatf("rd_en %d", fifo_i.rd_en), UVM_LOW)
    
    if(fifo_i.buf_in >= 0)
      fifo_q.push_front(fifo_i); 
    
    if (fifo_i.wr_en) begin
      wr_data_q.push_front(fifo_i.buf_in);
      
    end
    else if (fifo_i.rd_en) begin
      rd_data_q.push_front(fifo_i.buf_out);
    end
        
    `uvm_info(get_type_name (), $sformatf("Output %d", fifo_i.buf_out), UVM_LOW)
    `uvm_info(get_type_name (), $sformatf("rd_en %d", fifo_i.rd_en), UVM_LOW)
  endfunction
  
   virtual function void report_phase(uvm_phase phase);
     
     
     `uvm_info(get_type_name (), "report_phase", UVM_MEDIUM)
     if(0) wr_rd_back_to_back_check;//instead the mota backwards use a cfg object
     if(1) wr_full_flag_check();
     
       
     
    // `uvm_info (get_type_name (), $sformatf ("q size %d", tx_q.size()), UVM_LOW)
     
    // foreach (rd_q[i]) begin
      // $display ("input = %d", rd_q[i].buf_out);
       //`uvm_info (get_type_name (), $sformatf ("input %d", rd_q[i].buf_out), UVM_LOW)
       //`uvm_info (get_type_name (), $sformatf ("rd_en %d", rd_q[i].rd_en), UVM_LOW)
     //end
     //foreach (wr_q[i]) begin
       //$display ("input = %d", wr_q[i].buf_out);
       //`uvm_info (get_type_name (), $sformatf ("input %d", wr_q[i].buf_out), UVM_LOW)
       //`uvm_info (get_type_name (), $sformatf ("wr_en %d", wr_q[i].wr_en), UVM_LOW)
     //end
     
     `uvm_info(get_type_name (), "report_phase", UVM_MEDIUM)
  endfunction
  
  function void wr_rd_back_to_back_check();
    logic [7:0] wr_data;
    logic [7:0] rd_data; 
    int size;
    
    size = rd_data_q.size();
    `uvm_info(get_type_name (), $sformatf("size %d", size), UVM_LOW)
    size = wr_data_q.size();
    `uvm_info(get_type_name (), $sformatf("size %d", size), UVM_LOW)
     
     for ( int i = 0; i < size; i++) begin 
       wr_data = wr_data_q.pop_front();
       rd_data = rd_data_q.pop_front();
       `uvm_info(get_type_name (), $sformatf("wr_data %d rd_data %d", wr_data, rd_data), UVM_LOW)
       
       if ( wr_data !== rd_data) begin
         `uvm_error(get_type_name (), $sformatf("Data mismatch -> wr_data %d rd_data %d", wr_data, rd_data))//need to use a cfg_object to enable disable the check from test
       end
     end
  endfunction
  
  function void wr_full_flag_check();
    
    foreach (fifo_q[i]) begin 
      
      `uvm_info(get_type_name (), $sformatf("buff_full %d fifo counter %d in %d", fifo_q[i].buf_full, fifo_q[i].fifo_counter, fifo_q[i].buf_in), UVM_DEBUG)
      
      
      if(fifo_q[i].fifo_counter == 16 && !fifo_q[i].buf_full) begin//checking if fifo counter is 16 the fifo flag full has to be 1
        `uvm_error(get_type_name (), $sformatf("Error fifo not full %d and fifo counter %d", fifo_q[i].buf_full, fifo_q[i].fifo_counter))
      end
      
      if(fifo_q[i].buf_full && fifo_q[i].fifo_counter < 16) begin//checking the full flag not asserted until 16 entries have been written
        `uvm_error(get_type_name (), $sformatf("Error fifo full before writing the 16 positions buf_full %d fifo counter %d", fifo_q[i].buf_full, fifo_q[i].fifo_counter))
      end
      
    end 
      
    
    
  endfunction
  
  
  function void fifo_counter_check();
    //when rd_en decrease, when wr en increase
  endfunction
  
endclass 
