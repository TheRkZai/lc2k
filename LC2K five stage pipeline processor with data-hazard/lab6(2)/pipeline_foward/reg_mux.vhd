--register mux-----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity muxr is
port(rst : in std_logic;
c : in std_logic_vector(2 downto 0);
d : in std_logic_vector(2 downto 0);
s : in std_logic;
muxoutput : out std_logic_vector(2 downto 0));
end muxr;

architecture bhv of muxr is
begin
process(rst,s,c,d)
begin
  if(rst ='1') then 
  muxoutput <= "000";
else
case s is
when '0'=> muxoutput <= c;
when '1'=> muxoutput <= d;
when others => null;
end case;
end if;
end process;
end bhv;
