`timescale 1ns/1ns
module ARM(
	output [31:0] PC_IF_reg, Instruction_IF_reg,
	input [17:0] SW, 
	output [17:0] LEDR, LEDG,
	input CLOCK_50
);
  
	reg freeze = 0, flush = 0, Branch_taken = 0;
	reg [31:0] BranchAddr = 32'b0;
	wire [31:0] PC_IF, PC_ID, PC_ID_reg, PC_EXE, PC_EXE_reg, PC_MEM, PC_MEM_reg, PC_WB;
	wire [31:0] Instruction_IF;
	wire clk, rst;
	

	IF_Stage if_stage(clk, rst, freeze, Branch_taken, BranchAddr, PC_IF, Instruction_IF);
	IF_Reg if_reg(clk, rst, freeze, flush, PC_IF, Instruction_IF, PC_IF_reg, Instruction_IF_reg);
	ID_Stage id_stage(clk, rst, PC_IF_reg, PC_ID);
	ID_Reg id_reg(clk, rst, PC_ID, PC_ID_reg);
	EXE_Stage exe_stage(clk, rst, PC_ID_reg, PC_EXE);
	EXE_Reg exe_reg(clk, rst, PC_EXE, PC_EXE_reg);
	MEM_Stage mem_stage(clk, rst, PC_EXE_reg, PC_MEM);
	MEM_Reg mem_reg(clk, rst, PC_MEM, PC_MEM_reg);
	WB_Stage wb_stage(clk, rst, PC_MEM_reg, PC_WB);
	
	assign clk = CLOCK_50;
	assign rst = SW[0];
	//assign clk = SW[17];
	//assign LEDR[0] = rst;
	assign LEDG[3:0] = Instruction_IF_reg[24:21];

	assign LEDR[17:0] = PC_IF_reg[17:0];

endmodule

