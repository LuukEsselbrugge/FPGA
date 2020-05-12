
module ctest_nios (
	clk_clk,
	leds_external_connection_export,
	switches_external_connection_export);	

	input		clk_clk;
	output	[7:0]	leds_external_connection_export;
	input	[7:0]	switches_external_connection_export;
endmodule
