module cpu4_regfile_tb(

);


// input use reg
// output use wire

reg [4 : 0] rs1idx;
reg [4 : 0] rs2idx;

wire [31 : 0] rs1data;
wire [31 : 0] rs2data;

reg [4 : 0 ] rdidx;
reg [31 : 0] rddata;

reg wen;

reg clk;

cpu4_regfile regfile(rs1idx, rs2idx, rs1data, rs2data, wen, rdidx, rddata, clk, 1'b0);

always
    #10 clk = ~clk;

initial
begin
    $display("Hello world\n");

    clk = 1'b0;
    wen = 1'b0;


    rs1idx = 5'b0;
    rs2idx = 5'b1;
    rdidx = 5'b1;
    rddata = 32'hAABBCCDD;
    wen = 1'b1;

    #20 ;

    $display("read rs1idx = 0  0x%x, rs2idx = 1  0x%x\n", rs1data, rs2data);

    wen = 1'b0;

    #20 ;

    $display("read rs1idx = 0  0x%x, rs2idx = 1  0x%x\n", rs1data, rs2data);

    $stop;
end

endmodule