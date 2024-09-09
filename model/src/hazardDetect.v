module HazardForwardStallUnit(
    input wire [15:0] IDEX_rs, IDEX_rt,
    input wire [2:0] IFID_rs, IFID_rt,
    input wire  [2:0] IDEX_rd, EXMEM_rd, MEMWB_rd, WB_rd,
    input wire IDEX_MemRead, EXMEM_RegWrite, MEMWB_RegWrite, WB_RegWrite,
    output reg stall,flush,  IFID_Write, PC_Write,
    output reg [1:0] forwardA, forwardB
);
    always @(*) begin
        // Default values
        stall = 0;
       	flush = 0;
        IFID_Write = 1;
        PC_Write = 1;
        forwardA = 2'b00;
        forwardB = 2'b00;
        
        // Hazard Detection Logic
        if (IDEX_MemRead && ((IDEX_rt == IFID_rs) || (IDEX_rt == IFID_rt))) begin
            stall = 1;
           	flush = 1;
            IFID_Write  = 0;
            PC_Write = 0;
        end
        
        // Forwarding Logic
        // EX hazard
        if (EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rs))
            forwardA = 2'b01;
        if (EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rt))
            forwardB = 2'b01;
        
        // MEM hazard
        if (MEMWB_RegWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_rs) && !(EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rs)))
            forwardA = 2'b10;
        if (MEMWB_RegWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_rt) && !(EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rt)))
            forwardB = 2'b10;

        // WB hazard 
        if (WB_RegWrite && (WB_rd != 0) && (WB_rd == IDEX_rs) && !(EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rs)) && !(MEMWB_RegWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_rs)))
            forwardA = 2'b11;
        if (WB_RegWrite && (WB_rd != 0) && (WB_rd == IDEX_rt) && !(EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rt)) && !(MEMWB_RegWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_rt)))
            forwardB = 2'b11;
    end
endmodule
