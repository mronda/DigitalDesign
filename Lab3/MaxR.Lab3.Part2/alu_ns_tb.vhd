-- Max Ronda
-- Section #1527 EEL4712
-- ALU - Lab3 Part 2 TESt bench

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu_ns_tb is
end alu_ns_tb;

architecture TB of alu_ns_tb is

  component alu_ns

    generic (
      WIDTH    :     positive := 16
      );
    port (
      input1   : in  std_logic_vector(WIDTH-1 downto 0);
      input2   : in  std_logic_vector(WIDTH-1 downto 0);
      sel      : in  std_logic_vector(3 downto 0);
      output   : out std_logic_vector(WIDTH-1 downto 0);
      overflow : out std_logic
      );

  end component;

  constant WIDTH    : positive                           := 8;
  signal   input1   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
  signal   input2   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
  signal   sel      : std_logic_vector(3 downto 0)       := (others => '0');
  signal   output   : std_logic_vector(WIDTH-1 downto 0);
  signal   overflow : std_logic;

begin  -- TB

  UUT : alu_ns
    generic map (WIDTH => WIDTH)
    port map (
      input1           => input1,
      input2           => input2,
      sel              => sel,
      output           => output,
      overflow         => overflow);

  process
  begin

    -- test 2+6 (no overflow)
    sel    <= "0101";
    input1 <= conv_std_logic_vector(2, input1'length);
    input2 <= conv_std_logic_vector(6, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(8, output'length)) report "Error : 2+6 = " & integer'image(conv_integer(output)) & " instead of 8" severity warning;
    assert(overflow = '0') report "Error                                   : overflow incorrect for 2+8" severity warning;

    -- test 250+50 (with overflow)
    sel    <= "0101";
    input1 <= conv_std_logic_vector(250, input1'length);
    input2 <= conv_std_logic_vector(50, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(300, output'length)) report "Error : 250+50 = " & integer'image(conv_integer(output)) & " instead of 44" severity warning;
    assert(overflow = '1') report "Error                                     : overflow incorrect for 250+50" severity warning;

    -- test 5*6
    sel    <= "0111";
    input1 <= conv_std_logic_vector(5, input1'length);
    input2 <= conv_std_logic_vector(6, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(30, output'length)) report "Error : 5*6 = " & integer'image(conv_integer(output)) & " instead of 30" severity warning;
    assert(overflow = '0') report "Error                                    : overflow incorrect for 5*6" severity warning;

    -- test 50*60
    sel    <= "0111";
    input1 <= conv_std_logic_vector(64, input1'length);
    input2 <= conv_std_logic_vector(64, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(4096, output'length)) report "Error : 64*64 = " & integer'image(conv_integer(output)) & " instead of 0" severity warning;
    assert(overflow = '1') report "Error                                      : overflow incorrect for 64*64" severity warning;


    -- add many more tests
    -- NOT of 100 is 155
    sel     <= "0000"; -- NOT operation on input1
    input1  <= conv_std_logic_vector(100, input1'length);
    input2  <= conv_std_logic_vector(155, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(155, output'length)) report "Error: NOT 100 = "& integer'image(conv_integer(output)) &"instead of " severity warning;
    assert(overflow = '0') report "Error  : overflow incorrect for NOT " severity warning;

    -- NOT of 50 is 205
    sel     <= "0000"; -- NOT operation on input1
    input1  <= conv_std_logic_vector(50, input1'length);
    input2  <= conv_std_logic_vector(100, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(205, output'length)) report "Error: NOT 205 = "& integer'image(conv_integer(output)) & "instead of " severity warning;
    assert(overflow = '0') report "Error  : overflow incorrect for NOT " severity warning;

    -- NOR operation: input1 nor input2
    -- 5 nor 11 = 240
    sel <= "0001";
    input1 <= conv_std_logic_vector(5, input1'length);
    input2  <= conv_std_logic_vector(11, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(240, output'length)) report "Error: 5 NOR 11 = "& integer'image(conv_integer(output)) & "instead of 240" severity warning;
    assert(overflow = '0') report "Error  :   overflow incorrect for 5 NOR 11" severity warning;

    -- NOR OPERATION: 20 nor 45
    sel <= "0001";
    input1 <= conv_std_logic_vector(20, input1'length);
    input2  <= conv_std_logic_vector(45, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(194, output'length)) report "Error: 20 NOR 45 = "& integer'image(conv_integer(output)) & "instead of 194" severity warning;
    assert(overflow = '0') report "Error  :   overflow incorrect for 20 NOR 45" severity warning;

    -- XOR OPERATION: input1 XOR input2
    -- OPERATION: 20 XOR 45 = 196
    sel <= "0010";
    input1 <= conv_std_logic_vector(20, input1'length);
    input2 <= conv_std_logic_vector(45, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(57, output'length)) report "Error: 20 XOR 45 = "& integer'image(conv_integer(output)) &" instead of 57" severity warning;
    assert(overflow = '0') report "Error   : overflow incorrect for xor operation" severity warning;

    -- XOR OPERATION: 30 XOR 20
    -- input1 XOR input2
    sel <= "0010";
    input1 <= conv_std_logic_vector(30, input1'length);
    input2 <= conv_std_logic_vector(20, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(10, output'length)) report "Error: 30 XOR 20 = "& integer'image(conv_integer(output)) &" instead of 10" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect for xor operation" severity warning;

    -- OR OPERATION: 5 or 6 = 7
    -- input1 OR input2
    sel <= "0011";
    input1 <= conv_std_logic_vector(5, input1'length);
    input2 <= conv_std_logic_vector(6, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(7, output'length)) report "Error: 5 OR 6 = "& integer'image(conv_integer(output)) &" instead of 7" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect for 5 OR 6 = 7" severity warning;

    -- AND OPERATION: 5 and 6 = 4
    -- input1 AND input2
    sel <= "0100";
    input1 <= conv_std_logic_vector(5, input1'length);
    input2 <= conv_std_logic_vector(6, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(4, output'length)) report "Error: 5 AND 6 = "& integer'image(conv_integer(output)) &" instead of 5" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect for 5 AND 6 = 4" severity warning;

    -- AND OPERATION: 5 and 10 = 0
    -- input1 AND input2
    sel <= "0100";
    input1 <= conv_std_logic_vector(5, input1'length);
    input2 <= conv_std_logic_vector(10, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(0, output'length)) report "Error: 5 AND 10 = "& integer'image(conv_integer(output)) &" instead of 0" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect for 5 AND 10 = 0" severity warning;

    -- SUBTRACTION OPERATION: 5 - 3
    -- input1 - input2
    sel <= "0110";
    input1 <= conv_std_logic_vector(5, input1'length);
    input2 <= conv_std_logic_vector(3, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(2, output'length)) report "Error: 5 - 3 = "& integer'image(conv_integer(output)) &" instead of 2" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect 5-3 = 3" severity warning;

    -- SUBTRACTION OPERATION: 10 - 5
    -- input1 - input2
    sel <= "0110";
    input1 <= conv_std_logic_vector(10, input1'length);
    input2 <= conv_std_logic_vector(5, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(5, output'length)) report "Error: 10 - 5 = "& integer'image(conv_integer(output)) &" instead of 5" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect 10-5 = 5" severity warning;

    -- NO OPERATION:
    --OUTPUT == 0 && overflow  == 0
    sel <= "1000";
    input1 <= conv_std_logic_vector(10, input1'length);
    input2 <= conv_std_logic_vector(1, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(0, output'length)) report "Output is 0 (operation not assigned) = "& integer'image(conv_integer(output)) &" instead of 0" severity warning;
    assert(overflow = '0') report "Error                                  : overflow = 0 (operation not assigned)" severity warning;

    -- NO OPERATION:
    --OUTPUT == 0 && OVERFLOW == 0
    sel <= "1001";
    input1 <= conv_std_logic_vector(10, input1'length);
    input2 <= conv_std_logic_vector(1, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(0, output'length)) report "Output is 0 (operation not assigned) = "& integer'image(conv_integer(output)) &" instead of 0" severity warning;
    assert(overflow = '0') report "Error                                  : overflow = 0 (operation not assigned)" severity warning;

    -- OPERATION: shift input1 left by one bit
    -- shifting 100 left one bit is 200
    sel <= "1010";
    input1 <= conv_std_logic_vector(100, input1'length);
    input2 <= conv_std_logic_vector(0, input2'length); -- nothing occurs here
    wait for 40 ns;
    assert(output = conv_std_logic_vector(200, output'length)) report "100 shifted left 1 bit = "& integer'image(conv_integer(output)) &" instead of 200" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect shifting left 100 by 1 bit" severity warning;

    -- SHIFT LEFT 1 BIT OPERATION: shift input1 left by one bit
    -- shifting 200 left one bit is
    sel <= "1010";
    input1 <= conv_std_logic_vector(200, input1'length);
    input2 <= conv_std_logic_vector(0, input2'length); -- nothing occurs here
    wait for 40 ns;
    assert(output = conv_std_logic_vector(144, output'length)) report "200 shifted left 1 bit = "& integer'image(conv_integer(output)) &" instead of 144" severity warning;
    assert(overflow = '1') report "Error                                  : overflow incorrect shifting left 200 by 1 bit" severity warning;

    -- SHIFT RIGHT 1 bit OPERATION: input1 shift right
    -- Shifting 100 right 1 bit == 50
    sel <= "1011"; -- shift input1 right 1 bit
    input1 <= conv_std_logic_vector(100, input1'length);
    input2 <= conv_std_logic_vector(0, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(50, output'length)) report "100 shifted right by 1 bit = "& integer'image(conv_integer(output)) &" instead of 50" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect shifting right 100 by 1 bit" severity warning;

    -- SHIFT RIGHT 1 bit OPERATION: input1 shift right
    -- Shifting 50 right 1 bit == 25
    sel <= "1011"; -- shift input1 right 1 bit
    input1 <= conv_std_logic_vector(50, input1'length);
    input2 <= conv_std_logic_vector(0, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(25, output'length)) report "50 shifted right by 1 bit = "& integer'image(conv_integer(output)) &" instead of 25" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect shifting right 50 by 1 bit" severity warning;

    -- REVERSE OPERATION: Reverse input1 and write to output
    -- REVESE 5 = 160
    sel <= "1100";
    input1 <= conv_std_logic_vector(5, input1'length);
    input2 <= conv_std_logic_vector(0, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(160, output'length)) report "5 REversed  = "& integer'image(conv_integer(output)) &" instead of 160" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect for reversing 5" severity warning;

    -- REVERSE OPERATION: Reverse input1 and write to output
    -- REVESE 10 = 80
    sel <= "1100";
    input1 <= conv_std_logic_vector(10, input1'length);
    input2 <= conv_std_logic_vector(0, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(80, output'length)) report "10 REversed  = "& integer'image(conv_integer(output)) &" instead of 80" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect for reversing 10" severity warning;

    -- SWAP OPERATION: Swaping hightbit of input1 with lowbit of input1
    -- SWAP: 10 == 160
    sel <= "1101";
    input1 <= conv_std_logic_vector(10, input1'length);
    input2 <= conv_std_logic_vector(0, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(160, output'length)) report "10 swapped  = "& integer'image(conv_integer(output)) &" instead of 160" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect for swap" severity warning;

    -- SWAP OPERATION: Swaping hightbit of input1 with lowbit of input1
    -- SWAP: 5 == 80 --- 00000101 == 01010000
    sel <= "1101";
    input1 <= conv_std_logic_vector(5, input1'length);
    input2 <= conv_std_logic_vector(0, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(80, output'length)) report "5 swapped  = "& integer'image(conv_integer(output)) &" instead of 80" severity warning;
    assert(overflow = '0') report "Error                                  : overflow incorrect for swap" severity warning;

    -- NO OPERATION:
    --OUTPUT == 0 && overflow  == 0
    sel <= "1110";
    input1 <= conv_std_logic_vector(10, input1'length);
    input2 <= conv_std_logic_vector(1, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(0, output'length)) report "Output is 0 (operation not assigned) = "& integer'image(conv_integer(output)) &" instead of 0" severity warning;
    assert(overflow = '0') report "Error                                  : overflow = 0 (operation not assigned)" severity warning;

    -- NO OPERATION:
    --OUTPUT == 0 && overflow  == 0
    sel <= "1111";
    input1 <= conv_std_logic_vector(10, input1'length);
    input2 <= conv_std_logic_vector(1, input2'length);
    wait for 40 ns;
    assert(output = conv_std_logic_vector(0, output'length)) report "Output is 0 (operation not assigned) = "& integer'image(conv_integer(output)) &" instead of 0" severity warning;
    assert(overflow = '0') report "Error                                  : overflow = 0 (operation not assigned)" severity warning;

    wait;

  end process;



end TB;
