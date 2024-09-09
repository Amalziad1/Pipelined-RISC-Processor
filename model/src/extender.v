module Extender(		  
	input immediate_signal, //to determine if I-type or S-type, 0 for I and 1 for S
    input [4:0] I_immediate, 	//5 bit immediate in I-type
	input [8:0] S_immediate, //8 bit immediate in S-type
	input wire extOp, 
    output reg [15:0] extended // 16-bit extended output
);

    always @(*) begin
        if (immediate_signal) begin	   // S type   
			if (extOp) begin
				extended = {{7{S_immediate[8]}}, S_immediate}; 
			end				 
			else begin
				extended = {7'b0000000, S_immediate};
			end
			
		end else begin				// I type  	
			if (extOp) begin   
	            extended = {{11{I_immediate[4]}}, I_immediate};	 
			end
			else begin
				extended = {11'b00000000000, I_immediate};	
	        end   
	end
	
    end

endmodule
