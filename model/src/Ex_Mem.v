module EX_MEM (
    input clk, rst,
    input [15:0] alu_out_in, regB_in,
    input [2:0] rd_in,
    input RegWrite_in,
    input MemRead_in,
    input MemWrite_in,
    input MemToReg_in,
    input EXMEM_RegWrite_in,
    input MEMWB_RegWrite_in,
    input flush,
    output reg RegWrite_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemToReg_out,
    output reg EXMEM_RegWrite_out,
    output reg MEMWB_RegWrite_out,
    output reg [15:0] alu_out_out, regB_out,
    output reg [2:0] rd_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            alu_out_out <= 16'b0;
            regB_out <= 16'b0;
            rd_out <= 3'b0;
            RegWrite_out <= 0;
            MemRead_out <= 0;
            MemWrite_out <= 0;
            MemToReg_out <= 0;
            EXMEM_RegWrite_out <= 0;
            MEMWB_RegWrite_out <= 0;
        end else if (flush) begin
            /*alu_out_out <= 16'b0;
            regB_out <= 16'b0;
            rd_out <= 3'b0;*/
            RegWrite_out <= 0;
            MemRead_out <= 0;
            MemWrite_out <= 0;
            MemToReg_out <= 0;
            EXMEM_RegWrite_out <= 0;
            MEMWB_RegWrite_out <= 0;
        end else begin
            alu_out_out <= alu_out_in;
            regB_out <= regB_in;
            rd_out <= rd_in;
            RegWrite_out <= RegWrite_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            MemToReg_out <= MemToReg_in;
            EXMEM_RegWrite_out <= EXMEM_RegWrite_in;
            MEMWB_RegWrite_out <= MEMWB_RegWrite_in;
        end
    end
endmodule
