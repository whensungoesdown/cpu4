module cpu4_ram_tb(

);

// input use reg
// output use wire

reg [7 : 0] address;
reg [31 : 0] data;

reg wen;
reg clk;

wire [31 : 0] q;

cpu4_ram ram(address, clk, data, wen, q);

always
    #10 clk = ~clk;

initial
begin
    $display("cpu4_ram test\n");

    clk = 1'b1;
    //wen = 1'b1;

    address = 8'h1;
    //data = 8'hAA;
    

    #20 ;
    #20 ;

    wen = 1'b0;
    
    #20 ;
    #20 ;

    $display("read address 1 0x%x\n", q);
    $display("test\n");
    
    address = 8'h1;
    #10 ;
    #10 ;

    $display("2 read address 1 0x%x\n", q);

    $stop;    
end

endmodule