# 	input MR_n,					// Master reset 
# 	input CEP, 					// Count enable
# 	input clk50,	 			// System clock, 50MHz
# 
# 	//	Bit 5:3 - BR[2:0]: Baud rate control 
# 	//		000: fPCLK/2
# 	//		001: fPCLK/4
# 	//		010: fPCLK/8
# 	//		011: fPCLK/16
# 	//		100: fPCLK/32
# 	//		101: fPCLK/64
# 	//		110: fPCLK/128
# 	//		111: fPCLK/256
# 	input [2:0] clkSelector,
# 	
# 	output clkOut				// Divided clock output
proc runSim {} {
	restart -force -nowave
	
	add wave clkOut
	add wave CEP
	add wave MR_n
	add wave clk50
	add wave clkSelector

	property wave -radix hex * 

	force -deposit clk50 1 0, 0 {10ns} -repeat 20ns

	force -freeze MR_n  1
	run 10ns
	force -freeze MR_n 0 
	run 10ns
	
	force -freeze MR_n 1
	force -freeze CEP 1 
	force -freeze clkSelector 0
	run 400ns


}

