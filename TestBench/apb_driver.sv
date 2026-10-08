class apb_driver extends uvm_driver#(apb_trans);
  `uvm_component_utils(apb_driver)
  `COMP_CONSTRUCTOR(apb_driver)
  apb_trans tx;
  virtual intf inf;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db #(virtual intf)::get(this," ","inf",inf);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      tx=apb_trans::type_id::create("tx");
      seq_item_port.get_next_item(tx);
      send_to_dut(tx);
      seq_item_port.item_done();
    end
  endtask
  
  task send_to_dut(apb_trans tx);
    @(inf.drv_cb);
    if(!tx.PRESETn)
      begin
        inf.drv_cb.PWDATA<=0;
        inf.drv_cb.PADDR<=0;

      end
    
    else
      begin
       inf.drv_cb.PADDR<=tx.PADDR; 
       inf.drv_cb.PWRITE<=tx.PWRITE; 
       inf.drv_cb.PRESETn<=tx.PRESETn; 
       inf.drv_cb.PSEL<=1'b1;
       inf.drv_cb.PENABLE<=1'b0; 
       inf.drv_cb.PWDATA<=tx.PWDATA; 
       @(inf.drv_cb);
        inf.drv_cb.PENABLE<=1'b1; 
        wait(inf.drv_cb.PREADY);
        if(!tx.PWRITE)
          begin
           tx.PRDATA<=inf.drv_cb.PRDATA; 
          end
      end
  endtask
  
  
endclass
