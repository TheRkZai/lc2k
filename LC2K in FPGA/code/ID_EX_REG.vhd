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
    opcodein: in std_logic_vector ( 2 downto 0);
    inhazard1: in std_logic;
    inhazard2: in std_logic;
    inhazard3: in std_logic;
    inhazard4: in std_logic;
    
    firstout: out std_logic_vector( 31 downto 0);
    secondout: out std_logic_vector( 31 downto 0);
    thirdout: out std_logic_vector( 31 downto 0);
    offsetout: out std_logic_vector( 15 downto 0);
    opcodeout : out std_logic_vector( 2 downto 0);
    hazard1: out std_logic;
    hazard2: out std_logic;
    hazard3: out std_logic;
    hazard4: out std_logic);
  end ID_EX_REG;
  
  architecture bhv of ID_EX_REG is
  begin
  process(clk,rst,firstin,secondin,thirdin,offsetin,opcodein,inhazard1,inhazard2,inhazard3,inhazard4)
    variable temp1 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp2 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp3 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp4 : std_logic_vector (15 downto 0):=conv_std_logic_vector(0,16);
    variable temp5 : std_logic_vector (2 downto 0):=conv_std_logic_vector(0,3);
    variable temp6 : std_logic_vector (2 downto 0):=conv_std_logic_vector(7,3);
    variable temp7 : std_logic:='0';
    variable temp8 : std_logic:='0';
    variable temp9 : std_logic:='0';
    variable temp10 : std_logic:='0';
      begin
      if(rst ='1') then 
        firstout <= temp1;
        secondout <= temp2;
        thirdout <= temp3;
        offsetout <= temp4;
        opcodeout <= temp6;
        hazard1<=temp7;
        hazard2<=temp8;
        hazard3<=temp9;
        hazard4<=temp10;
      else
          if(clk'event and clk='1') then
          firstout <=temp1;
          secondout <=temp2;
          thirdout <=temp3;
          offsetout <=temp4;
          opcodeout <=temp6;
          hazard1<=temp7;
          hazard2<=temp8;
          hazard3<=temp9;
          hazard4<=temp10;
        else
          temp1:=firstin;
          temp2:=secondin;
          temp3:=thirdin;
          temp4:=offsetin;
          temp6:=opcodein;
          temp7:=inhazard1;
          temp8:=inhazard2;
          temp9:=inhazard3;
          temp10:=inhazard4;
         end if;
      end if;
		      temp1:=firstin;
          temp2:=secondin;
          temp3:=thirdin;
          temp4:=offsetin;
          temp6:=opcodein;
          temp7:=inhazard1;
          temp8:=inhazard2;
          temp9:=inhazard3;
          temp10:=inhazard4;
end process;
end bhv;
 
