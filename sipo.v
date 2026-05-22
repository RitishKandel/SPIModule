module sipo (
	input wire				clk,
	input wire 				data_in,
	input wire 				reset_n,
	input wire 				en,
	
	
	input wire				lsb_first,
	input wire [5:0]		data_width,
	
	output reg [31:0]		data_out
);

	reg [31:0] data;
	
	always @ (posedge clk or negedge reset_n) begin
		if (!reset_n) begin
		data_out <= 32'h0;
		end else if (en) begin
			if (lsb_first) begin
				data_out <= {data_in, data_out[31:1]};
			end else begin
				data_out <= {data_out[30:0], data_in};
			end
		end
	Q
	end
	

endmodule