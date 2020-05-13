LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY VGAController IS
	GENERIC(
		h_pulse	: INTEGER := 128;
		h_back	: INTEGER := 88;
		h_pixels	: INTEGER := 800;
		h_front	: INTEGER := 40;
		h_pol		: std_logic := '1';
		v_pulse	: INTEGER := 4;
		v_back	: INTEGER := 23;
		v_pixels	: INTEGER := 600;
		v_front	: INTEGER := 1;
		v_pol		: std_logic := '1');
	PORT(
		pixel_clock : IN std_logic;
		reset_n		: IN std_logic;
		h_sync		: OUT std_logic;
		v_sync		: OUT std_logic;
		disp_en		: OUT std_logic;
		column		: OUT INTEGER RANGE 0 TO 10000;
		row			: OUT INTEGER RANGE 0 TO 10000;
		n_blank		: OUT std_logic;
		n_sync		: OUT std_logic);
END VGAController;

ARCHITECTURE Behavior OF VGAController IS
	CONSTANT h_period : INTEGER := h_pulse + h_back + h_pixels + h_front;
	CONSTANT v_period : INTEGER := v_pulse + v_back + v_pixels + v_front;
BEGIN
	n_blank <= '1';
	n_sync <= '0';
	
	PROCESS(pixel_clock)
		VARIABLE h_count : INTEGER RANGE 0 TO h_period - 1 := 0;
		VARIABLE v_count : INTEGER RANGE 0 TO v_period - 1 := 0;
	BEGIN
		IF reset_n = '0' THEN
			h_count := 0;
			v_count := 0;
			h_sync <= not h_pol;
			v_sync <= not v_pol;
			disp_en <= '0';
			column <= 0;
			row <= 0;
		ELSIF pixel_clock'event and pixel_clock = '1' THEN
			
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
			
			IF h_count < h_pixels + h_front or h_count >= h_pixels + h_front + h_pulse THEN
				h_sync <= not h_pol;
			ELSE
				h_sync <= h_pol;
			END IF;
			
			IF v_count < v_pixels + v_front or v_count >= v_pixels + v_front + v_pulse THEN
				v_sync <= not v_pol;
			ELSE
				v_sync <= v_pol;
			END IF;
			
			IF h_count < h_pixels and v_count < v_pixels THEN
				disp_en <= '1';
			ELSE
				disp_en <= '0';
			END IF;
		END IF;
	END PROCESS;
END Behavior;