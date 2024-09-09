module signalsControlUnit (
    input [3:0] opcode,    // 4-bit opcode from the instruction
    input wire mode,
    //input zero,            // Zero flag from the ALU
    input branchFlag,		  
	input stall,
    output reg extOp,      // Extension operation
    output reg [1:0] PCSrc, // Control source for the next PC value
    //output reg PCWrite,    // Enables writing to the PC register
    output reg RegDst,     // Selects the destination register for the write operation
    output reg RegWrite,   // Enables writing to the register file
    output reg ALUSrcB,    // Selects the second operand for the ALU
    output reg [2:0] ALUOp, // Specifies the operation to be performed by the ALU
    //output reg Branch,     // Indicates if the instruction is a branch instruction
    output reg MemRead,    // Enables reading from memory
    output reg MemWrite,   // Enables writing to memory
    output reg MemToReg,   // Selects the data to be written to the register file
    output reg Jump,       // Indicates if the instruction is a jump instruction
    output reg immediateType, // For S type and other types
    output reg IDEX_MemRead,  // Memory read signal for ID/EX stage
    output reg EXMEM_RegWrite, // Register write signal for EX/MEM stage
    output reg MEMWB_RegWrite, // Register write signal for MEM/WB stage   
);

localparam AND   = 4'b0000;
localparam ADD   = 4'b0001;
localparam SUB   = 4'b0010;
localparam ADDI  = 4'b0011;
localparam ANDI  = 4'b0100;
localparam LW    = 4'b0101;
localparam LB    = 4'b0110;
localparam SW    = 4'b0111;
localparam BGT   = 4'b1000;
localparam BLT   = 4'b1001;
localparam BEQ   = 4'b1010;
localparam BNE   = 4'b1011;	
localparam JMP   = 4'b1100;
localparam CALL  = 4'b1101;
localparam RET   = 4'b1110;
localparam Sv    = 4'b1111;

always @(*) begin
    PCSrc = 2'b00;
    //PCWrite = 0;
    RegDst = 0;
    RegWrite = 0;
    ALUSrcB = 0;
    ALUOp = 3'b101;
    //Branch = 0;
    MemRead = 0;
    MemWrite = 0;
    MemToReg = 0;
    Jump = 0;
    extOp = 0;
    immediateType = 0;
    IDEX_MemRead = 0;
    EXMEM_RegWrite = 0;
    MEMWB_RegWrite = 0;	

    if(stall !=1) begin
		case (opcode)
        AND: begin
            RegDst = 1;
            RegWrite = 1;
            ALUOp = 3'b010;
        end
        ADD: begin
            RegDst = 1;
            RegWrite = 1;
            ALUOp = 3'b000;
        end
        SUB: begin
            RegDst = 1;
            RegWrite = 1;
            ALUOp = 3'b001;
        end
        ADDI: begin
            RegWrite = 1;
            ALUSrcB = 1; // Immediate
            ALUOp = 3'b000;
        end
        ANDI: begin
            RegWrite = 1;
            ALUSrcB = 1;
            ALUOp = 3'b010;
        end
        LW: begin
            RegWrite = 1;
            ALUSrcB = 1;
            MemRead = 1;
            MemToReg = 1;
			MEMWB_RegWrite=1;
            ALUOp = 3'b000;
            IDEX_MemRead = 1;
        end
        LB: begin
            RegWrite = 1;
            ALUSrcB = 1;
            MemRead = 1;
            MemToReg = 1;  
			MEMWB_RegWrite=1;
            ALUOp = 3'b000;
            extOp = mode ? 1 : 0;
            IDEX_MemRead = 1;
        end
        SW: begin
            ALUSrcB = 1;
            MemWrite = 1;
            ALUOp = 3'b000;
        end			
        BGT: begin
            //Branch = 1;
            //ALUSrcB = 0;
            //ALUOp = 3'b111;
            PCSrc = (branchFlag == 1) ? 2'b01 : 2'b00;
            //PCWrite = (branchFlag == 1) ? 1 : 0;
        end
        BLT: begin
            //Branch = 1;
            //ALUSrcB = 0;
            //ALUOp = 3'b100;
            PCSrc = (branchFlag == 1) ? 2'b01 : 2'b00;
            //PCWrite = (branchFlag == 1) ? 1 : 0;
        end
        BEQ: begin
            //Branch = 1;
            //ALUSrcB = 0;
            //ALUOp = 3'b001;
            PCSrc = (branchFlag == 1) ? 2'b01 : 2'b00;
            //PCWrite = (zero == 1) ? 1 : 0;
        end
        BNE: begin
            //Branch = 1;
            //ALUSrcB = 0;
            //ALUOp = 3'b001;
            PCSrc = (branchFlag == 0) ? 2'b01 : 2'b00;
            //PCWrite = (zero == 0) ? 1 : 0;
        end	  
        JMP: begin
            Jump = 1;
            PCSrc = 2'b10; 
			ALUOp = 3'b101;
            //PCWrite = 1;
        end
        CALL: begin
            Jump = 1;
            PCSrc = 2'b10;
            //PCWrite = 1;
            RegWrite = 1;
            ALUOp = 3'b101;
            EXMEM_RegWrite = 1;
        end
        RET: begin
            Jump = 1;
            PCSrc = 2'b11;
            //PCWrite = 1;
            ALUOp = 3'b101;
            //EXMEM_RegWrite = 1;	////=================
        end
        Sv: begin
			PCSrc = 2'b00;
            MemWrite = 1;
            ALUSrcB = 1;
            immediateType = 1;
        end
        default: begin
            PCSrc = 2'b00;
            //PCWrite = 0;
            RegDst = 0;
            RegWrite = 0;
            ALUSrcB = 0;
            ALUOp = 3'b101;
            //Branch = 0;
            MemRead = 0;
            MemWrite = 0;
            MemToReg = 0;
            Jump = 0;
            extOp = 0;
            immediateType = 0;
            IDEX_MemRead = 0;
            EXMEM_RegWrite = 0;
            MEMWB_RegWrite = 0;	
        end
    endcase
	end
	
end

endmodule
