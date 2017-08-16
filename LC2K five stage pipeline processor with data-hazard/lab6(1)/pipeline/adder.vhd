--32 bit adder-----------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity adder is
port(A : in std_logic_vector (31 downto 0);
B : in std_logic_vector (31 downto 0);
O : out std_logic_vector (31 downto 0));
end adder;
architecture bhv of adder is
  begin
process(A,B)
begin
O <= A+B;
end process;
end bhv;


