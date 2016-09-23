-- Max Ronda
-- EEL4712
-- Lab2Part4

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY adder_w_decoders is

  PORT (
      input1    : in std_logic_vector(7 downto 0);
      input2    : in std_logic_vector(7 downto 0);
      carry_in  : in std_logic;
      sum       : out std_logic_vector(7 downto 0);
      carry_out_n : out std_logic;
      display_top : out std_logic_vector(6 downto 0);
      display_bottom  : out std_logic_vector(6 downto 0));

  end adder_w_decoders;

-- NEED: ONE INSTANCE OF 8BIT ADDER AND 2 INSTANCE OF displayDecoder

  architecture behavior of adder_w_decoders is

    signal sum_internal : std_logic_vector(7 downto 0);
	 signal carry_out	: std_logic;

	COMPONENT eightAdder

      PORT (
      input1      : in std_logic_vector(7 downto 0);
      input2      : in std_logic_vector(7 downto 0);
      carry_in    : in std_logic;
      sum         : out std_logic_vector(7 downto 0);
      carry   : out std_logic);

      end COMPONENT;

    COMPONENT displayDecoder
      PORT (
      i           : in std_logic_vector(3 downto 0);
      display_n   : out std_logic_vector(6 downto 0));

    end COMPONENT;

    BEGIN

    stage0: eightAdder PORT MAP(input1, input2, carry_in, sum_internal, carry_out);
    stage1: displayDecoder PORT MAP(sum_internal(3 downto 0), display_bottom);
    stage2: displayDecoder PORT MAP(sum_internal(7 downto 4), display_top);

	 sum  <= sum_internal;
	 carry_out_n <= NOT carry_out;

  end behavior;
