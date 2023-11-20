module ID_Reg(
	input clk, rst, flush,
	input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN,
	input [3:0] EXE_CMD_IN,
	input [31:0] PC_IN, VAL_RN_IN, VAL_RM_IN,
	input IMM_IN,
	input [11:0] ShiftOperand_IN,
	input [23:0] Signed_IMM_24_IN,
	input [3:0] Dest_IN, SR_IN,

	output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S,
	output reg [3:0] EXE_CMD,
	output reg [31:0] PC, VAL_RN, VAL_RM,
	output reg IMM,
	output reg [11:0] ShiftOperand,
	output reg [23:0] Signed_IMM_24,
	output reg [3:0] Dest, SR
);
	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1)
		begin
			{WB_EN, MEM_R_EN, MEM_W_EN, B, S} <= 0;
			EXE_CMD <= 0;
			{PC, VAL_RN, VAL_RM} <= 0;
			IMM <= 0;
			ShiftOperand <= 0;
			Signed_IMM_24 <= 0;
			Dest <= 0;
			SR <= 0;
		end
		else
		begin
			{WB_EN, MEM_R_EN, MEM_W_EN, B, S} <= {WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN};
			EXE_CMD <= EXE_CMD_IN;
			{PC, VAL_RN, VAL_RM} <= {PC_IN, VAL_RN_IN, VAL_RM_IN};
			IMM <= IMM_IN;
			ShiftOperand <= ShiftOperand_IN;
			Signed_IMM_24 <= Signed_IMM_24_IN;
			Dest <= Dest_IN;
			SR <= SR_IN;
		end
			
	end

endmodule
