module MUX4to1 (
    input [15:0] in0,    
    input [15:0] in1,    
    input [15:0] in2,    
    input [15:0] in3,   
    input [1:0] sel,     
    output reg [15:0] out 
);

    always @(*) begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = 16'b0;
        endcase
    end

endmodule 


 

 
 
 
 