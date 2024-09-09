module jumpLogic(
    input [15:0] pc,            
    input [11:0] jumpOffset, 
	input jumpSignal,
    output reg [15:0] jumpTarget 
);
    always @(*) begin
        if (jumpSignal) begin
            jumpTarget = {pc[15:10], jumpOffset[9:0]};
        end else begin
            //if the jump offset is zero, the jump target is the current PC (no jump)
            jumpTarget = pc+2;
        end
    end
endmodule
