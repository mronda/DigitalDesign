-- Max Ronda
-- EEL 4712
-- Section # 1527
-- testbench
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY displayDecoder_tb is

end displayDecoder_tb;

ARCHITECTURE behavior of displayDecoder_tb is

SIGNAL i : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL display_n : STD_LOGIC_VECTOR(6 downto 0);

BEGIN
  UUT : ENTITY work.displayDecoder
  PORT MAP (
            i => i,
            display_n => display_n);
  PROCESS
    variable i_test : STD_LOGIC_VECTOR(3 downto 0);
    FUNCTION test (
      signal i : STD_LOGIC_VECTOR(3 downto 0))
      return STD_LOGIC_VECTOR is

  BEGIN

    if(i = "0000") then
    return "1111110";
    elsif (i = "0001") then
    return "0110000";
    elsif (i = "0010") then
    return "1101101";
    elsif (i = "0011") then
    return "1111001";
    elsif (i = "0100") then
    return "0110011";
    elsif (i = "0101") then
    return "1011011";
    elsif (i = "0110") then
    return "1011111";
    elsif (i = "0111") then
    return "1110000";
    elsif (i = "1000") then
    return "1111111";
    elsif (i = "1001") then
    return "1110011";
    elsif (i = "1010") then
    return "1110111";
    elsif (i = "1011") then
    return "0011111";
    elsif (i = "1100") then
    return "1001110";
    elsif (i = "1101") then
    return "0111101";
    elsif (i = "1110") then
    return "1001111";
    else
    return "1000111";

    end if;

end test;

BEGIN

for j in 0 to 15 loop

  i_test := STD_LOGIC_VECTOR(TO_UNSIGNED(j, 4));

  i <= i_test;

  wait for 40 ns;

  ASSERT(display_n = NOT test(i))
  REPORT "Error: Output out_bits incorrect for in_bits = " & STD_LOGIC'IMAGE (i(3)) & STD_LOGIC'IMAGE (i(2)) & STD_LOGIC'IMAGE (i(1)) & STD_LOGIC'IMAGE (i(0)) SEVERITY WARNING;

END LOOP;

WAIT FOR 500ns;
  REPORT "SIMULATION FINISHED!";
WAIT;
  END PROCESS;
END;
