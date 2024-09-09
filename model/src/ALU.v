module alu (
    input [15:0] A,         // First operand
    input [15:0] B,         // Second operand
    input [2:0] ALUOp,      // Control signal to select the ALU operation
    output reg [15:0] Result, // Result of the ALU operation
    //output reg Zero,        // Zero flag
    //output reg branchFlag,    
    //output reg Overflow     // Overflow flag
);

// Define ALU operations
localparam ADD = 3'b000;
localparam SUB = 3'b001;
localparam AND = 3'b010;
localparam OR  = 3'b011;
//localparam LT = 3'b100;
localparam NOP = 3'b101; 
//localparam GT = 3'b111;

// Temporary variables for intermediate calculations
reg [16:0] temp_result; // Extra bit for carry out
reg signed [15:0] signed_A, signed_B;

// ALU operation
always @(*) begin
    // Default values
    Result = 16'b0;
    //Zero = 0;
    //branchFlag = 0;
    //Overflow = 0;

    // Sign-extend operands for signed operations
    signed_A = A;
    signed_B = B;

    case (ALUOp)
        ADD: begin
            temp_result = A + B;
            Result = temp_result[15:0];
            //CarryOut = temp_result[16];
            //Overflow = ((A[15] == B[15]) && (Result[15] != A[15])) ? 1 : 0;
        end
        SUB: begin
            temp_result = A - B;
            Result = temp_result[15:0];
            //CarryOut = temp_result[16];
            //Overflow = ((A[15] != B[15]) && (Result[15] != A[15])) ? 1 : 0;
        end
        AND: begin
            Result = A & B;
        end
        OR: begin
            Result = A | B;
        end
        /*LT: begin
            branchFlag = (signed_A < signed_B) ? 16'b1 : 16'b0;
        end	  
		GT: begin
            branchFlag = (signed_A > signed_B) ? 16'b1 : 16'b0;
        end	   */
        NOP: begin
            Result = 16'b0;
        end
        default: begin
            Result = 16'b0;
        end
    endcase
					
    //Zero = (Result == 16'b0) ? 1 : 0;
end

endmodule
