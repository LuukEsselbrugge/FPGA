LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CLOCK IS
	GENERIC(
			seconds		: INTEGER := 2);
	
	PORT(	
			clockIN		: IN		STD_LOGIC;
			clockOUT		: OUT		STD_LOGIC);
END CLOCK;

ARCHITECTURE ClockFunction OF CLOCK IS
BEGIN
	PROCESS(clockIN)
		VARIABLE clockSecs : INTEGER := 50000000 * seconds;
		VARIABLE i	:	INTEGER RANGE 0 TO clockSecs := 0;
	BEGIN
		IF(clockIN = '1') THEN
			i := i + 1;
		END IF;
		
		IF(i > (clockSecs/2)) THEN
			clockOUT <= '1';
		ELSE
			clockOUT <= '0';
		END IF;
		
		IF(i = clockSecs) THEN
			i := 0;
		END IF;
	END PROCESS;
END ClockFunction;