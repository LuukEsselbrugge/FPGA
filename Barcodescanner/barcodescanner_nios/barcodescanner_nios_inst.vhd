	component barcodescanner_nios is
		port (
			clk_clk                             : in  std_logic                     := 'X';             -- clk
			leds_external_connection_export     : out std_logic_vector(7 downto 0);                     -- export
			onchip_memory2_1_s2_address         : in  std_logic_vector(11 downto 0) := (others => 'X'); -- address
			onchip_memory2_1_s2_chipselect      : in  std_logic                     := 'X';             -- chipselect
			onchip_memory2_1_s2_clken           : in  std_logic                     := 'X';             -- clken
			onchip_memory2_1_s2_write           : in  std_logic                     := 'X';             -- write
			onchip_memory2_1_s2_readdata        : out std_logic_vector(7 downto 0);                     -- readdata
			onchip_memory2_1_s2_writedata       : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- writedata
			switches_external_connection_export : in  std_logic_vector(7 downto 0)  := (others => 'X')  -- export
		);
	end component barcodescanner_nios;

	u0 : component barcodescanner_nios
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                          clk.clk
			leds_external_connection_export     => CONNECTED_TO_leds_external_connection_export,     --     leds_external_connection.export
			onchip_memory2_1_s2_address         => CONNECTED_TO_onchip_memory2_1_s2_address,         --          onchip_memory2_1_s2.address
			onchip_memory2_1_s2_chipselect      => CONNECTED_TO_onchip_memory2_1_s2_chipselect,      --                             .chipselect
			onchip_memory2_1_s2_clken           => CONNECTED_TO_onchip_memory2_1_s2_clken,           --                             .clken
			onchip_memory2_1_s2_write           => CONNECTED_TO_onchip_memory2_1_s2_write,           --                             .write
			onchip_memory2_1_s2_readdata        => CONNECTED_TO_onchip_memory2_1_s2_readdata,        --                             .readdata
			onchip_memory2_1_s2_writedata       => CONNECTED_TO_onchip_memory2_1_s2_writedata,       --                             .writedata
			switches_external_connection_export => CONNECTED_TO_switches_external_connection_export  -- switches_external_connection.export
		);

