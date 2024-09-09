module register_file #(parameter REG_WIDTH = 3, DATA_WIDTH = 16, NUM_REGS = 8)(
    input wire clk,
    input wire rst,    
    input [3:0]opcode, //for call and return instruction
    input [15:0] currentPC,
    output reg [15:0] PCout,
    input wire [REG_WIDTH-1:0] rd,  // Destination register
    input wire [REG_WIDTH-1:0] rs1, // Source register 1
    input wire [REG_WIDTH-1:0] rs2, // Source register 2
    input wire [DATA_WIDTH-1:0] write_data,  // Data to be written to the destination register
    input wire reg_write,  // Register write enable signal
    output reg [DATA_WIDTH-1:0] read_data1,
    output reg [DATA_WIDTH-1:0] read_data2
);

    reg [DATA_WIDTH-1:0] regs [0:NUM_REGS-1];

    // Initialize registers with hardcoded values
    initial begin
        regs[1] = 16'h0001; // Register 1
        regs[2] = 16'h0002; // Register 2
        regs[3] = 16'h0003; // Register 3
        regs[4] = 16'h0004; // Register 4
        regs[5] = 16'h0005; // Register 5
        regs[6] = 16'h0006; // Register 6
    end
											 
    always @(posedge clk or posedge rst) begin	  //
        if (rst) begin
            // Reset all registers to 0
            regs[0] <= 16'h0000;
            regs[1] <= 16'h0001; // Register 1
            regs[2] <= 16'h0002; // Register 2
            regs[3] <= 16'h0003; // Register 3
            regs[4] <= 16'h0004; // Register 4
            regs[5] <= 16'h0005; // Register 5
            regs[6] <= 16'h000f; // Register 6
            regs[7] <= 16'h0000; // 
        end else if (reg_write) begin
            regs[rd] <= write_data;
        end	else if (opcode == 4'b0110)begin
			regs[7]	<= currentPC;  
			PCout = currentPC;
			end
    end

    // Read operations
    always @(*) begin
        read_data1 = regs[rs1];
        read_data2 = regs[rs2];
		if (opcode==4'b1110)begin
			PCout = regs[7];									   
		end 
    end

endmodule
