module returnLogic (
    input [15:0] returnPC, 
    input jumpSignal,
    output reg [15:0] jumpTarget
);
    always @(*) begin
        if (jumpSignal) begin
            jumpTarget = (returnPC + 2) << 1; //shifted offset maintains 16-bit length
        end 
    end
endmodule
