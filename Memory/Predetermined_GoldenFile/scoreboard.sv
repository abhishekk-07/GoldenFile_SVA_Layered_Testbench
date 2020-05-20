//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : scoreboard.sv
// Project      : M.Tech-VLSI-Main-Project-Predetermined_Golden_File_Memory_Verification
// Description:
// This is the scoreboard module.
// The constructor of this class has one parameter, a handle to a mailbox. 
// The golden file is also populated with predetermined data for comparison.
// It collects the sampled packet from the monitor and compares it with the corresponding values in the golden file.
// For every read operation, it compares the output received from the DUT with that present in the golden file for a corresponding address.
// Immediate assertions have been used to analyze the comparisons made in the main task of the scoreboard.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "monitor.sv"
class scoreboard;

  mailbox mon2scb;
  int no_transactions;
  bit [7:0] mem[4];
  bit [7:0] golden_file [4];

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
    golden_file[0] = 8'hAA;
    golden_file[1] = 8'hBB;
    golden_file[2] = 8'hCC;
    golden_file[3] = 8'hDD;
  endfunction

  task main;
    transaction trans;
    forever begin
      mon2scb.get(trans);
      if(trans.rd_en)
      begin
        $display("Addr = %0h, \tData read = %0h",trans.addr,trans.rdata);

        // Comparison of data.
        if (trans.addr == 2'b00)
          assert (trans.rdata ==  golden_file[0]) $display ("Correct Value is read");
          else $error("It's gone wrong");

        if (trans.addr == 2'b01)
          assert (trans.rdata ==  golden_file[1]) $display ("Correct Value is read");
          else $error("It's gone wrong");

        if (trans.addr == 2'b10)
          assert (trans.rdata ==  golden_file[2]) $display ("Correct Value is read");
          else $error("It's gone wrong");

        if (trans.addr == 2'b11)
          assert (trans.rdata ==  golden_file[3]) $display ("Correct Value is read");
          else $error("It's gone wrong");

      end
      no_transactions++;
    end
  endtask

endclass
