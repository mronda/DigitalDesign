-- Max Ronda
-- EEL4712
-- Lab2Part3

library ieee;
use ieee.std_logic_1164.all;

entity eightAdder is
port (
  input1    : in std_logic_vector(7 downto 0);
  input2    : in std_logic_vector(7 downto 0);
  carry_in  : in std_logic;
  sum       : out std_logic_vector(7 downto 0);
  carry_out     : out std_logic);

end eightAdder;

architecture behavior of eightAdder is
  SIGNAL CARRY_IN1: STD_LOGIC;

  COMPONENT adder
    port (
    input1    : in  std_logic_vector(3 downto 0);
    input2    : in  std_logic_vector(3 downto 0);
    carry_in  : in  std_logic;
    sum       : out std_logic_vector(3 downto 0);
    carry_out : out std_logic);

  end COMPONENT;

  begin

    stage0: adder PORT MAP(input1(3 downto 0), input2(3 downto 0), carry_in, sum(3 downto 0), CARRY_IN1);
    stage1: adder PORT MAP(input1(7 downto 4), input2(7 downto 4), CARRY_IN1, sum(7 downto 4), carry_out);

END behavior;
