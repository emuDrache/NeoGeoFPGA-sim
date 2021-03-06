`timescale 1ns/1ns

// 16K palette RAM (2x 100ns 8192*8bit RAM)

module palram(
	input [12:0] ADDR,
	inout [15:0] PC,
	input nPALWE
);

	palram_l PRAML(ADDR, PC[7:0], nPALWE, 1'b0, 1'b0);
	palram_u PRAMU(ADDR, PC[15:8], nPALWE, 1'b0, 1'b0);

endmodule
