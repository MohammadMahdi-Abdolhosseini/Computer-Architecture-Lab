module PC(
	input clk, rst, freeze,
	input [31:0] PC_in, 
	output reg [31:0] PC_out);

	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1)
			PC_out <= 0;
		else
			if(freeze == 1'b0)
				PC_out <= PC_in;
	end
 endmodule

