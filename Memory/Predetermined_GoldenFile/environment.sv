//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : environment.sv
// Project      : M.Tech-VLSI-Main-Project-Predetermined_Golden_File_Memory_Verification
// Description: 
// This is the environment module.
// The scoreboard file is being included prior to the declaration of the file.
// The constructor of this class has one parameter, virtual interface. 
// The instantiation of mailbox, generator, driver, monitor and scoreboard is performed in this constructor.
// There are three tasks defined. 
// They are responsible for resetting, performing the main task and then waiting for all specified simulations to be finished respectively.
// One task is created to invoke the above three task sequentially.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "scoreboard.sv"
class environment;
   
  generator  gen;
  driver     driv;
  monitor    mon;
  scoreboard scb;
  mailbox gen2driv;
  mailbox mon2scb;
  event gen_ended;
  virtual mem_intf mem_vif;
   
  function new(virtual mem_intf mem_vif);
    this.mem_vif = mem_vif;
    gen2driv = new();
    mon2scb  = new();
    gen  = new(gen2driv,gen_ended);
    driv = new(mem_vif,gen2driv);
    mon  = new(mem_vif,mon2scb);
    scb  = new(mon2scb);
  endfunction
   
  task pre_test();
    driv.reset();
  endtask
   
  task test();
    fork
    gen.main();
    driv.drive();
    mon.main();
    scb.main();     
    join_any
  endtask
   
  task post_test();
    wait(gen_ended.triggered);
    wait(gen.repeat_count == driv.no_transactions);
    wait(gen.repeat_count == scb.no_transactions);
  endtask 
   
  task run;
    pre_test();
    test();
    post_test();
  endtask
   
endclass

