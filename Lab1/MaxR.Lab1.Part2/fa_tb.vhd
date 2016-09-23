-- test bench for fa 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;n

entity fa_tb is
end fa_tb;

architecture TB of fa_tb is

  signal input1, input2, sum : std_logic;
  signal carry_in, carry_out : std_logic;

begin  -- TB

   UUT : entity work.fa
    port map (
      input1    => input1,
      input2    => input2,
      carry_in  => carry_in,
      sum       => sum,
      carry_out => carry_out);

   process
   begin
	   carry_in <= '0'; wait for 5 ns;
      carry_in <= '1'; wait for 5 ns;
   end process;

   process
   begin

  
   input1 <= '0';
   input2 <= '1';
		wait for 40 ns;
		   
		assert(sum = '0') report "Error in Sum";
		assert(carry_out = '1') report "Error in carry out";
		
	
    report "SIMULATION FINISHED!";
    
    wait;

  end process;

end TB;