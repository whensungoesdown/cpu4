`include "defines.v"

module cpu4_datapath (
	input  clk,
	input  reset,
	input  memtoreg,
	input  pcsrc,
	input  alusrc,
	input  regdst,
	input  regwrite,
	input  jump,
	input  [2:0] alucontrol,
	output zero,
	output [31:0] pc,
	input  [31:0] instr,
	output [31:0] aluout,
	output [31:0] writedata,
	input  [31:0] readdata
	);

wire [4:0] writereg;

wire [31:0] pcnext;
wire [31:0] pcnextbr;
wire [31:0] pcplus4;
wire [31:0] pcbranch;

wire [31:0] signimm;
wire [31:0] signimmsh;

wire [31:0] srca;
wire [31:0] srcb;

wire [31:0] result;


// next PC logic
sirv_gnrl_dffr#(32) pcreg(pcnext, pc, clk, reset);
cpu4_adder pcadd1(pc, 32'b100, pcplus4);
cpu4_sl2 immsh(signimm, signimmsh);
cpu4_mux2#(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
cpu4_mux2#(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);
	
	
// register file logic
cpu4_regfile rf(instr[25:21], instr[20:16],
				srca, writedata,
				regwrite,
				writereg, result,
				clk, reset);
				
cpu4_mux2#(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
cpu4_mux2#(32) resmux(aluout, readdata, memtoreg, result);
cpu4_signext  se(instr[15:0], signimm);

// ALU logic
cpu4_mux2#(32) srcbmux(writedata, signimm, alusrc, srcb);
cpu4_alu alu(srca, srcb, alucontrol, aluout, zero);
	
endmodule