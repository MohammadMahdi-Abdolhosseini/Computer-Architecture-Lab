`timescale 1ns/1ns
module ARM(
	//output [31:0] PC_IF_reg, Instruction_IF_reg,
	input [17:0] SW, 
	//output [17:0] LEDR, LEDG,
	input CLOCK_50
	//input clk, rst
);
  
	reg freeze = 0, flush = 0, Branch_taken = 0;
	reg [31:0] BranchAddr = 32'b0;
	wire [31:0] PC_IF, PC_IF_reg, PC_ID_reg, PC_EXE, PC_EXE_reg, PC_MEM, PC_MEM_reg, PC_WB;
	wire [31:0] Instruction_IF, Instruction_IF_reg, Instruction_ID, Instruction_ID_reg;
	wire clk, rst;
	

	IF_Stage if_stage(clk, rst, freeze, Branch_taken, BranchAddr, PC_IF, Instruction_IF);
	IF_Reg if_reg(clk, rst, freeze, flush, PC_IF, Instruction_IF, PC_IF_reg, Instruction_IF_reg);

	wire [31:0] Result_WB;
	wire WriteBackEn;
	wire [3:0] Dest_WB;
	wire hazard = 1'b0;
	wire [3:0] SR = 4'd0;

	wire WB_EN_ID, MEM_R_EN_ID, MEM_W_EN_ID, B_ID, S_ID;
	wire [3:0] EXE_CMD_ID;
	wire [31:0] VAL_RN_ID, VAL_RM_ID;
	wire IMM_ID;
	wire [11:0] ShiftOperand_ID;
	wire [23:0] Signed_IMM_24_ID;
	wire [3:0] Dest_ID;
	wire [3:0] SRC1_ID, SRC2_ID;
	wire Two_SRC_ID;

	wire WB_EN_ID_reg, MEM_R_EN_ID_reg, MEM_W_EN_ID_reg, B_ID_reg, S_ID_reg;
	wire [3:0] EXE_CMD_ID_reg;
	wire [31:0] VAL_RN_ID_reg, VAL_RM_ID_reg;
	wire IMM_ID_reg;
	wire [11:0] ShiftOperand_ID_reg;
	wire [23:0] Signed_IMM_24_ID_reg;
	wire [3:0] Dest_ID_reg, SR_ID_reg;


	ID_Stage id_stage(clk, rst, Instruction_IF_reg,
					  Result_WB, WriteBackEn, Dest_WB, hazard, SR,
					  WB_EN_ID, MEM_R_EN_ID, MEM_W_EN_ID, B_ID, S_ID, EXE_CMD_ID, VAL_RN_ID, VAL_RM_ID, IMM_ID, ShiftOperand_ID, Signed_IMM_24_ID, Dest_ID, SRC1_ID, SRC2_ID, Two_SRC_ID);

	ID_Reg id_reg(clk, rst, flush, WB_EN_ID, MEM_R_EN_ID, MEM_W_EN_ID, B_ID, S_ID, EXE_CMD_ID, PC_IF_reg, VAL_RN_ID, VAL_RM_ID, IMM_ID, ShiftOperand_ID, Signed_IMM_24_ID, Dest_ID, SR,
		      WB_EN_ID_reg, MEM_R_EN_ID_reg, MEM_W_EN_ID_reg, B_ID_reg, S_ID_reg, EXE_CMD_ID_reg, PC_ID_reg, VAL_RN_ID_reg, VAL_RM_ID_reg, IMM_ID_reg, ShiftOperand_ID_reg, Signed_IMM_24_ID_reg, Dest_ID_reg, SR_ID_reg);

	EXE_Stage exe_stage(clk, rst, PC_ID_reg, PC_EXE);
	EXE_Reg exe_reg(clk, rst, PC_EXE, PC_EXE_reg);
	MEM_Stage mem_stage(clk, rst, PC_EXE_reg, PC_MEM);
	MEM_Reg mem_reg(clk, rst, PC_MEM, PC_MEM_reg);
	WB_Stage wb_stage(clk, rst, PC_MEM_reg, PC_WB);
	
	// Status_Reg status_Reg(output = SR);

	assign clk = CLOCK_50;
	assign rst = SW[0];
	//assign clk = SW[17];
	//assign LEDR[0] = rst;
	//assign LEDG[3:0] = Instruction_IF_reg[24:21];

	//assign LEDR[17:0] = PC_IF_reg[17:0];

endmodule

