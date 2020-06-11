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
		video_adress		:	OUT	STD_LOGIC_VECTOR(11 DOWNTO 0);
		redIN				:	IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
		blueIN				:	IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
		greenIN				:	IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
		v_cont				:	IN	STD_LOGIC_VECTOR(15 DOWNTO 0);
		h_cont				:	IN	STD_LOGIC_VECTOR(15 DOWNTO 0);
		pixelsr				:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		pixelsg				:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		pixelsb				:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		pixelselect				:	IN	STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END VGA;

ARCHITECTURE behavior OF VGA IS
	CONSTANT h_pixels	:	INTEGER := 96 + 48 + 640 + 16;
	CONSTANT	v_pixels	:	INTEGER := 2 + 33 + 480 + 10;
BEGIN
	
	PROCESS(clock)
		VARIABLE h_count	:	INTEGER RANGE 0 TO h_pixels - 1 := 0;
		VARIABLE v_count	:	INTEGER RANGE 0 TO v_pixels - 1 := 0;
	BEGIN
		IF(clock'EVENT AND clock = '1') THEN
			h_count := to_integer(unsigned(h_cont));
			v_count := to_integer(unsigned(v_cont));
			red <= redIN;
			blue <= blueIN;
			green <= greenIN;
			
			IF(h_count > 159 AND h_count < 159+200 AND v_count > 100 AND v_count < 100+10) THEN
				--change pixel read adress
				video_adress <= STD_LOGIC_VECTOR(TO_UNSIGNED((h_count-160)+200*(v_count-101), video_adress'length));
				red <= video_data(7 downto 0);
				blue <= video_data(15 downto 8);	
				green <= video_data(23 downto 16);
				--red <=  "11111111";
				--blue <= "11111111";
				--green <= "11111111";
			END IF;
			
			IF(h_count > 200 AND h_count < 202+255 AND v_count > 150 AND v_count < 152) THEN
				red <=  "11111111";
				blue <= "11111111";
				green <= "11111111";
			END IF;
			
			IF(h_count > 200 AND h_count < 202+to_integer(unsigned(pixelselect)) AND v_count > 150 AND v_count < 152) THEN
				pixelsr <= redIN;
				pixelsg <= blueIN;
				pixelsb <= greenIN;
				--red <= "11111111";
			END IF;
			
		END IF;
	END PROCESS;
END behavior;