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
					
	//cpu4_ram ram(pc[9:2], clk, writedata, memwrite, instr);
	
	//cpu4_ram_2port ram(pc[9:2], dataadr[9:2], clk, 32'b0, writedata, 1'b0, memwrite, instr, readdata);
	
	//cpu4_ram iram(pc[9:2], clk, 32'b0, 1'b0, instr);
	//cpu4_ram dram(dataadr[9:2], clk, writedata, memwrite, readdata);
	pseudo_icache icache(pc[9:2], instr);
	pseudo_dcache dcache(clk, memwrite, dataadr[9:2], writedata, readdata);
	
endmodule