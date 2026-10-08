class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)
  `COMP_CONSTRUCTOR(apb_test)

  apb_env env;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
   // jk_ff_reset_seq reset_seq;
    apb_write_seq  write_seq;
	apb_read_seq   read_seq;
    phase.raise_objection(this);

   // reset_seq = jk_ff_reset_seq::type_id::create("reset_seq");
    write_seq = apb_write_seq::type_id::create("write_seq");
    read_seq = apb_read_seq::type_id::create("read_seq");

      write_seq.start(env.agt.sqr);
      read_seq.start(env.agt.sqr);  
    
    
    phase.drop_objection(this);
  endtask
  

endclass
