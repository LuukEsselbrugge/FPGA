	barcodescanner_nios u0 (
		.clk_clk                             (<connected-to-clk_clk>),                             //                          clk.clk
		.leds_external_connection_export     (<connected-to-leds_external_connection_export>),     //     leds_external_connection.export
		.onchip_memory2_1_s2_address         (<connected-to-onchip_memory2_1_s2_address>),         //          onchip_memory2_1_s2.address
		.onchip_memory2_1_s2_chipselect      (<connected-to-onchip_memory2_1_s2_chipselect>),      //                             .chipselect
		.onchip_memory2_1_s2_clken           (<connected-to-onchip_memory2_1_s2_clken>),           //                             .clken
		.onchip_memory2_1_s2_write           (<connected-to-onchip_memory2_1_s2_write>),           //                             .write
		.onchip_memory2_1_s2_readdata        (<connected-to-onchip_memory2_1_s2_readdata>),        //                             .readdata
		.onchip_memory2_1_s2_writedata       (<connected-to-onchip_memory2_1_s2_writedata>),       //                             .writedata
		.switches_external_connection_export (<connected-to-switches_external_connection_export>)  // switches_external_connection.export
	);

