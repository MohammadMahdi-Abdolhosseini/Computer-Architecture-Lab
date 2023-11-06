module IF_Stage(
	input clk, rst, freeze, Branch_taken,
	input [31:0] BranchAddr,
	output [31:0] PC, Instruction
);
	wire [31:0] PC_in, PC_out;

	MUX32_2to1 mux(PC, BranchAddr, Branch_taken, PC_in);
	PC pc(clk, rst, freeze, PC_in, PC_out);
	ADD32 add(32'd4, PC_out, PC);
	InstMem instmem(PC_out, Instruction);

endmodule



