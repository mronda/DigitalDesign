-- Max Ronda
-- Section #1527 EEL4712
-- Addder 8 Mumeric 

 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;


entity adder8numeric is
port(input1, input2 : in std_logic_vector(7 downto 0);
         carry_in  : in std_logic;
         sum : out std_logic_vector(7 downto 0);
         carry_out  : out std_logic);
   end adder8numeric;

architecture behavior of adder8numeric is

SIGNAL tempSum : UNSIGNED(8 downto 0);

function bitToUnsigned (in_bit: std_logic)
return unsigned is
begin
  if in_bit='1' then
  return to_unsigned(1,9);
  else
  return to_unsigned(0,9);
end if;

end;

BEGIN

tempSum <= unsigned('0'&input1) + unsigned('0'&input2) + bitToUnsigned(carry_in); -- Conca

sum <= std_logic_vector(tempSum(7 downto 0));

carry_out <= tempSum(8);

end behavior;
