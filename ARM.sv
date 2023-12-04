`timescale 1ns/1ns
module ARM(
	//output [31:0] PC_IF_reg, Instruction_IF_reg,
	//output [17:0] LEDR, LEDG,


	input [17:0] SW, 
	input CLOCK_50

	//input clk, rst
);
  
	wire freeze, flush, Branch_taken;
	wire [31:0] BranchAddr;
	wire [31:0] PC_IF, PC_IF_reg, PC_ID_reg, PC_EXE, PC_EXE_reg, PC_MEM, PC_MEM_reg, PC_WB;
	wire [31:0] Instruction_IF, Instruction_IF_reg, Instruction_ID, Instruction_ID_reg;	
	

	IF_Stage if_stage(clk, rst, freeze, Branch_taken, BranchAddr, PC_IF, Instruction_IF);
	IF_Reg if_reg(clk, rst, freeze, flush, PC_IF, Instruction_IF, PC_IF_reg, Instruction_IF_reg);

	wire [31:0] Result_WB;
	wire WriteBackEn;
	wire [3:0] Dest_WB;
	wire hazard = 1'b0;
	wire [3:0] SR;

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


	wire WB_EN_EXE, MEM_R_EN_EXE, MEM_W_EN_EXE, B_EXE, S_EXE;
	wire [31:0] ALU_Res_EXE;
	wire [31:0] VAL_RM_EXE;
	wire [3:0] Dest_EXE, Status_EXE;

	wire WB_EN_EXE_reg, MEM_R_EN_EXE_reg, MEM_W_EN_EXE_reg, B_EXE_reg, S_EXE_reg;
	wire [31:0] ALU_Res_EXE_reg;
	wire [31:0] VAL_RM_EXE_reg;
	wire [3:0] Dest_EXE_reg;

	EXE_Stage exe_stage(clk, rst, WB_EN_ID_reg, MEM_R_EN_ID_reg, MEM_W_EN_ID_reg, B_ID_reg, S_ID_reg,
						EXE_CMD_ID_reg, SR_ID_reg, PC_ID_reg, VAL_RN_ID_reg, VAL_RM_ID_reg, IMM_ID_reg,
						ShiftOperand_ID_reg, Signed_IMM_24_ID_reg, Dest_ID_reg,
						WB_EN_EXE, MEM_R_EN_EXE, MEM_W_EN_EXE, B_EXE, S_EXE,
						ALU_Res_EXE, VAL_RM_EXE,
						Dest_EXE, Status_EXE, BranchAddr);

	EXE_Reg exe_reg(clk, rst, WB_EN_EXE, MEM_R_EN_EXE, MEM_W_EN_EXE, B_EXE, S_EXE,
					ALU_Res_EXE, VAL_RM_EXE, Dest_EXE,
					WB_EN_EXE_reg, MEM_R_EN_EXE_reg, MEM_W_EN_EXE_reg, B_EXE_reg, S_EXE_reg,
					ALU_Res_EXE_reg, VAL_RM_EXE_reg, Dest_EXE_reg);

	Status_Reg status_reg(clk, rst, Status_EXE, S_ID_reg, SR);


	wire WB_EN_MEM, MEM_R_EN_MEM;
	wire [31:0] ALU_Res_MEM, DATA_MEM;
	wire [3:0] Dest_MEM;

	wire WB_EN_MEM_reg, MEM_R_EN_MEM_reg;
	wire [31:0] ALU_Res_MEM_reg, DATA_MEM_reg;
	wire [3:0] Dest_MEM_reg;

	MEM_Stage mem_stage(clk, rst, WB_EN_EXE_reg, MEM_R_EN_EXE_reg, MEM_W_EN_EXE_reg,
						ALU_Res_EXE_reg, VAL_RM_EXE_reg, Dest_EXE_reg,
						WB_EN_MEM, MEM_R_EN_MEM, ALU_Res_MEM, DATA_MEM, Dest_MEM);

	MEM_Reg mem_reg(clk, rst, WB_EN_MEM, MEM_R_EN_MEM, ALU_Res_MEM, DATA_MEM, Dest_MEM,
					WB_EN_MEM_reg, MEM_R_EN_MEM_reg, ALU_Res_MEM_reg, DATA_MEM_reg, Dest_MEM_reg);

	WB_Stage wb_stage(clk, rst, WB_EN_MEM_reg, MEM_R_EN_MEM_reg, ALU_Res_MEM_reg, DATA_MEM_reg, Dest_MEM_reg,
					  WriteBackEn, Result_WB, Dest_WB);
	

	HDU hdu(SRC1_ID, SRC2_ID, Dest_EXE, Dest_MEM, WB_EN_EXE, WB_EN_MEM, Two_SRC_ID, hazard);


	assign freeze = hazard;
	assign flush = B_ID_reg;
	assign Branch_taken = B_ID_reg;

	wire clk, rst;
	assign clk = CLOCK_50;
	assign rst = SW[0];

/*
	//assign clk = SW[17];
	//assign LEDR[0] = rst;
	//assign LEDG[3:0] = Instruction_IF_reg[24:21];
	//assign LEDR[17:0] = PC_IF_reg[17:0];
*/

	

endmodule

