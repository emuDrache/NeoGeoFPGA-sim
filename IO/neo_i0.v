`timescale 1ns/1ns

module neo_i0(
	input nRESET,
	input nCOUNTOUT,
	input [2:0] M68K_ADDR,
	input M68K_ADDR_7,
	output reg COUNTER1,
	output reg COUNTER2,
	output reg LOCKOUT1,
	output reg LOCKOUT2
);

	wire nI0DATA;
	
	// A7=Counter/lockout data
	// A1=1/2
	// A2=Counter/lockout

	always @(nCOUNTOUT, nRESET)
	begin
		if (!nRESET)
		begin
			COUNTER1 <= 1'b0;
			COUNTER2 <= 1'b0;
			LOCKOUT1 <= 1'b0;
			LOCKOUT2 <= 1'b0;
		end
		else
		begin
			if (!nCOUNTOUT)
			begin
				if (M68K_ADDR[2:1] == 2'b00) COUNTER1 <= M68K_ADDR_7;
				if (M68K_ADDR[2:1] == 2'b01) COUNTER2 <= M68K_ADDR_7;
				if (M68K_ADDR[2:1] == 2'b10) LOCKOUT1 <= M68K_ADDR_7;
				if (M68K_ADDR[2:1] == 2'b11) LOCKOUT2 <= M68K_ADDR_7;
			end
		end
	end
	
endmodule
