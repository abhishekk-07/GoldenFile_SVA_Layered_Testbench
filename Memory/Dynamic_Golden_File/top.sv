//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : top.sv
// Project      : M.Tech-VLSI-Main-Project-Dynamic_Golden_File_Memory_Verification
// Description:
// This is the top module.
// It connects the DUT and testbench.
// The test module file is being called before the module declaration.
// Firstly, the interface is instantiated with the clk and reset signals.
// Then, the interface is passed as a parameter to the program block.
// And lastly, the design is invoked with port declarations made with respect to interface signals.
// There is a concurrent assertion specified in the module, asserting that the read and the write operation shouldn't happen simultaneously.
// The concurrent assertion is always sampled at the rising edge of the clock.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "test.sv"
module top;

  bit clk;
  bit reset;
  bit rd_en, wr_en;
  always #5 clk = ~clk;

  initial begin
    reset = 1;
    #5 reset =0;
  end

  mem_intf intf(clk,reset);
  test t1(intf);
  memory DUT (
    .clk(intf.clk),
    .reset(intf.reset),
    .addr(intf.addr),
    .wr_en(intf.wr_en),
    .rd_en(intf.rd_en),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end

  // A definition for a monitor specific interface has been provided via a virtual interface with clocking block signal directions.
  assert property (@(posedge clk) !(wr_en & rd_en)) $display("Read and write are not active at same rising edge of clock");
  else $error("read and write active at at same rising edge of clock");
    
endmodule
