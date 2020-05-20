//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module       : generator.sv
// Project       : M.Tech-VLSI-Main-Project-Predetermined_Golden_File_Memory_Verification
// Description : 
// This is the generator module.
// It triggers the stimulus creation.
// And transfers a packet of stimulus to the driver class via a mailbox. 
// It includes a handle for a mailbox, a variable to handle stimulus generation, and an event for the conclusion of the generation method.
// The transaction module file is being included before the declaration of the generator class.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "transaction.sv"
class generator;
   
  rand transaction trans;
  mailbox gen2driv;
  int  repeat_count; 
  event ended;
  
  // In the constructor of the class, mailbox handle and the event for indicating the finishing of the generation are being passed as parameters.
  function new(mailbox gen2driv,event ended);
    this.gen2driv = gen2driv;
    this.ended    = ended;
  endfunction
   
  task main();
    // The main task repeats itself for repeat_count times. 
    repeat(repeat_count) begin
      trans = new();
      // It makes sure the randomization occurs.
      if( !trans.randomize() ) $fatal("Gen:: trans randomization failed");   
      // Places the packet of stimulus in the mailbox.
      gen2driv.put(trans);
    end
   -> ended;
  endtask 

endclass
