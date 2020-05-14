	barcodescanner_nios u0 (
		.clk_clk                             (<connected-to-clk_clk>),                             //                          clk.clk
		.leds_external_connection_export     (<connected-to-leds_external_connection_export>),     //     leds_external_connection.export
		.switches_external_connection_export (<connected-to-switches_external_connection_export>), // switches_external_connection.export
		.videoram_address                    (<connected-to-videoram_address>),                    //                     videoram.address
		.videoram_chipselect                 (<connected-to-videoram_chipselect>),                 //                             .chipselect
		.videoram_clken                      (<connected-to-videoram_clken>),                      //                             .clken
		.videoram_write                      (<connected-to-videoram_write>),                      //                             .write
		.videoram_readdata                   (<connected-to-videoram_readdata>),                   //                             .readdata
		.videoram_writedata                  (<connected-to-videoram_writedata>),                  //                             .writedata
		.videoram_byteenable                 (<connected-to-videoram_byteenable>)                  //                             .byteenable
	);

