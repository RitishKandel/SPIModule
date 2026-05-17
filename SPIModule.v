//Input
//- DS[4:0]
//- clk50 
//- BR[2:0]
//- SPE
//- MSTR
//- CPOL
//- CPHA


//Output 
//- SCLK
//- MOSI
//- MISO 
module SPIModule (
	input clk50, 
	input [4:0] DS, 
	input [2:0] BR, 
	input SPE, 
	input MSTR, 
	input CPOL, 
	input CPHA, 
	input rst_n, 
	
	output SCK, 
	output MOSI
); 


	wire dividedClk;
	// Send the same number of clock pulses as the number of DS
	reg SCKReg; 
	reg [4:0] DSReg; 

	ClkDivider clkdivider (
		.MR_n(rst_n), 
		.CEP(1'b1), 
		.clk50(clk50),
		.clkSelector(BR),
		.clkOut(dividedClk)
	);
	
	always @(posedge dividedClk or negedge rst_n)
	begin 
		if(!rst_n)
			begin 
				DSReg <= DS; 
				SCKReg <= 0; 
			end
		else 
			begin 
			if(DSReg !== 0)
				begin
					SCKReg <= ~SCKReg; 
					DSReg <= DSReg - 1; 
				end
			else 
				begin 
					SCKReg <= SCKReg; 
				end
			end
	end
	

endmodule