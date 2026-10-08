class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)
  `COMP_CONSTRUCTOR(apb_monitor)
  apb_trans tx;
  virtual intf inf;
  uvm_analysis_port #(apb_trans) ap_mon;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db #(virtual intf)::get(this," ","inf",inf);
    ap_mon=new("ap_mon",this); 
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      tx=apb_trans::type_id::create("tx");
      @(inf.mon_cb.PSEL && inf.mon_cb.PENABLE && inf.mon_cb.PREADY);
      tx.PADDR=inf.mon_cb.PADDR;
      tx.PWRITE=inf.mon_cb.PWRITE;
      if(tx.PWRITE)
     	 tx.PWDATA=inf.mon_cb.PWDATA;
      else
         tx.PRDATA=inf.mon_cb.PRDATA;

      ap_mon.write(tx);
      
    end
  endtask
  
endclass
