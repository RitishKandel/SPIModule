module piso (
    input wire clk,
    input wire reset_n,
    input wire load,
    input wire shift_en,


    input wire        lsb_first,
    input wire [ 5:0] data_width,
    input wire [31:0] data_in,

    output reg data_out
);

  reg [31:0] shift_reg;

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      shift_reg <= 32'h0;
      data_out  <= 1'b0;
    end else if (load) begin
      shift_reg <= data_in;
      // Starting index
      data_out  <= lsb_first ? data_in[0] : data_in[data_width-1];
    end else if (shift_en) begin
      if (lsb_first) begin

        shift_reg <= {1'b0, shift_reg[31:1]};
        data_out  <= shift_reg[1];
      end else begin

        shift_reg <= {shift_reg[30:0], 1'b0};
        data_out  <= shift_reg[data_width-1];
      end
    end
  end

endmodule
