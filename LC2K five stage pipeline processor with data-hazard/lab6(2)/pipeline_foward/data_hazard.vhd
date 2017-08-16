--data hazard detect--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity data_hazatd_detect is
port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector(2 downto 0);
thisopcode:in std_logic_vector(2 downto 0);
sourcerega: in std_logic_vector(2 downto 0);
sourceregb: in std_logic_vector(2 downto 0);
destrega: in std_logic_vector(2 downto 0);
destregb: in std_logic_vector(2 downto 0);
loadhazard: out std_logic;
hazard1: out std_logic;
hazard2: out std_logic;
hazard3: out std_logic;
hazard4: out std_logic
);
end data_hazatd_detect;

architecture bhv of data_hazatd_detect is
begin
process(clk)
variable  temp1: std_logic:='0';
variable  temp2: std_logic:='0';
begin
  if (rst ='1') then
    hazard1<='0';
    hazard2<='0';
    hazard3<='0';
    hazard4<='0';
    loadhazard<='0';
  else
        if(sourcerega = destrega) then
           hazard1<='1';
           temp1:='1';
         else
           hazard1<='0';
           temp1:='0';
        end if;
        if(sourceregb = destrega) then 
          if(thisopcode ="010") then    
            hazard2<='0';
            temp2:='0';
          else
            hazard2<='1';
            temp2:='1';
           end if;
          else
            hazard2<='0';
            temp2:='0';
          end if;
        if(sourcerega = destregb) then
            hazard3<='1';
          else
            hazard3<='0';
          end if;
        if(sourceregb = destregb) then
            if(thisopcode ="010") then
            hazard4<='0';
            else
            hazard4<='1';
           end if;
        else
            hazard4<='0';
          end if;
        
        if(opcode ="010") then
           if(temp1 = '1' or temp2 ='1') then 
              loadhazard<='1';
            else
              loadhazard<='0';
            end if;
        else
           loadhazard<='0';
         end if;
end if;
end process;
end bhv;
