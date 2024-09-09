module InstructionMemory (		 
    input wire [15:0] pc,
    output reg [15:0] instruction
);
    // byte addressable
    reg [7:0] instruction_memory [0:255];

    initial begin		
		// I-Type instruction  
		// addi r4,r5,10
        instruction_memory[0] = 8'b10101010;
        instruction_memory[1] = 8'b00111100; /*					 
		// J-Type instruction (example values)
        instruction_memory[0] = 8'b00000100;
        instruction_memory[1] = 8'b11000000; 
		
        
        // S-Type instruction	
		// sv r4,8
        instruction_memory[4] = 8'b00001000;
        instruction_memory[5] = 8'b11111000; 
		// add r1,r2,r3 
        instruction_memory[6] = 8'b10011000;
        instruction_memory[7] = 8'b00010010;
		
		// branch 
		// beq r4,r6,0
        instruction_memory[10] = 8'b11000000;
        instruction_memory[11] = 8'b10100100;
        /*
        instruction_memory[6] = 8'b11110011;
        instruction_memory[7] = 8'b00000001; */	
		
		  /*
		
        // R-Type instruction  Lbu
        instruction_memory[4] = 8'b10001000;
        instruction_memory[5] = 8'b00000010;
        // I-Type instruction
        instruction_memory[6] = 8'b01100000;
        instruction_memory[7] = 8'b01101011;
        // S-Type instruction
        instruction_memory[8] = 8'b00000010;
        instruction_memory[9] = 8'b11110100;   */
    end

    always @(*) begin
        instruction <= {instruction_memory[pc+1], instruction_memory[pc]};
    end
endmodule
