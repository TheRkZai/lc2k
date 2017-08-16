--dest register--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity dest_reg is
  port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector(2 downto 0);
destin : in std_logic_vector (2 downto 0);
enable : in std_logic;
destoutfir: out std_logic_vector (2 downto 0);
destoutsec: out std_logic_vector (2 downto 0);
destoutthi: out std_logic_vector (2 downto 0)
);
end dest_reg;

architecture bhv of dest_reg is
begin
process(clk,rst)
variable temp1:std_logic_vector (2 downto 0);
variable temp2:std_logic_vector (2 downto 0);
variable temp3:std_logic_vector (2 downto 0);
variable temp4:std_logic_vector (2 downto 0);
begin
  if (rst ='1') then
    destoutfir<=temp1;
    destoutsec<=temp2;
    destoutthi<=temp3;
  else
    if(clk'event and clk ='1') then
		 if(enable = '0') then 
          if(opcode = "011") then 
             temp3:=temp2;
             temp2:=temp1;
             temp1:=temp4;
             destoutfir<=temp1;
             destoutsec<=temp2;
             destoutthi<=temp3;
          else
             temp3:=temp2;
             temp2:=temp1;
             temp1:=destin;
             destoutfir<=temp1;
             destoutsec<=temp2;
             destoutthi<=temp3;
          end if;
		 else
		       temp3:=temp2;
             temp2:=temp1;
             temp1:=temp4;
             destoutfir<=temp1;
             destoutsec<=temp2;
             destoutthi<=temp3;  
        end if;
    end if;
end if;
end process;
end bhv;

