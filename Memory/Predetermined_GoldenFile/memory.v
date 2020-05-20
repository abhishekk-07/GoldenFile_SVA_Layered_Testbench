//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : memory.v
// Project      : M.Tech-VLSI-Main-Project-Predetermined_Golden_File_Memory_Verification
// Description: 
// This is the memory module.
// The memory is 8x4 bits in size.
// The inputs to the memory are clk, reset, wr_en, rd_en, addr and wdata.
// The output is rdata.
// At the reset of the design, the design is being instantiated with a fixed set of values.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module memory(
  input clk,
  input  reset, 
  input wr_en, 
  input rd_en,
  input [1:0] addr,
  input [7:0]  wdata,
  output reg [7:0] rdata
  );
  reg [7:0] mem [3:0];
  always @ (posedge clk or posedge reset)
  begin
   if ( reset)
     begin
       rdata <= 0 ;
       // initializing the memory
       mem[0] <= 8'hAA;
       mem[1] <= 8'hBB;
       mem[2] <= 8'hCC;
       mem[3] <= 8'hDD;       
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


