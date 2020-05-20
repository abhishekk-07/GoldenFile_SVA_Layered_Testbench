//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : monitor.sv
// Project      : M.Tech-VLSI-Main-Project-Dynamic_Golden_File_Memory_Verification
// Description:
// This is the monitor module.
// It transmits a sampled interface signal to the scoreboard via the mailbox.
// The constructor takes two parameters, virtual interface and a mailbox.
// For a read operation, the interface signals are sampled and sent to scoreboard in a mailbox.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "driver.sv"

// A definition for a monitor specific interface has been provided via a virtual interface with clocking block signal directions.
`define MON_IF mem_vif.MONITOR.monitor_cb
class monitor;

  virtual mem_intf mem_vif;
  mailbox mon2scb;

  function new(virtual mem_intf mem_vif,mailbox mon2scb);
    this.mem_vif = mem_vif;
    this.mon2scb = mon2scb;
  endfunction

  task main;
    forever begin
      transaction trans;
      trans = new();
      @(posedge mem_vif.MONITOR.clk);
      wait(`MON_IF.rd_en || `MON_IF.wr_en);
        trans.addr  = `MON_IF.addr;
        trans.wr_en = `MON_IF.wr_en;
        trans.wdata = `MON_IF.wdata;
        if(`MON_IF.rd_en) begin
          trans.rd_en = `MON_IF.rd_en;
          @(posedge mem_vif.MONITOR.clk);
          @(posedge mem_vif.MONITOR.clk);
          trans.rdata = `MON_IF.rdata;
        end
        mon2scb.put(trans);
    end
  endtask

endclass


