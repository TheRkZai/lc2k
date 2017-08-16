
--2 to 1 mux-------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2 is
port(rst: in std_logic;
c : in std_logic_vector(31 downto 0);
d : in std_logic_vector(31 downto 0);
s : in std_logic;
muxoutput : out std_logic_vector(31 downto 0));
end mux2;

architecture bhv of mux2 is
begin
process(rst,s,c,d)
begin
  if(rst ='1') then 
  muxoutput <= "00000000000000000000000000000000";
else
case s is
when '0'=> muxoutput <= c;
when '1'=> muxoutput <= d;
when others => null;
end case;
end if;
end process;
end bhv;
