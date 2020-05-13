LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY VGAOut IS
	PORT(
		disp_en		: IN std_logic;
		column		: IN INTEGER RANGE 0 TO 10000;
		row			: IN INTEGER RANGE 0 TO 10000;
		redIn			: IN std_logic_vector(7 DOWNTO 0);
		greenIn		: IN std_logic_vector(7 DOWNTO 0);
		blueIn		: IN std_logic_vector(7 DOWNTO 0);
		red			: OUT std_logic_vector(7 DOWNTO 0);
		green			: OUT std_logic_vector(7 DOWNTO 0);
		blue			: OUT std_logic_vector(7 DOWNTO 0));
END VGAOut;

ARCHITECTURE Behavior OF VGAOut IS
BEGIN
	PROCESS(disp_en, column, row)
	BEGIN
		IF disp_en = '1' THEN
			red <= redIn;
			green <= greenIn;
			blue <= blueIn;
		ELSE
			red <= "00000000";
			green <= "00000000";
			blue <= "00000000";
		END IF;
	END PROCESS;
END Behavior;