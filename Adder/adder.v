////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module      : adder.v
// Project      : M.Tech-VLSI-Main-Project-Adder_Verification
// Description: 
// This is the adder module.
// The inputs to the adder are clk, reset, a and b.
// The output is c.
// Inputs a and b are of 4-bits each.
// Output c is of 5-bit.
// When the reset signal is applied, the output is resetted to 0.
// At every rising edge of the clock, the adder takes input a and b. 
// At the next rising edge of the clock, the output c is generated.
//
// Change history: 18/05/20 - V1.0 Initial working version created  (owner: Abhishek Kumar)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module adder(
  input clk,
  input reset,
  input [3:0] a,
  input [3:0] b,
  output reg [4:0] c
  );
  
  always @ (posedge clk, posedge reset)
  if ( reset )
    c <= 0;
  else
    c <= a+b;
  
endmodule