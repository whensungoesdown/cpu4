`include "defines.v"

module cpu4_adder (
	input  [31:0] a,
	input  [31:0] b,
	output [31:0] y
	);
	
	assign y = a + b;
	
endmodule