module SRAM(
    input clk, rst,


    inout [15:0] SRAM_DQ, // IN OUT


	input reg [17:0] SRAM_ADDR,
	input SRAM_UB_N,
	input SRAM_LB_N,
	input SRAM_WE_N,
	input SRAM_CE_N,
	input SRAM_OE_N
);

reg [17:0] MEM[0:63];

always @(negedge clk) begin
	if (~SRAM_WE_N)
		MEM[SRAM_ADDR] <= SRAM_DQ;
end
    
assign SRAM_DQ = SRAM_WE_N? MEM[SRAM_ADDR] : SRAM_DQ;

endmodule