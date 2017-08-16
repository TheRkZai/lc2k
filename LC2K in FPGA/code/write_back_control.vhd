library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity write_back_control is
port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector( 2 downto 0);
muxout: out std_logic;
regen : out std_logic
);
end write_back_control;
architecture bhv of write_back_control is
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
          muxout<='0';
          regen<='0';
        else
          if(opcode = ADD or opcode = NAD) then
             muxout<='0';
             regen<='1';
          elsif(opcode = LW) then
             muxout<='1';
             regen<='1';
        else
             regen<='0';
       end if;
      end if;
end process;
end bhv;






