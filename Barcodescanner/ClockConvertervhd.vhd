LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ClockConverter IS
	PORT(
		toConvert		:	IN STD_LOGIC;
		convertedClock	:	OUT STD_LOGIC);
END ClockConverter;

ARCHITECTURE converter OF ClockConverter IS
--	CONSTANT convertNumber	: INTEGER := 50000000/40000000;
BEGIN
	PROCESS(toConvert)		
--		VARIABLE i	:	INTEGER RANGE 0 TO convertNumber := 0;
	BEGIN
		--IF(toConvert'EVENT) THEN
		
		
	END PROCESS;
END converter;