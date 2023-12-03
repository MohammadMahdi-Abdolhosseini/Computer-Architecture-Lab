module Memory (
	input clk, rst, MEM_R_EN, MEM_W_EN, 
    input [31:0] ALU_Res, Val_Rm, 

    output [31:0] DATA
);
           
reg [31:0] MEM[0:63];
wire [5:0] adr;

assign adr = (ALU_Res - 32'd1024)>>2;

always @(negedge clk) begin
	if (MEM_W_EN)
		MEM[adr] <= Val_Rm;
end

assign DATA = MEM_R_EN ? MEM[adr] : 32'b0;

endmodule
