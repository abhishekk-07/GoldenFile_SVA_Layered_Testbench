//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : driver.sv
// Project      : M.Tech-VLSI-Main-Project-Predetermined_Golden_File_Memory_Verification
// Description:
// This is the driver module.
// The generator module file is being included before class declaration.
// The driver is responsible for resetting the DUT input signals and sending the stimulus to the interface.
//
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "generator.sv"

// An interface defination has been provided for the operation via virtual interface with the modport signal directions.
`define DRIV_IF mem_vif.DRIVER.driver_cb
class driver;

  int no_transactions;
  virtual mem_intf mem_vif;
  mailbox gen2driv;

  function new(virtual mem_intf mem_vif,mailbox gen2driv);
    this.mem_vif = mem_vif;
    this.gen2driv = gen2driv;
  endfunction

  task reset;
    // Initializes interface signals to default values.
    wait(mem_vif.reset);
    `DRIV_IF.wr_en <= 0;
    `DRIV_IF.rd_en <= 0;
    `DRIV_IF.addr  <= 0;
    `DRIV_IF.wdata <= 0;
    wait(!mem_vif.reset);
  endtask

  task drive;
    forever begin
      transaction trans;
      `DRIV_IF.wr_en <= 0;
      `DRIV_IF.rd_en <= 0;
      gen2driv.get(trans);
      @(posedge mem_vif.DRIVER.clk);
      `DRIV_IF.addr <= trans.addr;
      if(trans.wr_en)
      begin
        `DRIV_IF.wr_en <= trans.wr_en;
        `DRIV_IF.wdata <= trans.wdata;
        @(posedge mem_vif.DRIVER.clk);
      end
      else if(trans.rd_en) begin
        `DRIV_IF.rd_en <= trans.rd_en;
        @(posedge mem_vif.DRIVER.clk);
        `DRIV_IF.rd_en <= 0;
        @(posedge mem_vif.DRIVER.clk);
        trans.rdata = `DRIV_IF.rdata;
      end
      // Tracking number of packets driven.
      no_transactions++;
    end
  endtask

endclass
