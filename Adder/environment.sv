////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : environment.sv
// Project      : M.Tech-VLSI-Main-Project-Adder_Verification
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "scoreboard.sv"
class environment;
	virtual intf_adr vif;
	mailbox gen2driv, mon2scb;
	generator gen;
	driver driv ;
	monitor mon;
	scoreboard scb;
   
   
	function new ( virtual intf_adr vif );
		this.vif  =  vif;
		gen2driv = new();
		mon2scb = new();
		gen = new ( gen2driv );
		driv = new ( vif, gen2driv );
		mon = new ( vif, mon2scb );
		scb = new (mon2scb );
	endfunction
   
    task pre_run;
		driv.reset();
    endtask
    
    task test;
		fork
		gen.main();
		driv.main();
		mon.main();
		scb.main();
		join
    endtask
    
    task post_run;
		wait ( gen.ended.triggered );
		wait ( gen.repeat_count == driv.no_trans );
		wait ( gen.repeat_count == scb.no_trans );
    endtask
    
    task main;
		pre_run();
		test();
		post_run();
    endtask 
    
endclass