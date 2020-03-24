`include "defines.v"

module cpu4_maindec(
    input  [5:0] op,
    output memtoreg,
    output memwrite,
    output branch,
    output alusrc,
    output regdst,
    output regwrite,
    output jump,
    output [1:0] aluop
);


    wire [8:0] controls;

    assign  controls[8:0] = {
                                regwrite, 
                                regdst, 
                                alusrc, 
                                branch, 
                                memwrite,
                                memtoreg, 
                                jump, 
                                aluop
                                };

	wire op_lw;
	
	assign op_lw = (op == 6'b100011);
			
	assign controls = ({9{op_lw}} & 9'b101001000);
	
//	always @(*)
//	begin
//	case (op)
//		//6'b100011: controls <= 9'b101001000; // LW
//		6'b100011: assign aluop = 2'b00;
//		//default: controls <= 9'b000000000;// illegal op
//	endcase
//	end
	
endmodule