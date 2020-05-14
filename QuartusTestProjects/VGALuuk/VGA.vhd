LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY VGA IS
	GENERIC(
		-- Values to determine the resolution
		-- These values are changed within the VGALuuk.bdf file
		---------------------------------------
		h_pulse	: INTEGER 	:= 128;
		h_back	: INTEGER 	:= 88;
		h_pixels	: INTEGER 	:= 800;
		h_front	: INTEGER 	:= 40;
		h_pol		: std_logic	:= '1';
		v_pulse	: INTEGER	:= 4;
		v_back	: INTEGER 	:= 23;
		v_pixels	: INTEGER 	:= 600;
		v_front	: INTEGER 	:= 1;
		v_pol		: std_logic	:= '1'
		---------------------------------------
		
		);
	PORT(
		-- I/O for the VGA
		---------------------------------------
		pixel_clock : IN std_logic;
		reset_n		: IN std_logic;
		h_sync		: OUT std_logic;
		v_sync		: OUT std_logic;
		n_blank		: OUT std_logic;
		n_sync		: OUT std_logic;
		red			: OUT std_logic_vector(7 DOWNTO 0);
		green			: OUT std_logic_vector(7 DOWNTO 0);
		blue			: OUT std_logic_vector(7 DOWNTO 0)
		---------------------------------------
		
		);
END VGA;

ARCHITECTURE Behavior OF VGA IS
	CONSTANT h_period : INTEGER := h_pulse + h_back + h_pixels + h_front;
	CONSTANT v_period : INTEGER := v_pulse + v_back + v_pixels + v_front;
	SIGNAL	disp_en	: std_logic := '1';
BEGIN
	-- Standard values (don't change them!)
	n_blank <= '1';
	n_sync <= '0';
	
	-- VGA controller
	controller:PROCESS(pixel_clock)
		VARIABLE h_count : INTEGER RANGE 0 TO h_period - 1 := 0;
		VARIABLE v_count : INTEGER RANGE 0 TO v_period - 1 := 0;
	BEGIN
		-- Resets all values
		IF reset_n = '0' THEN
			h_count := 0;
			v_count := 0;
			h_sync <= not h_pol;
			v_sync <= not v_pol;
			disp_en <= '0';
			
		-- For everytime there is a clock event and the clock is HIGH
		ELSIF pixel_clock'event and pixel_clock = '1' THEN
		
			-- counters
			IF h_count < h_period - 1 THEN
				h_count := h_count + 1;
			ELSE
				h_count := 0;
				IF v_count < v_period - 1 THEN
					v_count := v_count + 1;
				ELSE
					v_count := 0;
				END IF;
			END IF;
			
			-- Sets the horizontal sync
			IF h_count < h_pixels + h_front or h_count >= h_pixels + h_front + h_pulse THEN
				h_sync <= not h_pol;
			ELSE
				h_sync <= h_pol;
			END IF;
			
			-- Sets the vertical sync
			IF v_count < v_pixels + v_front or v_count >= v_pixels + v_front + v_pulse THEN
				v_sync <= not v_pol;
			ELSE
				v_sync <= v_pol;
			END IF;
			
			-- enables and disables the display
			IF h_count < h_pixels and v_count < v_pixels THEN
				disp_en <= '1';
			ELSE
				disp_en <= '0';
			END IF;
		END IF;
	END PROCESS;
	
	-- VGA Output process
	output:PROCESS(disp_en)
	BEGIN
		IF disp_en = '1' THEN
			red <= "00000000";
			green <= "00000000";
			blue <= "11111111";
		ELSE
			red <= "00000000";
			green <= "00000000";
			blue <= "00000000";
		END IF;
	END PROCESS;
	
END Behavior;