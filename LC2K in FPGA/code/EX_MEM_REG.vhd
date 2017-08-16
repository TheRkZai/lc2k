--EX_MEM_REG-------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
entity EX_MEM_REG is
  port(
    rst: in std_logic;
    clk: in std_logic;
    targetin: in std_logic_vector( 31 downto 0);
    equalin: in std_logic;
    aluresultin: in std_logic_vector( 31 downto 0);
    valbin: in std_logic_vector( 31 downto 0);
    opcodein: in std_logic_vector ( 2 downto 0);
   
    targetout: out std_logic_vector( 31 downto 0);
    equalout: out std_logic;
    aluresultout: out std_logic_vector( 31 downto 0);
    valbout: out std_logic_vector( 31 downto 0);
    opcodeout : out std_logic_vector( 2 downto 0));
  end EX_MEM_REG;
  
  architecture bhv of EX_MEM_REG is
  begin
  process(clk,rst,targetin,equalin,aluresultin,valbin,opcodein)
    variable temp1 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp2 : std_logic:='0';
    variable temp3 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp4 : std_logic_vector (31 downto 0):=conv_std_logic_vector(0,32);
    variable temp5 : std_logic_vector (2 downto 0):=conv_std_logic_vector(0,3);
    variable temp6 : std_logic_vector (2 downto 0):=conv_std_logic_vector(7,3);

      begin
        if(rst ='1') then 
        targetout <= temp1;
        equalout <= temp2;
        aluresultout <= temp3;
        valbout <= temp4;
        opcodeout <= temp6;
        else
          if(clk'event and clk='1') then
        targetout <=temp1;
        equalout <=temp2;
        aluresultout <=temp3;
        valbout <=temp4;
        opcodeout <=temp6;
        else
          temp1:=targetin;
          temp2:=equalin;
          temp3:=aluresultin;
          temp4:=valbin;
          temp6:=opcodein;
        end if;
      end if;
		      temp1:=targetin;
          temp2:=equalin;
          temp3:=aluresultin;
          temp4:=valbin;
          temp6:=opcodein;
      end process;
  end bhv; 
  
