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
--test for combination ( 7, 3) 
mem(0) <= conv_std_logic_vector(8454180,32);
mem(1) <= conv_std_logic_vector(8519717,32);
mem(2) <= conv_std_logic_vector(8781859,32);
mem(3) <= conv_std_logic_vector(24576000,32);
mem(4) <= conv_std_logic_vector(25165824,32);
mem(5) <= conv_std_logic_vector(17432600,32);
mem(6) <= conv_std_logic_vector(16908311,32);
mem(7) <= conv_std_logic_vector(15663142,32);
mem(8) <= conv_std_logic_vector(8781857,32);
mem(9) <= conv_std_logic_vector(3014661,32);
mem(10) <= conv_std_logic_vector(15269926,32);
mem(11) <= conv_std_logic_vector(3014661,32);
mem(12) <= conv_std_logic_vector(15335462,32);
mem(13) <= conv_std_logic_vector(3014661,32);
mem(14) <= conv_std_logic_vector(8781858,32);
mem(15) <= conv_std_logic_vector(917505,32);
mem(16) <= conv_std_logic_vector(8781859,32);
mem(17) <= conv_std_logic_vector(24576000,32);
mem(18) <= conv_std_logic_vector(8781858,32);
mem(19) <= conv_std_logic_vector(1441794,32);
mem(20) <= conv_std_logic_vector(8781859,32);
mem(21) <= conv_std_logic_vector(24576000,32);
mem(22) <= conv_std_logic_vector(8781858,32);
mem(23) <= conv_std_logic_vector(3014661,32);
mem(24) <= conv_std_logic_vector(11141158,32);
mem(25) <= conv_std_logic_vector(3014661,32);
mem(26) <= conv_std_logic_vector(11075622,32);
mem(27) <= conv_std_logic_vector(3014661,32);
mem(28) <= conv_std_logic_vector(11468838,32);
mem(29) <= conv_std_logic_vector(25034752,32);
mem(30) <= conv_std_logic_vector(8781857,32);
mem(31) <= conv_std_logic_vector(1966083,32);
mem(32) <= conv_std_logic_vector(25034752,32);
mem(33) <= conv_std_logic_vector(1,32);
mem(34) <= conv_std_logic_vector(-1,32);
mem(35) <= conv_std_logic_vector(5,32);
mem(36) <= conv_std_logic_vector(7,32);
mem(37) <= conv_std_logic_vector(3,32);
mem(38) <= conv_std_logic_vector(0,32);
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
