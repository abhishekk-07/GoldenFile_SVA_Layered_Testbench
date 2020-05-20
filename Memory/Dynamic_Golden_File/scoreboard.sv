//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : scoreboard.sv
// Project      : M.Tech-VLSI-Main-Project-Dynamic_Golden_File_Memory_Verification
// Description:
// This is the scoreboard module.
// The constructor of this class has one parameter, a handle to a mailbox. 
// The golden file is also populated here with each packet of stimulus received.
// It collects the sampled packet from the monitor and compares it with the corresponding values in the golden file.
// For every read operation, it compares the output received from the DUT with that present in the golden file for a corresponding address.
// Immediate assertions have been used to analyze the comparisons made in the main task of the scoreboard.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "monitor.sv"
class scoreboard;
  
  bit [7:0] golden_file [1024];
  mailbox mon2scb;
  int no_transactions;
  bit [7:0] mem[1024];
   
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
   
  task main;
    transaction trans;
    forever begin
      mon2scb.get(trans);
      if (trans.wr_en)
        begin
          golden_file[trans.addr] = trans.wdata;
        end      
      else if(trans.rd_en) 
      if (trans.rdata != 8'h0) 
        begin
          $display("Addr = %0h, \tData read = %0h",trans.addr,trans.rdata);
          
          // Immediate assertion for comparing the data received from the DUT.
          assert (trans.rdata == golden_file[trans.addr]) $display ("Correct value is read");
          else $error("It's gone wrong");  
        end
      no_transactions++;
    end
  endtask
   
endclass
