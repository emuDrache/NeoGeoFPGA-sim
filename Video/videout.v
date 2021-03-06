`timescale 1ns/1ns

module videout(
	input CLK_6MB,
	input nBNKB,
	input SHADOW,
	input [15:0] PC,
	output reg [6:0] VIDEO_R,
	output reg [6:0] VIDEO_G,
	output reg [6:0] VIDEO_B,
	input [8:0] HCOUNT			// Sim only: Only used to limit output to active display
);

	// Sim only
	integer f;
	initial
	begin
		f = $fopen("video_output.txt", "w");
		#18000000			// Run for 18ms
		$fclose(f);
		$stop;
	end

	// Color data latch/blanking
	always @(posedge CLK_6MB)
	begin
		VIDEO_R <= nBNKB ? {SHADOW, PC[11:8], PC[14], PC[15]} : 7'b0000000;
		VIDEO_G <= nBNKB ? {SHADOW, PC[7:4], PC[13], PC[15]} : 7'b0000000;
		VIDEO_B <= nBNKB ? {SHADOW, PC[3:0], PC[12], PC[15]} : 7'b0000000;
		
		// Sim only
		if ((HCOUNT > 9'd2) && (HCOUNT < 9'd323)) $fwrite(f, "%04X ", PC);
		if (HCOUNT == 9'd328) $fwrite(f, "\n");
	end
	
endmodule
