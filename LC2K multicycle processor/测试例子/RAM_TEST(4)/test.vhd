--random module-------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ram_module is
port(rst :in std_logic;
clk : in std_logic;
enable : in std_logic;
R_W : in std_logic;
addr : in std_logic_vector (31 downto 0);
data_in : in std_logic_vector (31 downto 0);
data_out : out std_logic_vector (31 downto 0));
end ram_module;

architecture bhv of ram_module is
type memory is array (0 to 65536) of std_logic_vector(31 downto 0);
signal mem: memory;
begin
process(rst,clk,R_W,addr,enable)
  begin
    if (rst ='1') then 
mem(0) <= conv_std_logic_vector(8454155,32);
mem(1) <= conv_std_logic_vector(8519692,32);
mem(2) <= conv_std_logic_vector(8585227,32);
mem(3) <= conv_std_logic_vector(8650765,32);
mem(4) <= conv_std_logic_vector(8716299,32);
mem(5) <= conv_std_logic_vector(17432580,32);
mem(6) <= conv_std_logic_vector(786433,32);
mem(7) <= conv_std_logic_vector(1835011,32);
mem(8) <= conv_std_logic_vector(22347776,32);
mem(9) <= conv_std_logic_vector(29360128,32);
mem(10) <= conv_std_logic_vector(25165824,32);
mem(11) <= conv_std_logic_vector(0,32);
mem(12) <= conv_std_logic_vector(5,32);
mem(13) <= conv_std_logic_vector(1,32);
data_out <=conv_std_logic_vector(0,32);
else
if(clk'event and clk='1') then
if(enable='1') then
if(R_W='0') then
data_out<=mem(conv_integer(addr));
else
mem(conv_integer(addr))<=data_in;
end if;
end if;
end if;
end if;
end process;
end bhv;





