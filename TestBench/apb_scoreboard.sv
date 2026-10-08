class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)
  `COMP_CONSTRUCTOR(apb_scoreboard)
  apb_trans exp_tx;
  uvm_analysis_imp #(apb_trans,apb_scoreboard) ap_scb;
  bit [`DATA_WIDTH-1:0] memory [int];
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_scb=new("ap_scb",this); 
  endfunction
  
 function void write(apb_trans act_tx);
  exp_tx = apb_trans::type_id::create("exp_tx");

  // Print ACTUAL transaction
  `uvm_info(get_type_name(),
            $sformatf("ACT_TX :: PADDR=%0d PWRITE=%0b PWDATA=%0d PRDATA=%0d",
                      act_tx.PADDR,
                      act_tx.PWRITE,
                      act_tx.PWDATA,
                      act_tx.PRDATA),
            UVM_LOW)

  if (act_tx.PWRITE) begin
    memory[act_tx.PADDR] = act_tx.PWDATA;

    `uvm_info(get_type_name(),
              $sformatf("WRITE :: Stored EXP_DATA=%0d at ADDR=%0d",
                        act_tx.PWDATA, act_tx.PADDR),
              UVM_LOW)
  end
  else begin
    if (memory.exists(act_tx.PADDR)) begin

      // Expected value from memory
      `uvm_info(get_type_name(),
                $sformatf("EXP_TX :: PADDR=%0d EXP_PRDATA=%0d",
                          act_tx.PADDR,
                          memory[act_tx.PADDR]),
                UVM_LOW)

      if (act_tx.PRDATA == memory[act_tx.PADDR]) begin
        `uvm_info(get_type_name(),
                  "READ PASS :: ACT == EXP",
                  UVM_LOW)
      end
      else begin
        `uvm_error(get_type_name(),
                   $sformatf("READ FAIL :: ACT=%0d EXP=%0d",
                             act_tx.PRDATA,
                             memory[act_tx.PADDR]))
      end
    end
    else begin
      `uvm_warning(get_type_name(),
                   $sformatf("READ :: Address %0d does not exist in memory",
                             act_tx.PADDR))
    end
    
  end
endfunction

  
endclass
