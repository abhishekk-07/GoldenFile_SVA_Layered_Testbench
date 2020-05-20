//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : transaction.sv
// Project      : M.Tech-VLSI-Main-Project-Predetermined_Golden_File_Memory_Verification
// Description:
// This is the transaction module. It provides randomized inputs to the design.
// There are four inputs and one output declared in this module.
// Inputs are addr, wr_en, rd_en and wdata.
// Output is rdata.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class transaction;

  rand bit [1:0] addr;
          bit       wr_en;
  rand bit       rd_en;
  rand bit [7:0] wdata;
          bit [7:0] rdata;
          bit [1:0] cnt;
  
  // A constraint is provided to disable the wr_en signal for the entire simulation.
  constraint no_wr { wr_en == 0; };

endclass
