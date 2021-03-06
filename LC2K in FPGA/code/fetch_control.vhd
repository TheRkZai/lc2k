library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity fetch_control is
port(
rst: in std_logic;
clk: in std_logic;
loadhazard:in std_logic;
pcen : out std_logic;
memenable: out std_logic;
muxsel : out std_logic;
regen : out std_logic
);
end fetch_control;
architecture bhv of fetch_control is
begin
   process(clk,loadhazard)
     begin
       if(rst = '1') then 
          pcen<='1';
          memenable<='1';
          muxsel<='1';
          regen<='1';
        else
           if(loadhazard ='1') then
             pcen<='0';
             memenable<='0';
             muxsel<='1';
             regen<='0';
          else
             pcen<='1';
             memenable<='1';
             muxsel<='1';
             regen<='1';
           end if;
    end if;
end process;
end bhv;
