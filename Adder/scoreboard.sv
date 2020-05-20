////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : scoreboard.sv
// Project      : M.Tech-VLSI-Main-Project-Adder_Verification
// Description: 
// This is the scoreboard module.
// The constructor of this class has one parameter, a mailbox handle.
// It collects the sampled packet from the monitor and compares it with logical operation of DUT.
// Immediate assertions have been used to analyze the comparisons made in the main task of the scoreboard.
//
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "monitor.sv"
class scoreboard;
	virtual intf_adr vif;
	mailbox mon2scb;
	int no_trans;
   
	function new ( mailbox mon2scb );
		this.mon2scb = mon2scb;
	endfunction

	task main;
	forever 
	begin
		transaction trans;
		mon2scb.get(trans);
		$display (  " \t a = %0d, \t b = %0d, \t c = %0d ",  trans.a, trans.b, trans.c ); 
		assert ( (trans.a + trans.b) == trans.c) $display( " Successful addition " ) ;
		else  $error ( " Gone wrong " );
		no_trans++;  
	end
	endtask
  
endclass