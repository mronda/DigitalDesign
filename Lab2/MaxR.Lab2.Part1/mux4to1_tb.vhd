-- Test bench for mux4to1
-- Max Ronda
-- EEL4712
-- Section 1527

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY mux4to1_tb is

END mux4to1_tb;

ARCHITECTURE behavior of mux4to1_tb is

  SIGNAL w0, w1, w2, w3, enable_n, f_n : STD_LOGIC;

  SIGNAL s : STD_LOGIC_VECTOR(1 downto 0);

BEGIN

  UUT : ENTITY work.mux4to1
  PORT MAP(
  w0 => w0,
  w1 => w1,
  w2 => w2,
  w3 => w3,
  s  => s,
  enable_n => enable_n,
  f_n => f_n
  );

  STIM_PROC: PROCESS

  VARIABLE value : STD_LOGIC_VECTOR (5 downto 0);
  VARIABLE e_n : STD_LOGIC;

  FUNCTION mux4to1_test (
      SIGNAL w0, w1, w2, w3, enable, f : STD_LOGIC;
      SIGNAL s : std_logic_vector(1 downto 0)
      )

      RETURN STD_LOGIC is

  BEGIN

    IF(enable = '1') then
      return 'Z';

    elsif(s = "00") then
      return NOT w0;

    elsif(s = "01") then
      return NOT w1;

    elsif(s = "10") then
      return NOT w2;

    else
      return NOT w3;

    END IF;

    END mux4to1_test;

    BEGIN

      FOR i in 0 to 63 LOOP
      FOR x in 0 to 1 LOOP

      value := STD_LOGIC_VECTOR(TO_UNSIGNED(i,6));
      e_n := STD_LOGIC(TO_UNSIGNED(x,1)(0));

      s(1)     <= value(5); --inputs
      s(0)     <= value(4);
      w0       <= value(3);
      w1       <= value(2);
      w2       <= value(1);
      w3       <= value(0);
      enable_n <= e_n;

      WAIT FOR 50 ns;

      ASSERT(f_n = mux4to1_test (w0, w1, w2, w3, enable_n, f_n, s))

        REPORT "Error : output f incorrect for s1,s0 = " & STD_LOGIC'IMAGE (value(5)) & STD_LOGIC'IMAGE (value(4)) & "and w = " & STD_LOGIC'IMAGE (value(3)) & STD_LOGIC'IMAGE (value(2)) & STD_LOGIC'IMAGE (value(1)) & STD_LOGIC'IMAGE (value(0)) SEVERITY WARNING;

      END LOOP;
      END LOOP;

      WAIT FOR 500ns;
      REPORT "SIMULATION FINISHED!";
      WAIT;

  END PROCESS;

  END;
