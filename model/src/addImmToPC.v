module addImmToPC(
	input branchSignal,
	input [15:0] pc,            
    input [15:0] offset, // after extension
	output reg [15:0] pcout);
	always @(*) begin
		if (branchSignal) begin
			pcout=pc + offset;
		end else begin
			pcout=pc+2;  
		end
	end
endmodule
