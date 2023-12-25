module MemoryController (
	input clk, rst, MEM_R_EN, MEM_W_EN, 
    input [31:0] ALU_Res, Val_Rm, 

    output reg [31:0] DATA,

	//For freeze other stages
	output reg ready,

	inout [15:0] SRAM_DQ,
	output reg [17:0] SRAM_ADDR,
	output reg SRAM_UB_N,
	output reg SRAM_LB_N,
	output reg SRAM_WE_N,
	output reg SRAM_CE_N,
	output reg SRAM_OE_N
);

typedef enum{ 
	S0,
	S1,
	S2,
	S3,
	S4,
	S5
} State;
State state = S0, next_state;

always @(*) begin
	case(state)
		S0: begin
		SRAM_ADDR = {2'b00, ALU_Res[15:0]};
		if (MEM_W_EN) begin
			//SRAM_DQ = Val_Rm[15:0];
			SRAM_WE_N = 1'b0;
		end
		if (MEM_R_EN) begin
			SRAM_WE_N <= 1'b1;
		end
		next_state <= S1;
		end

		S1: begin
		SRAM_ADDR <= {2'b00, ALU_Res[31:16]};
		if (MEM_W_EN) begin
			//SRAM_DQ = Val_Rm[31:16];
			SRAM_WE_N <= 1'b0;
		end
		if (MEM_R_EN) begin
			DATA[15:0] <= SRAM_DQ[15:0];
			SRAM_WE_N <= 1'b1;
		end
		next_state = S2;
		end

		S2: begin
		if (MEM_W_EN) begin
			SRAM_WE_N <= 1'b1;
		end
		if (MEM_R_EN) begin
			DATA[31:16] <= SRAM_DQ[15:0];
			SRAM_WE_N <= 1'b1;
		end
		next_state <= S3;
		end

		S3: begin
		
		next_state <= S4;
		end

		S4: begin
		
		next_state <= S5;
		end

		S5: begin
		next_state <= S0;
		ready <= 1;
		end
	endcase
	state <= next_state;

end

assign {SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N} = 4'b0;

assign SRAM_DQ = (MEM_W_EN && (state == S1)) ? Val_Rm[31:16] : ((MEM_W_EN && (state == S0)) ? Val_Rm[15:0] : SRAM_DQ);
endmodule
