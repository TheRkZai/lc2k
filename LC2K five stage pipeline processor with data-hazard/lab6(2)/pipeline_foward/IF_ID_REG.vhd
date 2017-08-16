--IF_ID REG-------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
entity IF_ID_REG is
port(
    clk: in std_logic;
    rst: in std_logic;
    instr: in std_logic_vector( 31 downto 0);
    enable:in std_logic;
    pc_plus_1: in std_logic_vector( 31 downto 0);
    instrout: out std_logic_vector( 31 downto 0);
    pc_out : out std_logic_vector( 31 downto 0));
end IF_ID_REG;
  
  architecture bhv of IF_ID_REG is
  begin
  process(clk,rst)
    variable temp1 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp2 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
      begin
        if(rst ='1') then 
           pc_out<=temp2;
        else
          if(clk'event and clk='1' and enable ='1') then
              instrout<=temp1;
              pc_out<=temp2;
        else
              temp1:=instr;
              temp2:=pc_plus_1;
         end if;
      end if;
    end process;
end bhv;
 

