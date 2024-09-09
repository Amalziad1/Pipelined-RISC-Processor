`timescale 1ns/1ps

module datapath_tb;
			  
    reg rst;
    reg clk;
											  
    datapath uut (
        .rst(rst), 
        .clk(clk)
    );
							   
    initial begin
        clk = 0;
        forever #5 clk = ~clk; //100MHz 
    end
										
    initial begin					   
        rst = 0;				
        #10;
        rst = 1;
        #10;
        rst = 0;
		/*
        #1000;
        $stop;	*/
    end	 

endmodule
