module MUX2to1 (
    input [15:0] in0,    
    input [15:0] in1,    
    input sel,     
    output reg [15:0] out 
);

    always @(*) begin
        case (sel)
            1'b0: out = in0;
            1'b1: out = in1;   
            default: out = 16'b0;
        endcase
    end

endmodule 


 

 
 
 
 