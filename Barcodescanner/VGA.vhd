LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY VGA IS
	PORT(
		clock				:	IN		STD_LOGIC;
		video_data	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		red				:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		blue				:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		green				:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		sync		:	OUT	STD_LOGIC;
		blank		:	OUT	STD_LOGIC;
		v_sync	:	OUT	STD_LOGIC;
		h_sync	:	OUT	STD_LOGIC;
		video_adress		:	OUT	STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END VGA;

ARCHITECTURE behavior OF VGA IS
	CONSTANT h_pixels	:	INTEGER := 128 + 88 + 800 + 40;
	CONSTANT	v_pixels	:	INTEGER := 4 + 23 + 600 + 1;
BEGIN
	blank <= '1';
	sync <= '0';
	
	PROCESS(clock)
		VARIABLE h_count	:	INTEGER RANGE 0 TO h_pixels - 1 := 0;
		VARIABLE v_count	:	INTEGER RANGE 0 TO v_pixels - 1 := 0;
		--VARIABLE total_count	:	INTEGER RANGE 0 TO 50 := 0;
	BEGIN
		IF(clock'EVENT AND clock = '1') THEN
			-- counters
			IF(h_count < h_pixels - 1) THEN
				h_count := h_count + 1;
			ELSE
				h_count := 0;
				IF(v_count < v_pixels - 1) THEN
					v_count := v_count + 1;
					--total_count := total_count + 1;
				ELSE
					v_count := 0;
				END IF;
			END IF;
			
			-- horizontal sync
			IF(h_count < 840 OR h_count >= 968) THEN
				h_sync <= '0';
			ELSE
				h_sync <= '1';
			END IF;
			
			-- vertical sync
			IF(v_count < 601 OR v_count >= 605) THEN
				v_sync <= '0';
			ELSE
				v_sync <= '1';
			END IF;
			
			IF(h_count < 800 AND v_count < 600) THEN
				red <= "11111111";
				blue <= "00000000";
				green <= "00000000";
			ELSE
				red <= "00000000";
				blue <= "00000000";
				green <= "00000000";
			END IF;
			
			
			IF(h_count < 200 AND v_count < 10) THEN
				--change pixel read adress
				--video_adress <= STD_LOGIC_VECTOR(TO_UNSIGNED((h_count+5*v_count)+1, video_adress'length));
				video_adress <= STD_LOGIC_VECTOR(TO_UNSIGNED(h_count+200*v_count, video_adress'length));
				red <= video_data(7 downto 0);
				blue <= video_data(15 downto 8);	
				green <= video_data(23 downto 16);
			END IF;
	
			
		END IF;
	END PROCESS;
END behavior;