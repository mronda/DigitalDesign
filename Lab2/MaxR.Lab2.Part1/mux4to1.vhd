--Max Ronda
--EEL 4712
--Section 1527

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY mux4to1 IS
  port (w0          : in  std_logic;
        w1          : in  std_logic;
        w2          : in  std_logic;
        w3          : in  std_logic;
        s           : in  std_logic_vector(1 DOWNTO 0);
        enable_n    : in  std_logic;
        f_n         : out std_logic);

END mux4to1;

ARCHITECTURE behavior OF mux4to1 IS

SIGNAL enable, f : std_logic;

BEGIN

enable <= NOT enable_n;
f_n <= (NOT f) when enable = '1' else 'Z';

f <= ((enable) AND (NOT s(1)) AND (NOT s(0)) AND (w0)) OR
		((enable) AND (NOT s(1)) AND (s(0)) AND (w1)) OR
		((enable) AND (s(1)) AND (NOT s(0)) AND (w2)) OR
		((enable) AND (s(1)) AND (s(0)) AND (w3));

END behavior ;
