//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : memory.v
// Project      : M.Tech-VLSI-Main-Project-Dynamic_Golden_File_Memory_Verification
// Description: 
// This is the memory module.
// The memory is 1024x8 bits in size.
// The inputs to the memory are clk, reset, wr_en, rd_en, addr and wdata.
// The output is rdata.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module memory(
  clk, 
  reset,
  wr_en,
  rd_en,
  addr,
  wdata,
  rdata
  );
  
  parameter ADDR_WIDTH = 10;
  parameter ADDRESS_MAX = 1024;
  
  input clk;
  input reset;
  input wr_en;
  input rd_en;
  input [ADDR_WIDTH-1:0] addr;
  input [7:0]  wdata;
  output reg [7:0] rdata;

  reg [7:0] mem [ADDRESS_MAX-1:0];
  always @ (posedge clk or posedge reset)
  begin
   if ( reset)
     begin
       rdata <= 0 ;    
     end
   else if ( wr_en )
     begin
       // The writing operation of the memory.
       mem[addr] <= wdata ;
     end
   else if ( rd_en )
     begin
       // The reading operation of the memory.
       rdata <= mem[addr];
     end
   end 
  
endmodule





