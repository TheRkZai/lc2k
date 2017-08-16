--MEM_WB_REG-------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
entity MEM_WB_REG is
  port(
    clk: in std_logic;
    rst: in std_logic;
    firstin: in std_logic_vector( 31 downto 0);
    secondin: in std_logic_vector( 31 downto 0);
    opcodein: in std_logic_vector ( 2 downto 0);

    
    firstout: out std_logic_vector( 31 downto 0);
    secondout: out std_logic_vector( 31 downto 0);
    opcodeout : out std_logic_vector( 2 downto 0));
  end MEM_WB_REG;
  
  architecture bhv of MEM_WB_REG is
  begin
  process(clk,rst,firstin,secondin,opcodein)
    variable temp1 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp2 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp3 : std_logic_vector (2 downto 0):=conv_std_logic_vector(0,3);
    variable temp4 : std_logic_vector (2 downto 0):=conv_std_logic_vector(7,3);
      begin
        if(rst ='1') then 
        firstout <= temp1;
        secondout <= temp2;
        opcodeout <= temp4;
        else
          if(clk'event and clk='1') then
        firstout <=temp1;
        secondout <=temp2;
        opcodeout <=temp4;
        else
          temp1:=firstin;
          temp2:=secondin;
          temp4:=opcodein;
        end if;
      end if;
		      temp1:=firstin;
          temp2:=secondin;
          temp4:=opcodein;
      end process;
  end bhv;
  
  


