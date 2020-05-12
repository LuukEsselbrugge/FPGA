
module barcodescanner_nios (
	clk_clk,
	leds_external_connection_export,
	onchip_memory2_1_s2_address,
	onchip_memory2_1_s2_chipselect,
	onchip_memory2_1_s2_clken,
	onchip_memory2_1_s2_write,
	onchip_memory2_1_s2_readdata,
	onchip_memory2_1_s2_writedata,
	switches_external_connection_export);	

	input		clk_clk;
	output	[7:0]	leds_external_connection_export;
	input	[11:0]	onchip_memory2_1_s2_address;
	input		onchip_memory2_1_s2_chipselect;
	input		onchip_memory2_1_s2_clken;
	input		onchip_memory2_1_s2_write;
	output	[7:0]	onchip_memory2_1_s2_readdata;
	input	[7:0]	onchip_memory2_1_s2_writedata;
	input	[7:0]	switches_external_connection_export;
endmodule
