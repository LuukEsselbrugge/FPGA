	component barcodescanner_nios is
		port (
			clk_clk                                 : in  std_logic                     := 'X';             -- clk
			eth_tse_mac_mdio_connection_mdc         : out std_logic;                                        -- mdc
			eth_tse_mac_mdio_connection_mdio_in     : in  std_logic                     := 'X';             -- mdio_in
			eth_tse_mac_mdio_connection_mdio_out    : out std_logic;                                        -- mdio_out
			eth_tse_mac_mdio_connection_mdio_oen    : out std_logic;                                        -- mdio_oen
			eth_tse_mac_rgmii_connection_rgmii_in   : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- rgmii_in
			eth_tse_mac_rgmii_connection_rgmii_out  : out std_logic_vector(3 downto 0);                     -- rgmii_out
			eth_tse_mac_rgmii_connection_rx_control : in  std_logic                     := 'X';             -- rx_control
			eth_tse_mac_rgmii_connection_tx_control : out std_logic;                                        -- tx_control
			eth_tse_mac_status_connection_set_10    : in  std_logic                     := 'X';             -- set_10
			eth_tse_mac_status_connection_set_1000  : in  std_logic                     := 'X';             -- set_1000
			eth_tse_mac_status_connection_eth_mode  : out std_logic;                                        -- eth_mode
			eth_tse_mac_status_connection_ena_10    : out std_logic;                                        -- ena_10
			eth_tse_pcs_mac_rx_clock_connection_clk : in  std_logic                     := 'X';             -- clk
			eth_tse_pcs_mac_tx_clock_connection_clk : in  std_logic                     := 'X';             -- clk
			pixelr_export                           : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			pixelselect_export                      : out std_logic_vector(7 downto 0);                     -- export
			reset_reset_n                           : in  std_logic                     := 'X';             -- reset_n
			switches_export                         : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			videoram_address                        : in  std_logic_vector(11 downto 0) := (others => 'X'); -- address
			videoram_chipselect                     : in  std_logic                     := 'X';             -- chipselect
			videoram_clken                          : in  std_logic                     := 'X';             -- clken
			videoram_write                          : in  std_logic                     := 'X';             -- write
			videoram_readdata                       : out std_logic_vector(31 downto 0);                    -- readdata
			videoram_writedata                      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			videoram_byteenable                     : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			pixelg_export                           : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			pixelb_export                           : in  std_logic_vector(7 downto 0)  := (others => 'X')  -- export
		);
	end component barcodescanner_nios;

	u0 : component barcodescanner_nios
		port map (
			clk_clk                                 => CONNECTED_TO_clk_clk,                                 --                                 clk.clk
			eth_tse_mac_mdio_connection_mdc         => CONNECTED_TO_eth_tse_mac_mdio_connection_mdc,         --         eth_tse_mac_mdio_connection.mdc
			eth_tse_mac_mdio_connection_mdio_in     => CONNECTED_TO_eth_tse_mac_mdio_connection_mdio_in,     --                                    .mdio_in
			eth_tse_mac_mdio_connection_mdio_out    => CONNECTED_TO_eth_tse_mac_mdio_connection_mdio_out,    --                                    .mdio_out
			eth_tse_mac_mdio_connection_mdio_oen    => CONNECTED_TO_eth_tse_mac_mdio_connection_mdio_oen,    --                                    .mdio_oen
			eth_tse_mac_rgmii_connection_rgmii_in   => CONNECTED_TO_eth_tse_mac_rgmii_connection_rgmii_in,   --        eth_tse_mac_rgmii_connection.rgmii_in
			eth_tse_mac_rgmii_connection_rgmii_out  => CONNECTED_TO_eth_tse_mac_rgmii_connection_rgmii_out,  --                                    .rgmii_out
			eth_tse_mac_rgmii_connection_rx_control => CONNECTED_TO_eth_tse_mac_rgmii_connection_rx_control, --                                    .rx_control
			eth_tse_mac_rgmii_connection_tx_control => CONNECTED_TO_eth_tse_mac_rgmii_connection_tx_control, --                                    .tx_control
			eth_tse_mac_status_connection_set_10    => CONNECTED_TO_eth_tse_mac_status_connection_set_10,    --       eth_tse_mac_status_connection.set_10
			eth_tse_mac_status_connection_set_1000  => CONNECTED_TO_eth_tse_mac_status_connection_set_1000,  --                                    .set_1000
			eth_tse_mac_status_connection_eth_mode  => CONNECTED_TO_eth_tse_mac_status_connection_eth_mode,  --                                    .eth_mode
			eth_tse_mac_status_connection_ena_10    => CONNECTED_TO_eth_tse_mac_status_connection_ena_10,    --                                    .ena_10
			eth_tse_pcs_mac_rx_clock_connection_clk => CONNECTED_TO_eth_tse_pcs_mac_rx_clock_connection_clk, -- eth_tse_pcs_mac_rx_clock_connection.clk
			eth_tse_pcs_mac_tx_clock_connection_clk => CONNECTED_TO_eth_tse_pcs_mac_tx_clock_connection_clk, -- eth_tse_pcs_mac_tx_clock_connection.clk
			pixelr_export                           => CONNECTED_TO_pixelr_export,                           --                              pixelr.export
			pixelselect_export                      => CONNECTED_TO_pixelselect_export,                      --                         pixelselect.export
			reset_reset_n                           => CONNECTED_TO_reset_reset_n,                           --                               reset.reset_n
			switches_export                         => CONNECTED_TO_switches_export,                         --                            switches.export
			videoram_address                        => CONNECTED_TO_videoram_address,                        --                            videoram.address
			videoram_chipselect                     => CONNECTED_TO_videoram_chipselect,                     --                                    .chipselect
			videoram_clken                          => CONNECTED_TO_videoram_clken,                          --                                    .clken
			videoram_write                          => CONNECTED_TO_videoram_write,                          --                                    .write
			videoram_readdata                       => CONNECTED_TO_videoram_readdata,                       --                                    .readdata
			videoram_writedata                      => CONNECTED_TO_videoram_writedata,                      --                                    .writedata
			videoram_byteenable                     => CONNECTED_TO_videoram_byteenable,                     --                                    .byteenable
			pixelg_export                           => CONNECTED_TO_pixelg_export,                           --                              pixelg.export
			pixelb_export                           => CONNECTED_TO_pixelb_export                            --                              pixelb.export
		);

