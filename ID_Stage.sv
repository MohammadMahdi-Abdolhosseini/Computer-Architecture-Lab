module ID_Stage(
	input clk, rst,
	input [31:0] Instruction,
	input [31:0] Result_WB,
	input WriteBackEn,
	input [3:0] Dest_WB,
	input hazard,
	input [3:0] SR,

	output WB_EN, MEM_R_EN, MEM_W_EN, B, S,
	output [3:0] EXE_CMD,
	output [31:0] VAL_RN, VAL_RM,
	output IMM,
	output [11:0] ShiftOperand,
	output [23:0] Signed_IMM_24,
	output [3:0] Dest,
	output [3:0] SRC1, SRC2,
	output Two_SRC
);
	//reg [1:0] Mode = Instruction[27:26];
	
	//reg [3:0] Opcode = Instruction[24:21];
	wire [8:0] CMD;
	ControlUnit CU(Instruction[27:26], Instruction[24:21], Instruction[20], CMD);

	//assign S = Instruction[20];
	assign SRC1 = Instruction[19:16];
	assign SRC2 = MEM_W_EN ? Instruction[15:12] : Instruction[3:0];
	RegisterFile RF(clk, rst, SRC1, SRC2, Dest_WB, Result_WB, WriteBackEn, VAL_RN, VAL_RM);

	wire [3:0] Cond = Instruction[31:28];
	wire condition;
	CondCheck CC(Cond, SR, condition);

	assign {WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, B, S} = (hazard | ~condition) ? 9'b0 : CMD;
	
	assign IMM = Instruction[25];
	assign Two_SRC = MEM_W_EN | ~IMM;
	
	
	
	
	
	
endmodule


