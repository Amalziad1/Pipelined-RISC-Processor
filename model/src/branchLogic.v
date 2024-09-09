module branchLogic(
	input [3:0]opcode,
	input [15:0] rd,
	input [15:0] rs,
	input [15:0] immediate, // extended
	output reg branchSignal,
	output reg [15:0] offset  
	);	 
	always @(*) begin
		// default
		branchSignal=0;
		case(opcode)
			4'b1000: begin // bgt
				branchSignal=(rd > rs) ? 1 : 0;	
			end
			4'b1001	: begin	// blt
				branchSignal=(rd < rs) ? 1 : 0;	
			end	 
			4'b1010	: begin	//beq
				branchSignal=(rd == rs) ? 1 : 0;	
			end	
			4'b1011	: begin	//bne
				branchSignal=(rd != rs) ? 1 : 0;	
			end		
		endcase
		offset=immediate;
	end
endmodule
