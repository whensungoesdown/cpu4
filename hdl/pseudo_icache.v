`include "defines.v"

module pseudo_icache (
	input  [7:0] a,
	output [31:0] q
);

	reg [31:0] cache[255:0];
	
	initial
		$readmemh("memory.dat", cache);
		
	assign q = cache[a];
endmodule


module pseudo_dcache (
	input  clk,
	input  we,
	input  [7:0] a,
	input  [31:0] wd,
	output [31:0] rd
);

	reg [31:0] cache[255:0];
	
	initial
		$readmemh("memory.dat", cache);
	
	assign rd = cache[a];
	
	always @(posedge clk)
		if (we) cache[a] <= wd;

endmodule