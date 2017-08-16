library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity memory_control is
port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector( 2 downto 0);
memable: out std_logic;
memR_W : out std_logic
);
end memory_control;
architecture bhv of memory_control is
constant ADD : std_logic_vector(2 downto 0) := "000";
constant NAD : std_logic_vector(2 downto 0) := "001";
constant LW : std_logic_vector(2 downto 0) := "010";
constant SW : std_logic_vector(2 downto 0) := "011";
constant BEQ : std_logic_vector(2 downto 0) := "100";
constant JALR : std_logic_vector(2 downto 0) := "101";
constant HALT : std_logic_vector(2 downto 0) := "110";
constant NOOP : std_logic_vector(2 downto 0) := "111";
begin
   process(clk,rst,opcode)
     begin
       if(rst ='1') then
          memable<='0';
          memR_W<='0';

        else
          if(opcode = ADD or opcode = NAD) then
             memable<='0';
             memR_W<='0';
          elsif(opcode = LW) then
             memable<='1';
             memR_W<='0';
          elsif(opcode =SW) then
             memable<='1';
             memR_W<='1';
          else
             memable<='0';
       end if;
      end if;
end process;
end bhv;


