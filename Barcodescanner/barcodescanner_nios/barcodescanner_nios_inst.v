	barcodescanner_nios u0 (
		.clk_clk                                 (<connected-to-clk_clk>),                                 //                                 clk.clk
		.eth_tse_mac_mdio_connection_mdc         (<connected-to-eth_tse_mac_mdio_connection_mdc>),         //         eth_tse_mac_mdio_connection.mdc
		.eth_tse_mac_mdio_connection_mdio_in     (<connected-to-eth_tse_mac_mdio_connection_mdio_in>),     //                                    .mdio_in
		.eth_tse_mac_mdio_connection_mdio_out    (<connected-to-eth_tse_mac_mdio_connection_mdio_out>),    //                                    .mdio_out
		.eth_tse_mac_mdio_connection_mdio_oen    (<connected-to-eth_tse_mac_mdio_connection_mdio_oen>),    //                                    .mdio_oen
		.eth_tse_mac_rgmii_connection_rgmii_in   (<connected-to-eth_tse_mac_rgmii_connection_rgmii_in>),   //        eth_tse_mac_rgmii_connection.rgmii_in
		.eth_tse_mac_rgmii_connection_rgmii_out  (<connected-to-eth_tse_mac_rgmii_connection_rgmii_out>),  //                                    .rgmii_out
		.eth_tse_mac_rgmii_connection_rx_control (<connected-to-eth_tse_mac_rgmii_connection_rx_control>), //                                    .rx_control
		.eth_tse_mac_rgmii_connection_tx_control (<connected-to-eth_tse_mac_rgmii_connection_tx_control>), //                                    .tx_control
		.eth_tse_mac_status_connection_set_10    (<connected-to-eth_tse_mac_status_connection_set_10>),    //       eth_tse_mac_status_connection.set_10
		.eth_tse_mac_status_connection_set_1000  (<connected-to-eth_tse_mac_status_connection_set_1000>),  //                                    .set_1000
		.eth_tse_mac_status_connection_eth_mode  (<connected-to-eth_tse_mac_status_connection_eth_mode>),  //                                    .eth_mode
		.eth_tse_mac_status_connection_ena_10    (<connected-to-eth_tse_mac_status_connection_ena_10>),    //                                    .ena_10
		.eth_tse_pcs_mac_rx_clock_connection_clk (<connected-to-eth_tse_pcs_mac_rx_clock_connection_clk>), // eth_tse_pcs_mac_rx_clock_connection.clk
		.eth_tse_pcs_mac_tx_clock_connection_clk (<connected-to-eth_tse_pcs_mac_tx_clock_connection_clk>), // eth_tse_pcs_mac_tx_clock_connection.clk
		.pixelr_export                           (<connected-to-pixelr_export>),                           //                              pixelr.export
		.pixelselect_export                      (<connected-to-pixelselect_export>),                      //                         pixelselect.export
		.reset_reset_n                           (<connected-to-reset_reset_n>),                           //                               reset.reset_n
		.switches_export                         (<connected-to-switches_export>),                         //                            switches.export
		.videoram_address                        (<connected-to-videoram_address>),                        //                            videoram.address
		.videoram_chipselect                     (<connected-to-videoram_chipselect>),                     //                                    .chipselect
		.videoram_clken                          (<connected-to-videoram_clken>),                          //                                    .clken
		.videoram_write                          (<connected-to-videoram_write>),                          //                                    .write
		.videoram_readdata                       (<connected-to-videoram_readdata>),                       //                                    .readdata
		.videoram_writedata                      (<connected-to-videoram_writedata>),                      //                                    .writedata
		.videoram_byteenable                     (<connected-to-videoram_byteenable>),                     //                                    .byteenable
		.pixelg_export                           (<connected-to-pixelg_export>),                           //                              pixelg.export
		.pixelb_export                           (<connected-to-pixelb_export>)                            //                              pixelb.export
	);

