module ID_EX (
    input clk, rst,
    input [15:0]  regA_in, regB_in,
    input [2:0] rd_in,  
    input [15:0] imm_in,	
    input RegWrite_in,
    input ALUSrcB_in,
    //input [3:0] opcode_in,
    input MemRead_in,
    input MemWrite_in,
    input MemToReg_in, 
	input IDEX_MemRead_in,
    input EXMEM_RegWrite_in,
    input MEMWB_RegWrite_in,
    input [2:0] ALUOp_in,
    input flush,	  
    output reg RegWrite_out,
    output reg ALUSrcB_out,
    //output reg [3:0] opcode_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemToReg_out,
	output reg IDEX_MemRead_out,
    output reg EXMEM_RegWrite_out,
    output reg MEMWB_RegWrite_out,
    output reg [2:0] ALUOp_out,
    //output reg flush_out,
    output reg [15:0] regA_out, regB_out,
    output reg [2:0] rd_out,
    output reg [15:0] imm_out // extended immediate
);					   
    always @(posedge clk or posedge rst) begin
        if (rst) begin		
            regA_out <= 16'b0;
            regB_out <= 16'b0;
            rd_out <= 3'b0;		 
            imm_out <= 16'b0; // Changed from 5'b0 to 16'b0
            RegWrite_out <= 0;
            ALUSrcB_out <= 0;				   
            MemRead_out <= 0;
            MemWrite_out <= 0;
            MemToReg_out <= 0;
			IDEX_MemRead_out<= 0;
            EXMEM_RegWrite_out <= 0;
            MEMWB_RegWrite_out <= 0;
            ALUOp_out <= 3'b0;	 
        end else if (flush) begin/*
            regA_out <= 16'b0;
            regB_out <= 16'b0;
            rd_out <= 3'b0;		 
            imm_out <= 16'b0;  */
            RegWrite_out <= 0;
            ALUSrcB_out <= 0;				   
            MemRead_out <= 0;
            MemWrite_out <= 0;
            MemToReg_out <= 0; 
			IDEX_MemRead_out<= 0;
            EXMEM_RegWrite_out <= 0;
            MEMWB_RegWrite_out <= 0;
            ALUOp_out <= 3'b0;	
        end else begin		  
            regA_out <= regA_in;
            regB_out <= regB_in;
            rd_out <= rd_in;   		
            imm_out <= imm_in;	
            RegWrite_out <= RegWrite_in;
            ALUSrcB_out <= ALUSrcB_in;				   
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            MemToReg_out <= MemToReg_in;
			IDEX_MemRead_out<= IDEX_MemRead_in;
            EXMEM_RegWrite_out <= EXMEM_RegWrite_in;
            MEMWB_RegWrite_out <= MEMWB_RegWrite_in;
            ALUOp_out <= ALUOp_in;	
        end
    end
endmodule
