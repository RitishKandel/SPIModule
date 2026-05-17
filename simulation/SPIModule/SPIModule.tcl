	# input clk50, 
	# input [4:0] DS, 
	# input [2:0] BR, 
	# input SPE, 
	# input MSTR, 
	# input CPOL, 
	# input CPHA, 
	# input rst_n, 
	# 
	# output SCK, 
	# output MOSI
proc runSim {} {
	restart -force -nowave
	force -freeze DS 0111
	force -freeze BR 0000
	
	add wave SCKReg
	add wave dividedClk
	add wave rst_n
	add wave DSReg
	
	property wave -radix hex * 

	force -deposit clk50 1 0, 0 {10ns} -repeat 20ns

	force -freeze rst_n  1
	run 10ns
	force -freeze rst_n 0 
	run 10ns
	force -freeze rst_n 1 
	

	run 800ns
}

