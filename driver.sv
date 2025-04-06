//uvm component
class fifo_driver extends uvm_driver#(fifo_seq_item);
  `uvm_component_utils(fifo_driver) // reg class to uvm factory
  
  virtual fifo_intf intf;
  //fifo_seq_item tx;
  
  //standard constructor
  function new(string name ="fifo_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("driver Class", "constructor", UVM_MEDIUM)
  endfunction
  
    //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(virtual fifo_intf)::get(this, "", "vif", intf))
      `uvm_fatal("no_inif in driver","virtual interface get failed from config db");
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      `uvm_info("driver Class", "run_phase", UVM_MEDIUM)

      seq_item_port.get_next_item(req);
      drive(req);//req is the default handle for seq_item declared
      seq_item_port.item_done();
    end
  endtask
  
  task drive(fifo_seq_item tx);
    //sending tx to dut through interface
   @(posedge intf.clk);
    //intf.rst <= tx.rst;
    intf.wr_en <= tx.wr_en;
    intf.rd_en <= tx.rd_en;
    intf.buf_in <= tx.buf_in;
    
  endtask
endclass
