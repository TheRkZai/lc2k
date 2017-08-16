--4 to 1 mux-------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux4 is
port(rst:in std_logic;
c : in std_logic_vector(31 downto 0);
d : in std_logic_vector(31 downto 0);
e : in std_logic_vector(31 downto 0);
f : in std_logic_vector(31 downto 0);
s : in std_logic_vector(1 downto 0);
muxoutput : out std_logic_vector(31 downto 0));
end mux4;

architecture bhv of mux4 is
begin
process(rst,s,c,d,e,f)
begin
  if(rst = '1') then
  muxoutput <= "00000000000000000000000000000000";
else
case s is
when "00"=> muxoutput <= c;
when "01"=> muxoutput <= d;
when "10"=> muxoutput <= e;
when "11"=> muxoutput <= f;
when others => null;
end case;
end if;
end process;
end bhv;

