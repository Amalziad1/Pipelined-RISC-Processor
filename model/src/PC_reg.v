module PCReg(
	input clk,
	input [15:0] pc_nxt,
	input rst,			
	input PCwrite,
	output reg [15:0] pc);	   
	reg [1:0] counter=0;
	always@(posedge clk or posedge rst)begin	//
		counter=counter+1;
		if(rst) begin
			pc <= 16'b0;
		end
	else begin
		if(counter==2)begin	
			counter=0;
			if (PCwrite) begin
			pc <= pc_nxt;
			end
		end
		
	end	 
	end
endmodule		

module add2(input [15:0] pcIn,output reg [15:0] pcout);
	always @(*) begin					  
        pcout = pcIn + 16'b0000000000000010; 	
    end				  
endmodule
