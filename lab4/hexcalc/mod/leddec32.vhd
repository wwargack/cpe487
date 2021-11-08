LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY leddec32 IS
	PORT (
		dig : IN STD_LOGIC_VECTOR (2 DOWNTO 0); -- which digit to currently display
		data : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- 32-bit (8-digit) data
		anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); -- which anode to turn on
		seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)); -- segment code for current digit
END leddec32;

ARCHITECTURE Behavioral OF leddec32 IS
	SIGNAL data8 : STD_LOGIC_VECTOR (3 DOWNTO 0); -- binary value of current digit
BEGIN
	-- Select digit data to be displayed in this mpx period
	data8 <= data(3 DOWNTO 0) WHEN dig = "000" ELSE -- digit 0
	         data(7 DOWNTO 4) WHEN dig = "001" ELSE -- digit 1
	         data(11 DOWNTO 8) WHEN dig = "010" ELSE -- digit 2
	         data(15 DOWNTO 12) WHEN dig = "011" ELSE -- digit 3
	         data(19 DOWNTO 16) WHEN dig = "100" ELSE -- digit 4
	         data(23 DOWNTO 20) WHEN dig = "101" ELSE -- digit 5
	         data(27 DOWNTO 24) WHEN dig = "110" ELSE -- digit 6
	         data(31 DOWNTO 28) WHEN dig = "111"; -- digit 7
	         
	-- Turn on segments corresponding to 4-bit data word
	seg <= "0000001" WHEN data8 = "0000" ELSE -- 0
	       "1001111" WHEN data8 = "0001" ELSE -- 1
	       "0010010" WHEN data8 = "0010" ELSE -- 2
	       "0000110" WHEN data8 = "0011" ELSE -- 3
	       "1001100" WHEN data8 = "0100" ELSE -- 4
	       "0100100" WHEN data8 = "0101" ELSE -- 5
	       "0100000" WHEN data8 = "0110" ELSE -- 6
	       "0001111" WHEN data8 = "0111" ELSE -- 7
	       "0000000" WHEN data8 = "1000" ELSE -- 8
	       "0000100" WHEN data8 = "1001" ELSE -- 9
	       "0001000" WHEN data8 = "1010" ELSE -- A
	       "1100000" WHEN data8 = "1011" ELSE -- B
	       "0110001" WHEN data8 = "1100" ELSE -- C
	       "1000010" WHEN data8 = "1101" ELSE -- D
	       "0110000" WHEN data8 = "1110" ELSE -- E
	       "0111000" WHEN data8 = "1111" ELSE -- F
	       "1111111";
	-- Turn on anode of 7-segment display addressed by 3-bit digit selector dig. Suppress leading 0s.
	anode <= "11111110" WHEN dig = "000" and data /= X"00000000" ELSE -- 0
	         "11111101" WHEN dig = "001" and data (31 DOWNTO 4) /= X"0000000" ELSE -- 1
	         "11111011" WHEN dig = "010" and data (31 DOWNTO 8) /= X"000000" ELSE -- 2
	         "11110111" WHEN dig = "011" and data (31 DOWNTO 12) /= X"00000" ELSE -- 3
	         "11101111" WHEN dig = "100" and data (31 DOWNTO 16) /= X"0000" ELSE -- 4
	         "11011111" WHEN dig = "101" and data (31 DOWNTO 20) /= X"000" ELSE -- 5 
	         "10111111" WHEN dig = "110" and data (31 DOWNTO 24) /= X"00" ELSE -- 6
	         "01111111" WHEN dig = "111" and data (31 DOWNTO 28) /= X"0" ELSE -- 7
	         "11111111";
END Behavioral;
