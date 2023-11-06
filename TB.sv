`timescale 1ns/1ns
module TopLevel();
  
	reg clk = 0, rst = 1;
	wire [31:0] PC, Instruction;
	ARM arm(clk, rst, PC, Instruction);

	always #10 clk = ~clk;
	initial begin
 	#20 rst = 0;
  	end

endmodule

