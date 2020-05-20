////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : generator.sv
// Project      : M.Tech-VLSI-Main-Project-Adder_Verification
// Description: 
// This is the generator module.
// It triggers the stimulus creation.
// It randomizes the stimuli and sends it to driver via a mailbox.
// It includes a handle for a mailbox, a variable to handle stimulus generation, and an event for the conclusion of the generation method.
// The transaction module file is being included before the declaration of the generator class.
// In the constructor of the class, mailbox handle and the event for indicating the finishing of the generation are being passed as parameters.
// The main task repeats itself for repeat_count times. 
//
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "transaction.sv"
class generator;
  mailbox gen2driv;
  event ended;
  int repeat_count;
  transaction trans;
  
  function new ( mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction
  
  task main;
    repeat(repeat_count)
    
    begin
      trans = new();
      if ( !trans.randomize()) $fatal ( "Gen randomization failed" ) ;
      gen2driv.put(trans);
    end
    -> ended;
  endtask
  
endclass