module ByteAddressableMemory (
    input wire clk,
    input wire reset,
    input wire [15:0] address,
    input wire [15:0] data_in,
    input wire mem_write,
    input wire mem_read,
    output reg [15:0] data_out
);
    reg [7:0] memory [0:255];
      /*
    initial begin
        // Initialize memory with some values
        memory[0] = 8'h11;
        memory[1] = 8'h22;
        memory[2] = 8'h33;
        memory[3] = 8'h44;
    end		   */

    always @(posedge clk) begin	//
        if (reset) begin
            for (int i = 0; i < 256; i = i + 1) begin
                memory[i] <= 8'b0;
            end		 
			memory[0] = 8'h11;
	        memory[1] = 8'h22;
	        memory[2] = 8'h33;
	        memory[3] = 8'h44;
        end else begin
            if (mem_write) begin
                memory[address] <= data_in[7:0];       // Lower byte
                memory[address + 1] <= data_in[15:8];  // Upper byte
            end
            if (mem_read) begin
                data_out <= {memory[address + 1], memory[address]};
            end
        end
    end
endmodule
