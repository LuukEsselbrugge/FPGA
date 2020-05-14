	component barcodescanner_nios is
		port (
			clk_clk                             : in  std_logic                     := 'X';             -- clk
			leds_external_connection_export     : out std_logic_vector(7 downto 0);                     -- export
			switches_external_connection_export : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			videoram_address                    : in  std_logic_vector(11 downto 0) := (others => 'X'); -- address
			videoram_chipselect                 : in  std_logic                     := 'X';             -- chipselect
			videoram_clken                      : in  std_logic                     := 'X';             -- clken
			videoram_write                      : in  std_logic                     := 'X';             -- write
			videoram_readdata                   : out std_logic_vector(31 downto 0);                    -- readdata
			videoram_writedata                  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			videoram_byteenable                 : in  std_logic_vector(3 downto 0)  := (others => 'X')  -- byteenable
		);
	end component barcodescanner_nios;

	u0 : component barcodescanner_nios
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                          clk.clk
			leds_external_connection_export     => CONNECTED_TO_leds_external_connection_export,     --     leds_external_connection.export
			switches_external_connection_export => CONNECTED_TO_switches_external_connection_export, -- switches_external_connection.export
			videoram_address                    => CONNECTED_TO_videoram_address,                    --                     videoram.address
			videoram_chipselect                 => CONNECTED_TO_videoram_chipselect,                 --                             .chipselect
			videoram_clken                      => CONNECTED_TO_videoram_clken,                      --                             .clken
			videoram_write                      => CONNECTED_TO_videoram_write,                      --                             .write
			videoram_readdata                   => CONNECTED_TO_videoram_readdata,                   --                             .readdata
			videoram_writedata                  => CONNECTED_TO_videoram_writedata,                  --                             .writedata
			videoram_byteenable                 => CONNECTED_TO_videoram_byteenable                  --                             .byteenable
		);

