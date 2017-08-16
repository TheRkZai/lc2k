--module module-------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity data_mem is
port(rst :in std_logic;
clk: in std_logic;
enable : in std_logic;
R_W : in std_logic;
addr : in std_logic_vector (31 downto 0);
data_in : in std_logic_vector (31 downto 0);
data_out : out std_logic_vector (31 downto 0);
inenable : in std_logic;
inaddr : in std_logic_vector (31 downto 0);
indata_out : out std_logic_vector (31 downto 0));
end data_mem;

architecture bhv of data_mem is
type memory is array (0 to 65536) of std_logic_vector(31 downto 0);
signal mem: memory;

begin
process(rst,data_in,enable,inenable,inaddr,clk)
variable temp:std_logic_vector (31 downto 0):="00000000000000000000000000000000";
  begin
    if (rst ='1') then 
mem(0) <= conv_std_logic_vector(8519700,32);
mem(1) <= conv_std_logic_vector(8585237,32);
mem(2) <= conv_std_logic_vector(1245185,32);
mem(3) <= conv_std_logic_vector(589825,32);
mem(4) <= conv_std_logic_vector(8650777,32);
mem(5) <= conv_std_logic_vector(2359300,32);
mem(6) <= conv_std_logic_vector(10223635,32);
mem(7) <= conv_std_logic_vector(2293764,32);
mem(8) <= conv_std_logic_vector(8716310,32);
mem(9) <= conv_std_logic_vector(2949125,32);
mem(10) <= conv_std_logic_vector(1376262,32);
mem(11) <= conv_std_logic_vector(7667716,32);
mem(12) <= conv_std_logic_vector(3538950,32);
mem(13) <= conv_std_logic_vector(12976155,32);
mem(14) <= conv_std_logic_vector(3538950,32);
mem(15) <= conv_std_logic_vector(12976156,32);
mem(16) <= conv_std_logic_vector(3538950,32);
mem(17) <= conv_std_logic_vector(16121885,32);
mem(18) <= conv_std_logic_vector(8847389,32);
mem(19) <= conv_std_logic_vector(25165824,32);
mem(20) <= conv_std_logic_vector(11,32);
mem(21) <= conv_std_logic_vector(7,32);
mem(22) <= conv_std_logic_vector(1,32);
mem(23) <= conv_std_logic_vector(-1,32);
mem(24) <= conv_std_logic_vector(5,32);
mem(25) <= conv_std_logic_vector(15,32);
mem(26) <= conv_std_logic_vector(10,32);
mem(27) <= conv_std_logic_vector(0,32);
mem(28) <= conv_std_logic_vector(0,32);
mem(29) <= conv_std_logic_vector(0,32);
data_out<=conv_std_logic_vector(0,32);
    else
           if(R_W='0' and enable ='1' and clk'event and clk ='0') then
               data_out<=mem(conv_integer(addr));
           elsif (R_W ='1' and enable  ='1' and clk'event and clk ='1') then
               mem(conv_integer(addr))<=data_in;
             end if;
          if(inenable='1' and clk'event and clk ='1') then
               indata_out<=mem(conv_integer(inaddr));
               temp:=mem(conv_integer(inaddr));
          elsif(inenable='0' and clk'event and clk ='1') then
               indata_out<=temp;
          end if;
   end if;
end process;
end bhv;

