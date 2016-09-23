library ieee;
use ieee.std_logic_1164.all;

-- DO NOT CHANGE ANYTHING IN THE ENTITY

entity adder is
  port (
    input1    : in  std_logic_vector(3 downto 0);
    input2    : in  std_logic_vector(3 downto 0);
    carry_in  : in  std_logic;
    sum       : out std_logic_vector(3 downto 0);
    carry_out : out std_logic);
end adder;

-- DEFINE A RIPPLE-CARRY ADDER USING A STRUCTURE DESCRIPTION THAT CONSISTS OF 4
-- FULL ADDERS

architecture STR of adder is
	SIGNAL CARRY_IN1, CARRY_IN2, CARRY_IN3 : STD_LOGIC;
	COMPONENT fa
		port (
				input1    : in  std_logic;
				input2    : in  std_logic;
				carry_in  : in  std_logic;
				sum       : out std_logic;
				carry_out : out std_logic);
end COMPONENT;

begin  -- STR

	stage0: fa PORT MAP(input1(0), input2(0), carry_in, sum(0), CARRY_IN1);
	stage1: fa PORT MAP(input1(1), input2(1), CARRY_IN1, sum(1), CARRY_IN2);
	stage2: fa PORT MAP(input1(2), input2(2), CARRY_IN2, sum(2), CARRY_IN3);
	stage3: fa PORT MAP(input1(3), input2(3), CARRY_IN3, sum(3), carry_out);

end STR;
