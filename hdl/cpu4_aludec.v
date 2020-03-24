`include "defines.v"

module cpu4_aludec (
	input [5:0] funct,
	input [1:0] aluop,
	output [2:0] alucontrol
	);
	
	wire aluop_00 = (aluop == 2'b00);
	wire aluop_01 = (aluop == 2'b01);
	
	assign alucontrol =   ({3{aluop_00}} & 3'b010) // add (for lw/sw/addi)
						| ({3{aluop_01}} & 3'b110);
	
endmodule