`include "defines.v"

module cpu4_alu (
	input  [31:0] a,
	input  [31:0] b,
	input  [2:0] control,
	output [31:0] y,
	output zero
	);
	
	wire control_add;
	wire control_sub;
	
	wire [31:0] add_result;
	wire [31:0] sub_result;
	
	
	assign control_add = (control[2:0] == 3'b010);
	assign control_sub = (control[2:0] == 3'b110);
	
	assign add_result = a + b;
	assign sub_result = a - b;
	
	assign y =  ({32{control_add}} & add_result) |
				({32{control_sub}} & sub_result)
				;
		
	assign zero =   (control_add & (add_result == 32'b0)) |
					(control_sub & (sub_result == 32'b0))
					;
	
endmodule