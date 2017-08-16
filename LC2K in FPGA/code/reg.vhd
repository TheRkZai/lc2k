--32 bit register--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity reg is
  port(rst: in std_logic;
    clk: in std_logic;
enable : in std_logic;
data : in std_logic_vector (31 downto 0);
O : out std_logic_vector (31 downto 0));
end reg;

architecture bhv of reg is
begin
process(clk,rst)
variable temp:std_logic_vector (31 downto 0):="00000000000000000000000000000000";
begin
  if (rst ='1') then
      O<="00000000000000000000000000000000";
  else
      if(clk'event and clk='1') then
		   if(enable = '1') then 
         O<=data;
         temp:=data;
         else
          O<=temp;
         end if;
		end if;
  end if;
end process;
end bhv;
