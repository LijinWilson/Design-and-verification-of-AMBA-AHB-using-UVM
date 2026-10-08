class apb_read_seq extends uvm_sequence #(apb_trans);
  `uvm_object_utils(apb_read_seq)
  `OBJ_CONSTRUCTOR(apb_read_seq)
  apb_trans tx;
  task body();
    repeat(5)
      begin
        tx=apb_trans::type_id::create("tx");
        start_item(tx);
        tx.valid_address_range.constraint_mode(1);
        tx.invalid_address_range.constraint_mode(0);
        tx.randomize() with {tx.PWRITE==0;tx.PRESETn==1;};
        finish_item(tx);
      end
  endtask
endclass
