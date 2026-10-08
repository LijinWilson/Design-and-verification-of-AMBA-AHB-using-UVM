interface intf(input PCLK);
    logic        PRESETn;   // Active Low Reset
    logic        PSEL;      // Slave Select
    logic        PENABLE;   // Enable Signal
    logic        PWRITE;    // Write (1) / Read (0)
    logic [`ADDR_WIDTH-1:0]  PADDR;     // Address of Slave
    logic [`DATA_WIDTH:0]    PWDATA;    // Write Data
    logic [`DATA_WIDTH:0]    PRDATA; // Read Data
    logic        PREADY;  
    logic        PSLVERR;  
  
  clocking drv_cb @(posedge PCLK);
    default input #1 output #0;
    output PRESETn,PSEL,PENABLE,PWRITE,PADDR,PWDATA;
    input PRDATA,PREADY,PSLVERR;
  endclocking
  
   clocking mon_cb @(posedge PCLK);
    default input #1 output #0;
    input PRESETn,PSEL,PENABLE,PWRITE,PADDR,PWDATA;
    input PRDATA,PREADY,PSLVERR;
  endclocking
  
endinterface
