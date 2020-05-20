//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : transaction.sv
// Project      : M.Tech-VLSI-Main-Project-Dynamic_Golden_File_Memory_Verification
// Description:
// This is the transaction module. It provides randomized inputs to the design.
// There are four inputs and one output declared in this module.
// Inputs are addr, wr_en, rd_en and wdata.
// Output is rdata.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class transaction;
 
  rand bit [9:0] addr;
  rand bit       wr_en;
  rand bit       rd_en;
  rand bit [7:0] wdata;
         bit [7:0] rdata;
         
  // A constraint to not enable read and write at same time.
  constraint wr_rd_c { wr_en != rd_en; };
   
endclass
