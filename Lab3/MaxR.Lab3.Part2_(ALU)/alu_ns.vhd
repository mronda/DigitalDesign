-- Max Ronda
-- Section #1527 EEL4712
-- ALU - Lab3 Part 2

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;

entity alu_ns is

  generic (
      width : positive := 16
      );

  port (
        input1 : in std_logic_vector(width-1 downto 0);
        input2 : in std_logic_vector(width-1 downto 0);
        sel    : in std_logic_vector(3 downto 0);
        output : out std_logic_vector(width-1 downto 0);
        overflow : out std_logic);

end alu_ns;

architecture behavior of alu_ns is

begin

process(input1, input2, sel)
variable tempOutput: unsigned(width-1 downto 0);
variable tempOutputSum : unsigned(width downto 0);
variable tempOutputMult : unsigned(((width*2) -1) downto 0);
variable tempShift : unsigned(width-1 downto 0);
variable highBits : std_logic_vector(width/2-1 downto 0);
variable lowBits : std_logic_vector(width/2-1 downto 0);

begin

  case sel is

    when "0000" =>
      output <= NOT (input1); --this might be a temp variable
      overflow <= '0';

    when "0001" =>
      output <= (input1 nor input2);
		  overflow <= '0';

    when "0010" =>
      output <= (input1 xor input2);
	    overflow <= '0';

    when "0011" =>
      output <= (input1 or input2);
		  overflow <= '0';

    when "0100" =>
      output <= (input1 and input2);
		  overflow <= '0';

    when "0101" => -- sum
      tempOutputSum := (unsigned('0'&input1) + unsigned('0'&input2)); -- concatate with a 0 bit to get the same length of the vector
      --if(tempOutput > to_unsigned(2**width-1, width)) then
       -- overflow <= '1';
      --else overflow <= '0';
    --end if;
	    overflow <= tempOutputSum(width); -- overflow gets the last bit of the sum, which is the overflow
      output <= std_logic_vector(tempOutputSum(width-1 downto 0)); -- output is the  sum

    when "0110" => -- sub
      tempOutput := (unsigned(input1) - unsigned(input2));
      output <= std_logic_vector(tempOutput);
      overflow <= '0';

    when "0111" => -- mult
      tempOutputMult := (unsigned(input1) * unsigned(input2)); -- casting the inputs to unsigned size of (width*2) - 1
      if(tempOutputMult > to_unsigned(2**width-1, width*2)) then -- checking if greater than maximum number that can be written to output
        overflow <= '1';
      else overflow <= '0';
		  end if;
      output <= std_logic_vector(tempOutputMult(width-1 downto 0)); -- truncating to size of width/2 -1 and casting to std_logic_vector

    when "1000" => -- NO operation
      output <= std_logic_vector(to_unsigned(0,width));
      overflow <= '0';

    when "1001" => -- NO operation
      output <= std_logic_vector(to_unsigned(0,width));
      overflow <= '0';

    when "1010" => -- shift input1 left by 1 bit
      tempShift := shift_left(unsigned(input1), 1);
      output <= std_logic_vector(tempShift);
      overflow <= input1(7); -- Return original high bit

    when "1011" => -- Shift Input1 right by 1 bit
      tempShift := shift_right(unsigned(input1), 1);
      output <= std_logic_vector(tempShift);
      overflow <= input1(0); -- Return original low bit

    when "1100" => -- Reverse bits in input1
	   for i in 0 to width-1 loop -- Loop from 0 - 7 for example
        tempShift((width-1) - i ) := input1(i); -- temp variable gets input from right side to left side one by one
	    end loop;
	     output <= std_logic_vector(tempShift);
       overflow <= '0';

    when "1101" => -- Swap high-half bits of input1 with with low-half bits of input1
      highBits := input1(width-1 downto width/2); -- set variable to get highBits
      lowBits := input1(width/2 -1 downto 0); -- set variable to get lowbits
      output <= lowBits & highBits; -- concatenate the two
      overflow <= '0';

    when "1110" => -- NO OPERATION
      output <= std_logic_vector(to_unsigned(0,width));
      overflow <= '0';

    when others => -- NO operation
      output <= std_logic_vector(to_unsigned(0,width));
      overflow <= '0';

end case;
end process;
end behavior;
