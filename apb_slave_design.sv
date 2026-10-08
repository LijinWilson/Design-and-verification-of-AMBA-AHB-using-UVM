
module apb_slave (
    input         PCLK,      // Peripheral Clock
    input         PRESETn,   // Active Low Reset
    input         PSEL,      // Slave Select
    input         PENABLE,   // Enable Signal
    input         PWRITE,    // Write (1) / Read (0)
    input  [7:0]  PADDR,     // Address of Slave
    input  [7:0]  PWDATA,    // Write Data
    output reg [7:0] PRDATA, // Read Data
    output reg       PREADY,  
    output reg       PSLVERR  
);

  parameter N = 4;  // Number of wait states

  reg [7:0] mem [0:7]; // 8x8-bit memory
  reg [2:0] wait_counter;  // Counter for wait states
  reg transaction_active = 0;  //  indicate an active transaction

  always @(posedge PCLK or negedge PRESETn) begin
    if (!PRESETn) begin
      PREADY  <= 0;
      PSLVERR <= 0;
      PRDATA  <= 8'b0;
      transaction_active <= 0;
      wait_counter <= 0;
      
      for (integer i = 0; i < 8; i = i + 1) begin
        mem[i] <= 8'b0;
      end
    end 
    else begin
      PSLVERR <= 0; // Default no error

      if (PSEL && PENABLE && !transaction_active) begin
        transaction_active <= 1; // Start kardenge transaction
        wait_counter <= 0;       //  counter==0
        PREADY <= 0;             // Enter wait state
      end

      if (transaction_active) begin
        if (wait_counter < N - 1) begin
          wait_counter <= wait_counter + 1; // Incrementing wait counter
        end 
        else begin
          PREADY <= 1;  // Transaction complete hogya
          transaction_active <= 0; // Reset transaction flag

          if (PWRITE) begin
            if (PADDR == 8'h10 || PADDR == 8'h11) begin
              PSLVERR <= 1;  // Invalid address, assert error
            end 
            else begin
              mem[PADDR[2:0]] <= PWDATA;  // Write operation
            end
          end 
          else begin
            PRDATA <= mem[PADDR[2:0]]; // Read operation
          end
        end
      end 
      else begin
        PREADY <= 0; 
      end
    end
  end

endmodule
