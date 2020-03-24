`include "defines.v"

module cpu4_core(
    input clk,
    input reset,
    output [31:0] pc,
    input  [31:0] instr,
    output memwrite,
    output [31:0] aluout,
    output [31:0] writedata,
    input  [31:0] readdata
);

    wire memtoreg;
    wire alusrc;
    wire regdst;
    wire regwrite;
    wire jump;
    wire pcsrc;
    wire zero;

    wire [2:0] alucontrol;

    cpu4_controller c(instr[31:26], instr[5:0], zero,
                    memtoreg, memwrite, pcsrc,
                    alusrc, regdst, regwrite, jump,
                    alucontrol);
    
    cpu4_datapath dp(clk, reset, memtoreg, pcsrc, 
                alusrc, regdst, regwrite, jump,
                alucontrol, zero, pc, instr,
                aluout, writedata, readdata);

endmodule