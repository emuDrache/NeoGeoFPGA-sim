`timescale 1ns/1ns

// 200ns 128k*8bit ROM (should be 250ns at extreme worst)

module rom_s1(
	input [16:0] ADDR,
	output [7:0] OUT
);

	reg [7:0] ROMDATA[0:131071];

	initial begin
		$readmemh("rom_s1.txt", ROMDATA);
	end

	assign #200 OUT = ROMDATA[ADDR];

endmodule
