`include "defines.v"

module cpu4_regfile (
	input [`CPU4_RFIDX_WIDTH - 1 : 0] rs1_idx,
	input [`CPU4_RFIDX_WIDTH - 1 : 0] rs2_idx,
	output [`CPU4_XLEN - 1 : 0] rs1_data,
	output [`CPU4_XLEN - 1 : 0] rs2_data,
	
	input rd_wen,
	input [`CPU4_RFIDX_WIDTH - 1 : 0] rd_idx,
	input [`CPU4_XLEN - 1 : 0] rd_data,
	
	input clk,
	input rst
);

	wire [`CPU4_XLEN - 1 : 0] rf_r [`CPU4_RFREG_NUM - 1 : 0];
	wire [`CPU4_RFREG_NUM - 1 : 0] rf_wen;
	
	genvar i;
	
	generate
	
	for (i = 0; i < `CPU4_RFREG_NUM; i = i + 1)
	begin: regs
		if (i == 0)
		begin :x0
			assign rf_wen[i] = 1'b0;
			assign rf_r[i] = 1'b0;
		end
		else begin : other_regs
			assign rf_wen[i] = rd_wen & (rd_idx === i);
			//assign rf_wen[i] = rd_wen;
			sirv_gnrl_dffl #(`CPU4_XLEN) rf_dffl (rf_wen[i], rd_data, rf_r[i], clk);
		end
	end
	
	endgenerate

	assign rs1_data = rf_r[rs1_idx];
	assign rs2_data = rf_r[rs2_idx];
	
endmodule