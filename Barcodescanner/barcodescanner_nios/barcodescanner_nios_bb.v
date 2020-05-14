
module barcodescanner_nios (
	clk_clk,
	leds_external_connection_export,
	switches_external_connection_export,
	videoram_address,
	videoram_chipselect,
	videoram_clken,
	videoram_write,
	videoram_readdata,
	videoram_writedata,
	videoram_byteenable);	

	input		clk_clk;
	output	[7:0]	leds_external_connection_export;
	input	[7:0]	switches_external_connection_export;
	input	[11:0]	videoram_address;
	input		videoram_chipselect;
	input		videoram_clken;
	input		videoram_write;
	output	[31:0]	videoram_readdata;
	input	[31:0]	videoram_writedata;
	input	[3:0]	videoram_byteenable;
endmodule
