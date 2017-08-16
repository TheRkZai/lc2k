--branch equal control---------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity branch is
  port(rst :in std_logic;
    beq :in std_logic;
    opcode :in std_logic_vector(2 downto 0);
    pccontrol :in std_logic;
    pcen:out std_logic);
  end branch;
  
architecture bhv of branch is 
begin
  process(rst,beq,opcode,pccontrol)
  variable isbeq : std_logic;
  variable gate: std_logic :='0';
  begin
    if(rst = '1') then
       pcen <= '0';
     else
  case opcode is
  when "100" => isbeq:='1';
  when others => isbeq:='0';
  end case;
  if isbeq='1' and beq = '1' then
      gate:='1';
    else
      gate:='0';
  end if;
  pcen<= (gate or pccontrol);
end if;
end process;
end architecture bhv;


