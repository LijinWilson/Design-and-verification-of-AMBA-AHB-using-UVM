class apb_b2b_wr extends uvm_sequence #(apb_trans);
  `uvm_object_utils(apb_b2b_wr)
  `OBJ_CONSTRUCTOR(apb_b2b_wr)
  apb_trans tx;
  task body();
    repeat(5)
      begin
        tx=apb_trans::type_id::create("tx");
        start_item(tx);
        tx.valid_address_range.constraint_mode(1);
        tx.invalid_address_range.constraint_mode(0);
        tx.randomize() with {tx.PRESETn==1;};
        finish_item(tx);
      end
  endtask
endclass
