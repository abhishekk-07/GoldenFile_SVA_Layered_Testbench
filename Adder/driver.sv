////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : driver.sv
// Project      : M.Tech-VLSI-Main-Project-Adder_Verification
// Description: 
// This is the driver module.
// It is responsible for transferring transaction class values to interface signals.
// It includes a task to reset the signals to their default values.
// It includes a variable to keep track of the number of packets driven.
// The generator module file is being included before class declaration.
//
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "generator.sv"
class driver;
  virtual intf_adr vif;
  mailbox gen2driv;
  int no_trans;
  
  
  function new (virtual intf_adr vif, mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction
  
  task reset;
    wait ( vif.reset );
    vif.a <= 0;
    vif.b <= 0;
    wait ( !vif.reset );
  endtask
  
  task main;
    forever 
    begin
      transaction trans;
      gen2driv.get(trans);
      
      @ (posedge vif.clk)
      vif.a <= trans.a;
      vif.b <= trans.b;
      //@ (posedge vif.clk)
      trans.c = vif.c;
     // @ (posedge vif.clk)                                           
      no_trans++;
    end
  endtask
  
endclass