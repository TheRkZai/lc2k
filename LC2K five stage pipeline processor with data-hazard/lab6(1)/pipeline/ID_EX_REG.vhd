--ID_EX REG-------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
entity ID_EX_REG is
  port(
    clk: in std_logic;
    rst: in std_logic;
    firstin: in std_logic_vector( 31 downto 0);
    secondin: in std_logic_vector( 31 downto 0);
    thirdin: in std_logic_vector( 31 downto 0);
    offsetin: in std_logic_vector( 15 downto 0);
    destin: in std_logic_vector ( 2 downto 0);
    opcodein: in std_logic_vector ( 2 downto 0);
    
    firstout: out std_logic_vector( 31 downto 0);
    secondout: out std_logic_vector( 31 downto 0);
    thirdout: out std_logic_vector( 31 downto 0);
    offsetout: out std_logic_vector( 15 downto 0);
    destout: out std_logic_vector ( 2 downto 0);
    opcodeout : out std_logic_vector( 2 downto 0));
  end ID_EX_REG;
  
  architecture bhv of ID_EX_REG is
  begin
  process(clk,rst,firstin,secondin,thirdin,offsetin,destin,opcodein)
    variable temp1 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp2 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp3 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp4 : std_logic_vector (15 downto 0):=conv_std_logic_vector(0,16);
    variable temp5 : std_logic_vector (2 downto 0):=conv_std_logic_vector(0,3);
    variable temp6 : std_logic_vector (2 downto 0):=conv_std_logic_vector(7,3);
      begin
        if(rst ='1') then 
        firstout <= temp1;
        secondout <= temp2;
        thirdout <= temp3;
        offsetout <= temp4;
        destout <= temp5;
        opcodeout <= temp6;
        else
          if(clk'event and clk='1') then
        firstout <=temp1;
        secondout <=temp2;
        thirdout <=temp3;
        offsetout <=temp4;
        destout <= temp5;
        opcodeout <=temp6;
        else
          temp1:=firstin;
          temp2:=secondin;
          temp3:=thirdin;
          temp4:=offsetin;
          temp5:=destin;
          temp6:=opcodein;
         end if;
      end if;
    end process;
end bhv;
 
