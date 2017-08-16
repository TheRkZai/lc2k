--Test bench--------------------------------------------------

library ieee;
use ieee.std_logic_arith.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...
entity pipeline_all_tb is
end pipeline_all_tb;

architecture TB_ARCHITECTURE of pipeline_all_tb is
-- Component declaration of the tested unit
component pipeline_all
port(
rst : in std_logic;
clk : in std_logic );
end component;

-- Stimulus signals - signals mapped to the input and inout ports of tested
signal rst : std_logic:='1';
signal clk : std_logic;
-- Observed signals - signals mapped to the output ports of tested entity
begin
-- Unit Under Test port map 
process
begin
clk<='0';
wait for 1 ns;
clk<='1';
wait for 1 ns;
end process; 

process
begin
rst <= '0' after 1 ns;
wait;
end process;

UUT : pipeline_all port map(rst,clk);
end TB_ARCHITECTURE;



