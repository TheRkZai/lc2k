
--8x32 register bank-----------------------------
LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity register_file is
port(rst : in std_logic;
  clk: in std_logic;
DR_enable : in std_logic;
DR_address : in std_logic_vector (2 downto 0);
SR1_address: in std_logic_vector(2 downto 0);
SR2_address: in std_logic_vector(2 downto 0);
data_in: in std_logic_vector (31 downto 0);
SR1_out: out std_logic_vector (31 downto 0);
SR2_out: out std_logic_vector (31 downto 0);
r0: out std_logic_vector(31 downto 0);
r1: out std_logic_vector(31 downto 0);
r2: out std_logic_vector(31 downto 0);
r3: out std_logic_vector(31 downto 0);
r4: out std_logic_vector(31 downto 0);
r5: out std_logic_vector(31 downto 0);
r6: out std_logic_vector(31 downto 0);
r7: out std_logic_vector(31 downto 0)
);
end register_file;

architecture bhv of register_file is
type memory is array (0 to 7) of std_logic_vector(31 downto 0);
signal reg: memory;
begin
process(clk,rst,data_in)
variable temp:std_logic_vector (31 downto 0):="00000000000000000000000000000000";
begin
  if(rst = '1') then
    SR1_out<="00000000000000000000000000000000";
    SR2_out<="00000000000000000000000000000000";
    reg(0)<="00000000000000000000000000000000";
	 reg(1)<="00000000000000000000000000000000";
	 reg(2)<="00000000000000000000000000000000";
	 reg(3)<="00000000000000000000000000000000";
	 reg(4)<="00000000000000000000000000000000";
	 reg(5)<="00000000000000000000000000000000";
  else
    SR1_out <= reg(conv_integer(SR1_address));
    SR2_out <= reg(conv_integer(SR2_address));
    if(DR_enable = '1') then
    reg(conv_integer(DR_address))<=data_in;
    end if;
end if;
end process;

process(clk)
  begin
    r0<= reg(0);
    r1<= reg(1);
    r2<= reg(2);
    r3<= reg(3);
    r4<= reg(4);
    r5<= reg(5);
    r6<= reg(6);
    r7<= reg(7);
  end process;
end bhv;


