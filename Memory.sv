module MemoryController (
	input clk, rst, MEM_R_EN, MEM_W_EN, 
    input [31:0] ALU_Res, Val_Rm, 

    output reg [31:0] DATA,

	//For freeze other stages
	output reg ready,

	inout reg [15:0] SRAM_DQ,
	output reg [17:0] SRAM_ADDR,
	output reg SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N
);

wire [31:0] adr = (ALU_Res - 32'd1024);

reg [2:0] state = 3'b000, next_state;

always @(posedge clk, posedge rst) begin
    if(rst)
        state <= 0;
    else
        state <= next_state; 
end

always @(state, MEM_R_EN, MEM_W_EN, SRAM_DQ) begin
	{SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N} <= 4'b0;
    ready <= 1'b1;
	case(state)
		3'd0: begin
            next_state <= state;
            if (MEM_R_EN) begin
			    SRAM_WE_N <= 1'b1;
                DATA[15:0] <= SRAM_DQ;
                next_state <= 3'd1;
                ready <= 1'b0;
		    end
		    if (MEM_W_EN) begin
			    SRAM_WE_N <= 1'b0;
                next_state <= 3'd1;
                ready <= 1'b0;
		    end
		    
		end

		3'd1: begin
            next_state <= state;
            if (MEM_R_EN) begin
                SRAM_WE_N <= 1'b1;
                DATA[31:16] <= SRAM_DQ;
                next_state <= 3'd2;
                ready <= 1'b0;
		    end
		    if (MEM_W_EN) begin
			    SRAM_WE_N <= 1'b0;
                next_state <= 3'd2;
                ready <= 1'b0;
		    end
		    
		end

		3'd2: begin
            next_state <= 3'd3;
            SRAM_WE_N <= 1'b1;
            ready <= 1'b0;		    
		end

		3'd3: begin
		    next_state <= 3'd4;
            ready <= 1'b0;
		end

		3'd4: begin
		    next_state <= 3'd5;
            ready <= 1'b0;
		end

		3'd5: begin
		    next_state <= 3'd0;
            ready <= 1'b1;
		end

	endcase

end

assign SRAM_DQ = (MEM_W_EN && (state == 3'd1)) ? Val_Rm[31:16] : ((MEM_W_EN && (state == 3'd0)) ? Val_Rm[15:0] : 16'bz);
assign SRAM_ADDR = (state == 3'd0) ? {adr[18:2], 1'b0} : (state == 3'd1) ? {adr[18:2], 1'b1} : 0;

endmodule