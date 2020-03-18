`include "defines.v"

// Verilog module sirv_gnrl DFF with Load-enable, no reset	

module sirv_gnrl_dffl # ( parameter DW = 32) (
	input		lden,
	input		[DW - 1 : 0] dnxt,
	output 	[DW - 1 : 0] qout,
	input		clk
);
	reg [DW - 1 : 0] qout_r;
	
	always @(posedge clk)
	begin : dffl_proc
		if (lden == 1'b1)
			qout_r <= #1 dnxt;
	end
	
	assign qout = qout_r;

endmodule