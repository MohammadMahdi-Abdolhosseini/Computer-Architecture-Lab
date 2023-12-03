module RegisterFile(
	input clk, rst,
	input [3:0] SRC1, SRC2, Dest_WB,
	input [31:0] Result_WB,
	input WriteBackEn,

	output reg [31:0] REG1, REG2
);
	reg [31:0] register[0:14];
	integer i;
	always@(negedge clk, posedge rst)
	begin
		if (rst)
		begin
			for(i = 0; i < 15; i = i + 1)
			begin
				register[i] <= i;
			end
		end
		else 
		begin
			if(WriteBackEn)
			begin
				register[Dest_WB] <= Result_WB;
			end	
		end
	end
	assign {REG1, REG2} = {register[SRC1], register[SRC2]};
endmodule
