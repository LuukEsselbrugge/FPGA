	component ctest_nios is
		port (
			clk_clk                             : in  std_logic                    := 'X';             -- clk
			leds_external_connection_export     : out std_logic_vector(7 downto 0);                    -- export
			switches_external_connection_export : in  std_logic_vector(7 downto 0) := (others => 'X')  -- export
		);
	end component ctest_nios;

	u0 : component ctest_nios
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                          clk.clk
			leds_external_connection_export     => CONNECTED_TO_leds_external_connection_export,     --     leds_external_connection.export
			switches_external_connection_export => CONNECTED_TO_switches_external_connection_export  -- switches_external_connection.export
		);

