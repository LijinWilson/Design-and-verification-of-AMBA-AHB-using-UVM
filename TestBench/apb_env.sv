class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)
  `COMP_CONSTRUCTOR(apb_env)
  apb_scoreboard scb;
  apb_agent agt;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb=apb_scoreboard::type_id::create("scb",this);
    agt=apb_agent::type_id::create("agt",this);	      	      

  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.ap_mon.connect(scb.ap_scb);
  endfunction
  
 
  
endclass
