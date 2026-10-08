class apb_trans extends uvm_sequence_item;
   `OBJ_CONSTRUCTOR(apb_trans)
   rand bit        PRESETn;   // Active Low Reset
    bit        PSEL;      // Slave Select
    bit        PENABLE;   // Enable Signal
  	rand bit   PWRITE;    // Write (1) / Read (0)
    rand bit [`ADDR_WIDTH-1:0]  PADDR;     // Address of Slave
  rand bit [`DATA_WIDTH-1:0]    PWDATA;    // Write Data
  bit [`DATA_WIDTH-1:0]    PRDATA; // Read Data
    bit        PREADY;  
    bit        PSLVERR;  
  
  `uvm_object_utils_begin(apb_trans)
  `uvm_field_int(PRESETn,UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(PSEL,UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(PENABLE,UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(PWRITE,UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(PADDR,UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(PWDATA,UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(PRDATA,UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(PREADY,UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(PSLVERR,UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  
  constraint valid_address_range
  {
    PADDR inside {[0:9]};
  }
  
   constraint data_range
  {
    PWDATA inside {[0:100]};
  }
  
   constraint invalid_address_range
  {
    PADDR inside {[10:11]};
  }
  
endclass
