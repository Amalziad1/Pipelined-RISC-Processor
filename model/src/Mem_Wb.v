module MEM_WB (
    input clk, rst,
    input [15:0] data,
    input [2:0] rd_in,	
	input RegWrite_in,
	input MEMWB_RegWrite_in,
	input flush,
	output reg RegWrite_out,
	output reg MEMWB_RegWrite_out,
    output reg [15:0] data_out,
    output reg [2:0] rd_out
);
    always @(negedge clk or posedge rst or flush) begin
        if (rst) begin
            data_out <= 16'b0;	 
            rd_out <= 3'b0;	
			RegWrite_out<=0;
			MEMWB_RegWrite_out<=0;
        end else if(flush) begin
			/*data_out <= 16'b0;	 
            rd_out <= 3'b0;	*/
			RegWrite_out<=0;
			MEMWB_RegWrite_out<=0;
		end else begin
            data_out <= data;		 
            rd_out <= rd_in;  
			RegWrite_out<=RegWrite_in;
			MEMWB_RegWrite_out<=MEMWB_RegWrite_in;
        end
    end
endmodule
