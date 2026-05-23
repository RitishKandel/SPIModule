module avalon_mm_regs (
    input wire clk,
    input wire reset,

    // Avalon
    input  wire [ 3:0] address,
    input  wire        write,
    input  wire        read,
    input  wire [31:0] writedata,
    output reg  [31:0] readdata,


    input wire        busy,
    input wire        rxne,
    input wire        txe,
    input wire [31:0] rx_data,

    output wire [31:0] cr1_out,
    output wire [31:0] cr2_out,
    output wire [31:0] dr_out,
    output wire        tx_valid
);
  reg [31:0] cr1_reg;
  reg [31:0] cr2_reg;
  reg [31:0] dr_reg;
  reg        tx_valid_reg;

  assign cr1_out  = cr1_reg;
  assign cr2_out  = cr2_reg;
  assign dr_out   = dr_reg;
  assign tx_valid = tx_valid_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      cr1_reg      <= 32'h0;
      cr2_reg      <= 32'h0;
      dr_reg       <= 32'h0;
      tx_valid_reg <= 1'b0;
    end else begin
      tx_valid_reg <= 1'b0;
      if (write) begin
        case (address)
          4'h0:    cr1_reg <= writedata;
          4'h1:    cr2_reg <= writedata;
          4'h3: begin
            dr_reg       <= writedata;
            tx_valid_reg <= 1'b1;
          end
          default: ;
        endcase
      end
    end
  end

  // Read
  always @(posedge clk) begin
    if (read) begin
      case (address)
        4'h0: readdata <= cr1_reg;
        4'h1: readdata <= cr2_reg;
        4'h2: readdata <= {24'h0, busy, 5'h0, txe, rxne};
        4'h3: readdata <= rx_data;
        default: readdata <= 32'h0;
      endcase
    end
  end

endmodule
