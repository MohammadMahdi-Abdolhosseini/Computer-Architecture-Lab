`timescale 1ns/1ns
module TopLevel();
  
	reg clk = 0, rst = 1, ForwardingMode = 0;
	wire [31:0] PC, Instruction;

	wire [15:0] SRAM_DQ;
	wire [17:0] SRAM_ADDR;
	wire SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N,  SRAM_OE_N;

	ARM arm(clk, rst, ForwardingMode,
			SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N
	);
	SRAM sram(clk, rst,
	 		  SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N
	 );

	always #10 clk = ~clk;
	initial begin
 	#20 rst = 0;
	ForwardingMode = 1;
  	end

endmodule

