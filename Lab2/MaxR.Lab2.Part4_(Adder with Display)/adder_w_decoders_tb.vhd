-- Max Ronda
-- EEL4712
-- Lab2Part4
-- Test bench for adder with decoder

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity adder_w_decoders_tb is
end adder_w_decoders_tb;

architecture TB of adder_w_decoders_tb is

  signal input1, input2, sum : STD_LOGIC_VECTOR(7 downto 0);
  signal carry_in, carry_out : std_logic;
  signal display_top, display_bottom : STD_LOGIC_VECTOR(6 downto 0);

begin

  UUT : entity work.adder_w_decoders

    PORT MAP(
     input1 => input1,
     input2 => input2,
     carry_in => carry_in,
     display_top => display_top,
     display_bottom => display_bottom,
     carry_out_n => carry_out,
     sum => sum);

     process
     function sum_test (
     constant in1      : integer;
     constant in2      : integer;
     constant carry_in : integer)
      return std_logic_vector is
       begin
         return std_logic_vector(to_unsigned((in1+in2+carry_in) mod 256, 8));
       end sum_test;


           function carry_test (
             constant in1      : integer;
             constant in2      : integer;
             constant carry_in : integer)
             return std_logic is
           begin
             if (in1+in2+carry_in > 255) then
               return '1';
             else
               return '0';
             end if;
           end carry_test;

           FUNCTION decoder_test (
             SIGNAL i : STD_LOGIC_VECTOR(3 DOWNTO 0))
             RETURN STD_LOGIC_VECTOR IS
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

end decoder_test;

begin
  -- test all input combinations
  for i in 0 to 255 loop
    for j in 0 to 255 loop
      for k in 0 to 1 loop

        input1   <= std_logic_vector(to_unsigned(i, 8));
        input2   <= std_logic_vector(to_unsigned(j, 8));
        carry_in <= std_logic(to_unsigned(k, 1)(0));
        wait for 40 ns;

      end loop;  -- k
    end loop;  -- j
  end loop;  -- i

  report "SIMULATION FINISHED!";

  wait;

end process;

end TB;
