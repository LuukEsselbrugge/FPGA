module NIOS(
	// Clock
	input         CLOCK_50,
	
	// KEY
	input  [0: 0] KEY,
	
	// Ethernet 0
	//output        ENET0_MDC,
	//inout         ENET0_MDIO,
	//output        ENET0_RESET_N,
	
	// Ethernet 1
	output        ENET1_GTX_CLK,
	output        ENET1_MDC,
	inout         ENET1_MDIO,
	output        ENET1_RESET_N,
	input         ENET1_RX_CLK,
	input  [3: 0] ENET1_RX_DATA,
	input         ENET1_RX_DV,
	output [3: 0] ENET1_TX_DATA,
	output        ENET1_TX_EN,
	
	input [11:0] videoram_adrr,
	output [31:0] videoram_data
);

	wire sys_clk, clk_125, clk_25, clk_2p5, tx_clk;
	wire core_reset_n;
	wire mdc, mdio_in, mdio_oen, mdio_out;
	wire eth_mode, ena_10;

	assign mdio_in   = ENET1_MDIO;
	//assign ENET0_MDC  = mdc;
	assign ENET1_MDC  = mdc;
	//assign ENET0_MDIO = mdio_oen ? 1'bz : mdio_out;
	assign ENET1_MDIO = mdio_oen ? 1'bz : mdio_out;
	
	//assign ENET0_RESET_N = core_reset_n;
	assign ENET1_RESET_N = core_reset_n;
	
	my_pll pll_inst(
		.areset	(~KEY[0]),
		.inclk0	(CLOCK_50),
		.c0		(sys_clk),
		.c1		(clk_125),
		.c2		(clk_25),
		.c3		(clk_2p5),
		.locked	(core_reset_n)
	); 
	
	assign tx_clk = eth_mode ? clk_125 :       // GbE Mode   = 125MHz clock
	                ena_10   ? clk_2p5 :       // 10Mb Mode  = 2.5MHz clock
	                           clk_25;         // 100Mb Mode = 25 MHz clock
	
	my_ddio_out ddio_out_inst(
		.datain_h(1'b1),
		.datain_l(1'b0),
		.outclock(tx_clk),
		.dataout(ENET1_GTX_CLK)
	);

	
    barcodescanner_nios system_inst(
        .clk_clk                                   (sys_clk),           //                                   clk.clk
        .reset_reset_n                             (core_reset_n),      //                                 reset.reset_n
        .eth_tse_pcs_mac_tx_clock_connection_clk 		(tx_clk), 				// eth_tse_0_pcs_mac_tx_clock_connection.clk
        .eth_tse_pcs_mac_rx_clock_connection_clk 		(ENET1_RX_CLK), 		// eth_tse_0_pcs_mac_rx_clock_connection.clk
        .eth_tse_mac_mdio_connection_mdc               (mdc),             	//               tse_mac_mdio_connection.mdc
        .eth_tse_mac_mdio_connection_mdio_in           (mdio_in),           //                                      .mdio_in
        .eth_tse_mac_mdio_connection_mdio_out          (mdio_out),          //                                      .mdio_out
        .eth_tse_mac_mdio_connection_mdio_oen          (mdio_oen),          //                                      .mdio_oen
        .eth_tse_mac_rgmii_connection_rgmii_in         (ENET1_RX_DATA),     //              tse_mac_rgmii_connection.rgmii_in
        .eth_tse_mac_rgmii_connection_rgmii_out        (ENET1_TX_DATA),     //                                      .rgmii_out
        .eth_tse_mac_rgmii_connection_rx_control       (ENET1_RX_DV),       //                                      .rx_control
        .eth_tse_mac_rgmii_connection_tx_control       (ENET1_TX_EN),       //                                      .tx_control

        .eth_tse_mac_status_connection_eth_mode        (eth_mode),        	//                                      .eth_mode
        .eth_tse_mac_status_connection_ena_10          (ena_10),          	//                                      .ena_10	  
		  
		  .videoram_address	(videoram_adrr),
		  .videoram_readdata	(videoram_data),
		  .videoram_chipselect(1'b1),
		  .videoram_clken(1'b1),
		  .videoram_write(1'b0)
    );	

endmodule 