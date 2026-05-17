module ClkDivider (
	input MR_n,					// Master reset 
	input CEP, 					// Count enable
	input clk50,	 			// System clock, 50MHz

	//	Bit 5:3 - BR[2:0]: Baud rate control 
	//		000: fPCLK/2
	//		001: fPCLK/4
	//		010: fPCLK/8
	//		011: fPCLK/16
	//		100: fPCLK/32
	//		101: fPCLK/64
	//		110: fPCLK/128
	//		111: fPCLK/256
	input [2:0] clkSelector,
	
	output clkOut				// Divided clock output
);

// Need to divide clk by maximum 256 
// log2(256) = 8 
reg [7:0] counterValue; 

always @(posedge(clk50))
	begin 
		if(MR_n == 1'b0)
			begin
				counterValue = 10'b0000000000; 
			end
		else if(CEP == 1'b1)
			begin 
				// The counter is active, so check to see whether 
				// it has expired (wrap around)
				if(counterValue == 10'b1111111111)
					begin 
						counterValue = 10'b0000000000; 
					end
				else 
					begin 
						counterValue = counterValue + 1; 
					end
			end
		else 
			counterValue = counterValue; 

end


assign clkOut = counterValue[clkSelector];

endmodule