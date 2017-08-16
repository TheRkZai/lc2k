--sign extension unit----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity sext is
port(rst :in std_logic;
A : in std_logic_vector (15 downto 0);
O : out std_logic_vector (31 downto 0));
end sext;

architecture bhv of sext is
begin
process(A,rst)
begin
  if(rst = '1') then
     O<= "00000000000000000000000000000000";
   else
if (A(15) = '1') then
O <= "1111111111111111" & A;
elsif (A(15) = '0') then
O <= "0000000000000000" & A;
end if;
end if;
end process;
end bhv;

