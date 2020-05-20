//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : interface.sv
// Project      : M.Tech-VLSI-Main-Project-Predetermined_Golden_File_Memory_Verification
// Description: 
// This is the interface module.
// It will classify the signals, define their direction through modport and synchronize them via clocking block.
// There are a total of 7 signals present.
// Two of them are taken as input for the interface, clk and reset.
// Rest of the five signals are mentioned as logic.
// There is a clocking block created in the interface. One each for driver and monitor.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface mem_intf(input logic clk,reset);
   
  logic [1:0] addr;
  logic wr_en;
  logic rd_en;
  logic [7:0] wdata;
  logic [7:0] rdata;
  
  // In the clocking block for the driver, there is one input as rdata and rest four are treated as outputs. 
  clocking driver_cb @(posedge clk);
    // There is an input and output skew provided of 1ns.
    default input #1 output #1;
    output addr;
    output wr_en;
    output rd_en;
    output wdata;
    input  rdata; 
  endclocking
  
  // For the monitor clocking block, all the five signals are considered as inputs. 
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input addr;
    input wr_en;
    input rd_en;
    input wdata;
    input rdata; 
  endclocking
  
  // Two modports are defined to use the input output signal configurations mentioned in the clocking blocks. 
  modport DRIVER  (clocking driver_cb,input clk,reset);
  modport MONITOR (clocking monitor_cb,input clk,reset);
  
  // For the purpose of measuring the coverage, there is a covergroup, cg, defined in the interface for the variable rdata.
  // The coverpoint includes 4 bins explicitly created to recognise the values of the rdata.
  covergroup cg @ (posedge clk);
    c1 : coverpoint rdata
    { bins b1 = {170};
      bins b2 = {187};
      bins b3 = {204};
      bins b4 = {221}; }
  endgroup
  cg cg_1 = new();   
   
endinterface

