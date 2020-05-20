//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : test.sv
// Project      : M.Tech-VLSI-Main-Project-Predetermined_Golden_File_Memory_Verification
// Description:
// This is the program block.
// It sets up the environment 
// Serves as a separator between testbench and DUT.
// The program block takes one parameter, an interface.
// This is where an object of environment class is created 
// The interface is passed as a parameter to the constructor of environment.
// The number of simulations are specified here by setting the repeat_count variable of generator class via environment.
// Then the main task of environment is called to execute the transactions for specified number of times.
// 
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "environment.sv"
program test(mem_intf intf);

  environment env;
  initial begin
    env = new(intf);
    // Specifying the number of packets needed.
    env.gen.repeat_count = 40;
    env.run();
  end

endprogram
