`include "defines.v"

module top (
	input  clk,
	input  reset,
	output [31:0] dataadr,
	output [31:0] writedata,
	output memwrite
	);
	
	wire [31:0] pc;
	wire [31:0] instr;
	wire [31:0] readdata;
	
	// instantiate processor and memories
	cpu4_core core(clk, reset, pc, instr, memwrite, 
					dataadr, writedata, readdata);
					
	cpu4_ram ram(dataadr[7:0], clk, writedata, memwrite, readdata);
	
endmodule