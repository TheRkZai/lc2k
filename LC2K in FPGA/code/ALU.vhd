--LC-2 ALU---------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity LC2_ALU is
port( rst : in std_logic;
A: in std_logic_vector (31 downto 0);
B: in std_logic_vector (31 downto 0);
S: in std_logic; --_vector (1 downto 0);
O: out std_logic_vector (31 downto 0);
EQ: out std_logic);
end LC2_ALU;

architecture bhv of LC2_ALU is
begin
process(A, B, S,rst)
begin
   if(rst ='1') then 
     O<="00000000000000000000000000000000";
     EQ<='0';
   else
case S is
when '0' => O <= A+B;
when '1' => O <= not (A and B);
when others => null;
end case;
if (A=B) then EQ <= '1';
else EQ <= '0';
end if;
end if;
end process;
end bhv;

