module IF_ID #(parameter OPCODE_WIDTH = 4, REG_WIDTH = 3, I_IMM_WIDTH = 5, S_IMM_WIDTH = 9, JMP_OFFSET_WIDTH = 12)(
   	 input wire IFIDwr,
	input wire clk, rst,
    input wire [OPCODE_WIDTH-1:0] opcode_in,
    input wire [REG_WIDTH-1:0] rd_in,
    input wire [REG_WIDTH-1:0] rs1_in,
    input wire [REG_WIDTH-1:0] rs2_in,
    input wire [I_IMM_WIDTH-1:0] I_immediate_in,
    input wire [S_IMM_WIDTH-1:0] S_immediate_in,
    input wire [JMP_OFFSET_WIDTH-1:0] jmp_offset_in,
    input wire mode_in,	 /*
    input wire is_rtype_in,
    input wire is_itype_in,
    input wire is_jtype_in,
    input wire is_stype_in,	 */
	input [15:0] currentPC,
	output reg [15:0] currentPCout,
    output reg [OPCODE_WIDTH-1:0] opcode_out,
    output reg [REG_WIDTH-1:0] rd_out,
    output reg [REG_WIDTH-1:0] rs1_out,
    output reg [REG_WIDTH-1:0] rs2_out,
    output reg [I_IMM_WIDTH-1:0] I_immediate_out,
    output reg [S_IMM_WIDTH-1:0] S_immediate_out,
    output reg [JMP_OFFSET_WIDTH-1:0] jmp_offset_out,
    output reg mode_out   /*
    output reg is_rtype_out,
    output reg is_itype_out,
    output reg is_jtype_out,
    output reg is_stype_out	*/
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            opcode_out <= 0;
            rd_out <= 0;
            rs1_out <= 0;
            rs2_out <= 0;
            I_immediate_out <= 0;
            S_immediate_out <= 0;
            jmp_offset_out <= 0;
            mode_out <= 0;
			currentPCout <= 0;
			/*
            is_rtype_out <= 0;
            is_itype_out <= 0;
            is_jtype_out <= 0;
            is_stype_out <= 0; */
        end else 
		         if(IFIDwr)begin
            opcode_out <= opcode_in;
            rd_out <= rd_in;
            rs1_out <= rs1_in;
            rs2_out <= rs2_in;
            I_immediate_out <= I_immediate_in;
            S_immediate_out <= S_immediate_in;
            jmp_offset_out <= jmp_offset_in;
            mode_out <= mode_in;
			currentPCout <= currentPC;/*
            is_rtype_out <= is_rtype_in;
            is_itype_out <= is_itype_in;
            is_jtype_out <= is_jtype_in;
            is_stype_out <= is_stype_in;  */
        end
    end
endmodule

module mux2x1Rd(
	input [2:0] r1, 
	input [2:0] r2,
	input sel,
	output reg [2:0] selectedR);
	always @(*) begin
		if(sel == 0) begin
			selectedR = r1 ;
		end				   
	else begin
		selectedR = r2;
	end
	end
endmodule

		
	