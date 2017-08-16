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
--284 mutiply 489
mem(0) <= conv_std_logic_vector(8519700,32);
mem(1) <= conv_std_logic_vector(8585237,32);
mem(2) <= conv_std_logic_vector(8650777,32);
mem(3) <= conv_std_logic_vector(8716310,32);
mem(4) <= conv_std_logic_vector(8781851,32);
mem(5) <= conv_std_logic_vector(20185101,32);
mem(6) <= conv_std_logic_vector(8847383,32);
mem(7) <= conv_std_logic_vector(6094854,32);
mem(8) <= conv_std_logic_vector(20840449,32);
mem(9) <= conv_std_logic_vector(655361,32);
mem(10) <= conv_std_logic_vector(29360128,32);
mem(11) <= conv_std_logic_vector(1179650,32);
mem(12) <= conv_std_logic_vector(2949125,32);
mem(13) <= conv_std_logic_vector(8781851,32);
mem(14) <= conv_std_logic_vector(8847382,32);
mem(15) <= conv_std_logic_vector(3604486,32);
mem(16) <= conv_std_logic_vector(12976155,32);
mem(17) <= conv_std_logic_vector(8847386,32);
mem(18) <= conv_std_logic_vector(25034752,32);
mem(19) <= conv_std_logic_vector(25165824,32);
mem(20) <= conv_std_logic_vector(284,32);
mem(21) <= conv_std_logic_vector(489,32);
mem(22) <= conv_std_logic_vector(1,32);
mem(23) <= conv_std_logic_vector(-1,32);
mem(24) <= conv_std_logic_vector(5,32);
mem(25) <= conv_std_logic_vector(15,32);
mem(26) <= conv_std_logic_vector(4,32);
mem(27) <= conv_std_logic_vector(0,32);
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

