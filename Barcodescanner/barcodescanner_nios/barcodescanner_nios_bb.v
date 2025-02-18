
module barcodescanner_nios (
	clk_clk,
	eth_tse_mac_mdio_connection_mdc,
	eth_tse_mac_mdio_connection_mdio_in,
	eth_tse_mac_mdio_connection_mdio_out,
	eth_tse_mac_mdio_connection_mdio_oen,
	eth_tse_mac_rgmii_connection_rgmii_in,
	eth_tse_mac_rgmii_connection_rgmii_out,
	eth_tse_mac_rgmii_connection_rx_control,
	eth_tse_mac_rgmii_connection_tx_control,
	eth_tse_mac_status_connection_set_10,
	eth_tse_mac_status_connection_set_1000,
	eth_tse_mac_status_connection_eth_mode,
	eth_tse_mac_status_connection_ena_10,
	eth_tse_pcs_mac_rx_clock_connection_clk,
	eth_tse_pcs_mac_tx_clock_connection_clk,
	pixelr_export,
	pixelselect_export,
	reset_reset_n,
	switches_export,
	videoram_address,
	videoram_chipselect,
	videoram_clken,
	videoram_write,
	videoram_readdata,
	videoram_writedata,
	videoram_byteenable,
	pixelg_export,
	pixelb_export);	

	input		clk_clk;
	output		eth_tse_mac_mdio_connection_mdc;
	input		eth_tse_mac_mdio_connection_mdio_in;
	output		eth_tse_mac_mdio_connection_mdio_out;
	output		eth_tse_mac_mdio_connection_mdio_oen;
	input	[3:0]	eth_tse_mac_rgmii_connection_rgmii_in;
	output	[3:0]	eth_tse_mac_rgmii_connection_rgmii_out;
	input		eth_tse_mac_rgmii_connection_rx_control;
	output		eth_tse_mac_rgmii_connection_tx_control;
	input		eth_tse_mac_status_connection_set_10;
	input		eth_tse_mac_status_connection_set_1000;
	output		eth_tse_mac_status_connection_eth_mode;
	output		eth_tse_mac_status_connection_ena_10;
	input		eth_tse_pcs_mac_rx_clock_connection_clk;
	input		eth_tse_pcs_mac_tx_clock_connection_clk;
	input	[7:0]	pixelr_export;
	output	[7:0]	pixelselect_export;
	input		reset_reset_n;
	input	[7:0]	switches_export;
	input	[11:0]	videoram_address;
	input		videoram_chipselect;
	input		videoram_clken;
	input		videoram_write;
	output	[31:0]	videoram_readdata;
	input	[31:0]	videoram_writedata;
	input	[3:0]	videoram_byteenable;
	input	[7:0]	pixelg_export;
	input	[7:0]	pixelb_export;
endmodule
