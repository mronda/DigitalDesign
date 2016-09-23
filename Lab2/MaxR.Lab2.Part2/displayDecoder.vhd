-- Max Ronda
-- EEL 4712
-- Section # 1527

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY displayDecoder IS
  PORT (
        i         : in std_logic_vector(3 downto 0);
        display_n   : out std_logic_vector(6 downto 0));

end displayDecoder;

architecture behavior of displayDecoder is
  signal display : std_logic_vector(6 downto 0);

BEGIN

  display_n <= NOT display;

  -- display active low because the board sees it as active low
PROCESS(i)

VARIABLE display_temp : std_logic_vector(6 downto 0);

BEGIN

IF (i = "0000") then
  display_temp := "1111110";  -- 0

elsif(i = "0001") then
  display_temp := "0110000";  -- 1

elsif(i = "0010") then
  display_temp := "1101101";  -- 2

elsif(i = "0011") then
  display_temp := "1111001";  -- 3

elsif(i = "0011") then
  display_temp := "1111001";  -- 3

elsif(i = "0100") then
  display_temp := "0110011";  -- 4

elsif(i = "0101") then
  display_temp := "1011011";  -- 5

elsif(i = "0110") then
  display_temp := "1011111";  -- 6

elsif(i = "0111") then
  display_temp := "1110000";  -- 7

elsif(i = "1000") then
  display_temp := "1111111"; -- 8

elsif(i = "1001") then
  display_temp := "1110011";  -- 9

elsif(i = "1010") then
  display_temp := "1110111";  -- A

elsif(i = "1011") then
  display_temp := "0011111";  -- B

elsif(i = "1100") then
  display_temp := "1001110";  -- C forro

elsif(i = "1101") then
  display_temp := "0111101";  -- D

elsif(i = "1110") then
  display_temp := "1001111";  -- E

elsif(i = "1111") then
  display_temp := "1000111";  -- F

else
  display_temp := "1111111";

end if ;

display <= display_temp;

end PROCESS;

end behavior;
