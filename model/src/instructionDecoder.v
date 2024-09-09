module instruction_decoder #(parameter OPCODE_WIDTH = 4, REG_WIDTH = 3, I_IMM_WIDTH = 5,S_IMM_WIDTH=9, JMP_OFFSET_WIDTH = 12)(	
	//input clk,
    input wire [15:0] instruction,	
	input [15:0] currentPC,
	output reg [15:0] currentPCout,
    output reg [OPCODE_WIDTH-1:0] opcode,
    output reg [REG_WIDTH-1:0] rd,
    output reg [REG_WIDTH-1:0] rs1,
    output reg [REG_WIDTH-1:0] rs2,
    output reg [I_IMM_WIDTH-1:0] I_immediate,	
	output reg [S_IMM_WIDTH-1:0] S_immediate,	 
    output reg [JMP_OFFSET_WIDTH-1:0] jmp_offset, 
	output reg mode 
	/*
    output reg is_rtype,
    output reg is_itype,
    output reg is_jtype,
    output reg is_stype*/
);

    always @(*) begin
        opcode = instruction[15:12];  
		currentPCout <= currentPC; 
		mode=0;
        case (opcode)
            // R-Type
            4'b0000, 4'b0001, 4'b0010: begin
                rd = instruction[11:9];
                rs1 = instruction[8:6];
                rs2 = instruction[5:3];
            end
            // I-Type
            4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111: begin
				mode = instruction[11];
                rd = instruction[10:8];
                rs1 = instruction[7:5];
                I_immediate = instruction[4:0];
			end
			// I-Type branches
			4'b1000, 4'b1001, 4'b1010, 4'b1011 : begin
				mode = instruction[11];	 
				rd = instruction[10:8];
				if(mode == 1) begin	 
	                rs1 = 3'b000;
	            end else begin
					rs1 = instruction[7:5];
                end	 
                I_immediate = instruction[4:0];
            end
            // J-Type
            4'b1100, 4'b1101: begin
                jmp_offset = instruction[11:0];	/*    
                is_rtype = 0;	  
                is_itype = 0;
                is_jtype = 1;
                is_stype = 0;		 */
            end
            // RET (J-Type format with unused fields)
            4'b1110: begin
                jmp_offset = 12'b0; // unused
				
               /* is_rtype = 0;
                is_itype = 0;
                is_jtype = 1;
                is_stype = 0;  */
            end
            // S-Type
            4'b1111: begin
                rs1 = instruction[11:9];
                S_immediate = instruction[8:0];	/*
                is_rtype = 0;
                is_itype = 0;
                is_jtype = 0;
                is_stype = 1; */
            end
            default: begin
                rd = 0;
                rs1 = 0;
                rs2 = 0;
                I_immediate = 0;  
				S_immediate = 0;
                jmp_offset = 0;	 /*
                is_rtype = 0;
                is_itype = 0;
                is_jtype = 0;
                is_stype = 0;	 */
            end
        endcase
    end

endmodule