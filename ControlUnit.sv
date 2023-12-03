module ControlUnit(
	input [1:0] Mode, 
	input [3:0] Opcode,
	input S, 

	output [8:0] CMD
);
	reg WB_EN, MEM_R_EN, MEM_W_EN, B;
	reg [3:0] EXE_CMD;
	
	always@(Mode, Opcode, S)begin
		MEM_W_EN = 1'b0; 
	//MOV
	if (Mode == 2'b00 && Opcode == 4'b1101)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0001;
	end
	//MVN
	if (Mode == 2'b00 && Opcode == 4'b1111)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b1001;
	end
	//ADD
	if (Mode == 2'b00 && Opcode == 4'b0100)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0010;
	end
	//ADC
	if (Mode == 2'b00 && Opcode == 4'b0101)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0011;
	end
	//SUB
	if (Mode == 2'b00 && Opcode == 4'b0010)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0100;
	end
	//SBC
	if (Mode == 2'b00 && Opcode == 4'b0110)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0101;
	end
	//AND
	if (Mode == 2'b00 && Opcode == 4'b0000)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0110;
	end
	//ORR
	if (Mode == 2'b00 && Opcode == 4'b1100)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0111;
	end
	//EOR
	if (Mode == 2'b00 && Opcode == 4'b0001)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b1000;
	end
	//CMP
	if (Mode == 2'b00 && Opcode == 4'b1010 && S == 1'b1)begin
		WB_EN = 1'b0;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0100;
	end
	//TST
	if (Mode == 2'b00 && Opcode == 4'b1000 && S == 1'b1)begin
		WB_EN = 1'b0;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0110;
	end
	//LDR
	if (Mode == 2'b01 && Opcode == 4'b0100 && S == 1'b1)begin
		WB_EN = 1'b1;
		MEM_R_EN = 1'b1;
		MEM_W_EN = 1'b0;
		B = 1'b0;
		EXE_CMD = 4'b0010;
	end
	//STR
	if (Mode == 2'b01 && Opcode == 4'b0100 && S == 1'b0)begin
		WB_EN = 1'b0;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b1;
		B = 1'b0;
		EXE_CMD = 4'b0010;
	end
	//BBB
	if (Mode == 2'b10)begin
		WB_EN = 1'b0;
		MEM_R_EN = 1'b0;
		MEM_W_EN = 1'b0;
		B = 1'b1;
	end
	end
	assign CMD = {WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, B, S};
	

endmodule
