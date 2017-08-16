library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity fetch_control is
port(
rst: in std_logic;
clk: in std_logic;
pcen : out std_logic;
memenable: out std_logic;
muxsel : out std_logic
);
end fetch_control;
architecture bhv of fetch_control is
begin
   process(clk)
     begin
       if(rst = '1') then 
          pcen<='1';
          memenable<='1';
          muxsel<='1';
        else
             pcen<='1';
             memenable<='1';
             muxsel<='1';
       end if;
end process;
end bhv;