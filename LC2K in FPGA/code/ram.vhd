library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity data_mem is
port(rst :in std_logic;
clk: in std_logic;
enable : in std_logic;
R_W : in std_logic;
addr : in std_logic_vector (3 downto 0);
data_in : in std_logic_vector (31 downto 0);
data_out : out std_logic_vector (31 downto 0);
inenable : in std_logic;
inaddr : in std_logic_vector (31 downto 0);
indata_out : out std_logic_vector (31 downto 0));
end data_mem;

architecture bhv of data_mem is
type memory is array (0 to 15) of std_logic_vector(31 downto 0);
signal mem: memory;

begin
process(rst,data_in,enable,inenable,inaddr,clk)
variable temp:std_logic_vector (31 downto 0):="00000000000000000000000000000000";
  begin
    if (rst ='1') then 
mem(0) <= conv_std_logic_vector(8519687,32);
mem(1) <= conv_std_logic_vector(8585224,32);
mem(2) <= conv_std_logic_vector(1245185,32);
mem(3) <= conv_std_logic_vector(589825,32);
mem(4) <= conv_std_logic_vector(4784132,32);
mem(5) <= conv_std_logic_vector(8716297,32);
mem(6) <= conv_std_logic_vector(25165824,32);
mem(7) <= conv_std_logic_vector(18,32);
mem(8) <= conv_std_logic_vector(7,32);
mem(9) <= conv_std_logic_vector(0,32);
mem(10) <= conv_std_logic_vector(0,32);
mem(11) <= conv_std_logic_vector(0,32);
mem(12) <= conv_std_logic_vector(0,32);
mem(13) <= conv_std_logic_vector(0,32);
mem(14) <= conv_std_logic_vector(0,32);
mem(15) <= conv_std_logic_vector(0,32);
data_out <=conv_std_logic_vector(0,32);
indata_out <=conv_std_logic_vector(0,32);
    else
           if(clk'event and clk ='0') then
			      if(R_W='0' and enable ='1' ) then
               data_out<=mem(conv_integer(addr));
					end if;
				end if;
				
           if (clk'event and clk ='1') then
			      if(R_W ='1' and enable  ='1') then
               mem(conv_integer(addr))<=data_in;
             end if;
			  end if;
			 
          if(clk'event and clk ='1') then
			      if(inenable='1' ) then
               indata_out<=mem(conv_integer(inaddr));
               temp:=mem(conv_integer(inaddr));
					else
					indata_out<=temp;
               end if;
			 end if;
   end if;
end process;
end bhv;