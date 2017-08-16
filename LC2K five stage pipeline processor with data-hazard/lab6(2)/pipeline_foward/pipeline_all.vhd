--Datapath and Controller combined structurally---------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity Pipeline_all is
port(rst: in STD_LOGIC;
clk: in STD_LOGIC);
end Pipeline_all;

architecture str of Pipeline_all is

component adder 
port(A : in std_logic_vector (31 downto 0);
B : in std_logic_vector (31 downto 0);
O : out std_logic_vector (31 downto 0));
end component;

component LC2_ALU
port( rst: in std_logic;
A: in std_logic_vector (31 downto 0);
B: in std_logic_vector (31 downto 0);
S: in std_logic; --_vector (1 downto 0);
O: out std_logic_vector (31 downto 0);
EQ: out std_logic);
end component;

component mux4
port(rst : std_logic;
c : in std_logic_vector(31 downto 0);
d : in std_logic_vector(31 downto 0);
e : in std_logic_vector(31 downto 0);
f : in std_logic_vector(31 downto 0);
s : in std_logic_vector(1 downto 0);
muxoutput : out std_logic_vector(31 downto 0));
end component;

component dest_reg 
port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector(2 downto 0);
destin : in std_logic_vector (2 downto 0);
enable : in std_logic;
destoutfir: out std_logic_vector (2 downto 0);
destoutsec: out std_logic_vector (2 downto 0);
destoutthi: out std_logic_vector (2 downto 0)
);
end component;

component muxr
port(rst: in std_logic;
c : in std_logic_vector(2 downto 0);
d : in std_logic_vector(2 downto 0);
s : in std_logic;
muxoutput : out std_logic_vector(2 downto 0));
end component;

component mux2
port(rst: std_logic;
c : in std_logic_vector(31 downto 0);
d : in std_logic_vector(31 downto 0);
s : in std_logic;
muxoutput : out std_logic_vector(31 downto 0));
end component;

component data_hazatd_detect is
port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector(2 downto 0);
thisopcode: in std_logic_vector(2 downto 0);
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
end component;

component data_mem 
port(rst :in std_logic;
  clk: in std_logic;
enable : in std_logic;
R_W : in std_logic;
addr : in std_logic_vector (31 downto 0);
data_in : in std_logic_vector (31 downto 0);
data_out : out std_logic_vector (31 downto 0);
inenable : in std_logic;
inaddr : in std_logic_vector (31 downto 0);
indata_out : out std_logic_vector (31 downto 0));
end component;

component IF_ID_REG 
port(
    clk: in std_logic;
    rst: in std_logic;
    instr: in std_logic_vector( 31 downto 0);
    enable:in std_logic;
    pc_plus_1: in std_logic_vector( 31 downto 0);
    instrout: out std_logic_vector( 31 downto 0);
    pc_out : out std_logic_vector( 31 downto 0));
end component;

component ID_EX_REG 
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
end component;

component EX_MEM_REG 
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
end component;

component MEM_WB_REG 
  port(
    clk: in std_logic;
    rst: in std_logic;
    firstin: in std_logic_vector( 31 downto 0);
    secondin: in std_logic_vector( 31 downto 0);
    opcodein: in std_logic_vector ( 2 downto 0);

    firstout: out std_logic_vector( 31 downto 0);
    secondout: out std_logic_vector( 31 downto 0);
    opcodeout : out std_logic_vector( 2 downto 0));
end component;
  
component reg
port(rst :std_logic;
  clk: in std_logic;
enable : in std_logic;
data : in std_logic_vector (31 downto 0);
O : out std_logic_vector (31 downto 0));
end component;

component register_file
port(rst :std_logic;
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
end component;

component sext
port(rst :std_logic;
A : in std_logic_vector (15 downto 0);
O : out std_logic_vector (31 downto 0));
end component;

component fetch_control
port(
rst: in std_logic;
clk: in std_logic;
loadhazard:in std_logic;
pcen : out std_logic;
memenable: out std_logic;
muxsel : out std_logic;
regen : out std_logic
);
end component;

component decode_control 
port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector( 2 downto 0);
muxout: out std_logic
);
end component;

component excute_control 
port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector( 2 downto 0);
inhazard1: in std_logic;
inhazard2: in std_logic;
inhazard3: in std_logic;
inhazard4: in std_logic;
muxout_1: out std_logic_vector(1 downto 0);
muxout_2: out std_logic_vector(1 downto 0);
muxout_3: out std_logic_vector(1 downto 0);
aluout: out std_logic
);
end component;

component memory_control 
port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector( 2 downto 0);
memable: out std_logic;
memR_W : out std_logic
);
end component;

component write_back_control
port(
rst: in std_logic;
clk: in std_logic;
opcode: in std_logic_vector( 2 downto 0);
muxout: out std_logic;
regen : out std_logic
);
end component;


signal IF_ID_REG_ENABLE: std_logic;
signal PCout : std_logic_vector(31 downto 0);
signal pc_1_out :std_logic_vector(31 downto 0);
signal target :std_logic_vector(31 downto 0);
signal IF_MUX_OUT :std_logic_vector( 31 downto 0);
signal Inst_mem_out :std_logic_vector(31 downto 0);
signal IF_ID_REG_inst_out:std_logic_vector( 31 downto 0);
signal IF_ID_REG_pc_out:std_logic_vector( 31 downto 0);
signal Inst_mem_en :std_logic;
signal IF_mux : std_logic;
signal PCen: std_logic ;

signal firstdest:std_logic_vector( 2 downto 0);
signal seconddest:std_logic_vector( 2 downto 0);
signal thirddest:std_logic_vector( 2 downto 0);
signal ID_MUX_OUT :std_logic_vector(2 downto 0);
signal ID_MUX_control :std_logic;
signal REGen : std_logic;
signal REGout1 : std_logic_vector(31 downto 0);
signal REGout2 : std_logic_vector(31 downto 0);
signal IF_EX_REG_pc_out: std_logic_vector( 31 downto 0);
signal IF_EX_REG_vala: std_logic_vector(31 downto 0);
signal IF_EX_REG_valb: std_logic_vector(31 downto 0);
signal IF_EX_REG_offset: std_logic_vector(15 downto 0);
signal IF_EX_REG_opcode :std_logic_vector( 2 downto 0);
signal ID_MUX_OPCODE:std_logic_vector(2 downto 0);
signal noop:std_logic_vector(2 downto 0);
signal hazard1:std_logic;
signal hazard2:std_logic;
signal hazard3:std_logic;
signal hazard4:std_logic;


signal outhazard1:std_logic;
signal outhazard2:std_logic;
signal outhazard3:std_logic;
signal outhazard4:std_logic;
signal loadhazard:std_logic;
signal offset_out :std_logic_vector(31 downto 0);
signal EX_ADDER_OUT : std_logic_vector(31 downto 0);
signal EX_MUX_OUT_1: std_logic_vector(31 downto 0);
signal EX_MUX_OUT_2: std_logic_vector(31 downto 0);
signal EX_MUX_OUT_3: std_logic_vector(31 downto 0);
signal EX_MUX_control_1 :std_logic_vector(1 downto 0);
signal EX_MUX_control_2 :std_logic_vector(1 downto 0);
signal EX_MUX_control_3 :std_logic_vector(1 downto 0);
signal ALUeql :std_logic;
signal ALUout : std_logic_vector(31 downto 0);
signal ALUsel : std_logic;
signal EX_MEM_eq : std_logic;
signal EX_MEM_ALU: std_logic_vector(31 downto 0);
signal EX_MEM_valb : std_logic_vector(31 downto 0);
signal EX_MEM_opcode: std_logic_vector(2 downto 0);
signal irrevalant : std_logic_vector(31 downto 0);

signal data_mem_enable :std_logic;
signal data_mem_R_W: std_logic;
signal data_mem_out :std_logic_vector(31 downto 0);
signal MEM_WB_ALU: std_logic_vector(31 downto 0);
signal MEM_WB_mdata: std_logic_vector(31 downto 0);
signal MEM_WB_opcode: std_logic_vector(2 downto 0);

signal REGdata : std_logic_vector(31 downto 0);
signal WB_MUX_sel : std_logic;

signal ground : std_logic;
signal ground32 : std_logic_vector(31 downto 0);
signal Vcc : std_logic;
signal r0:std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
signal r1:std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
signal r2:std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
signal r3:std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
signal r4:std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
signal r5:std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
signal r6:std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
signal r7:std_logic_vector(31 downto 0):= "00000000000000000000000000000000";

begin
ground <= '0';
ground32 <=conv_std_logic_vector(0,32);
Vcc <= '1';
noop<="111";
irrevalant<=conv_std_logic_vector(0,32);

U_PC : reg port map (rst,clk,PCen,IF_MUX_OUT,PCout);
U_IF_ADDER : adder port map(PCout,conv_std_logic_vector(1,32),pc_1_out);
U_IF_MUX : mux2 port map(rst,target,pc_1_out,IF_mux,IF_MUX_OUT);
U_IF_ID_REG: IF_ID_REG port map(clk,rst,Inst_mem_out,IF_ID_REG_ENABLE,pc_1_out,IF_ID_REG_inst_out,IF_ID_REG_pc_out);
U_fetch_control : fetch_control port map(rst,clk,loadhazard,PCen,Inst_mem_en,IF_mux,IF_ID_REG_ENABLE);


U_REG_bank : register_file port map (rst,clk,REGen, thirddest, IF_ID_REG_inst_out(21 downto 19), IF_ID_REG_inst_out(18 downto 16),
REGdata, REGout1, REGout2,r0,r1,r2,r3,r4,r5,r6,r7);
U_ID_DEST_REG: dest_reg port map(rst,clk,IF_ID_REG_inst_out(24 downto 22),ID_MUX_OUT,loadhazard,firstdest,seconddest,thirddest);
U_ID_MUX_dest: muxr port map(rst,IF_ID_REG_inst_out(2 downto 0), IF_ID_REG_inst_out(18 downto 16),ID_MUX_control ,ID_MUX_OUT);
U_ID_MUX_opcode:muxr port map(rst,IF_ID_REG_inst_out(24 downto 22),noop,loadhazard,ID_MUX_OPCODE);
U_ID_EX_REG :ID_EX_REG port map(clk,rst,IF_ID_REG_pc_out,REGout1,REGout2,IF_ID_REG_inst_out(15 downto 0),
  ID_MUX_OPCODE,hazard1,hazard2,hazard3,hazard4,IF_EX_REG_pc_out,IF_EX_REG_vala,
  IF_EX_REG_valb,IF_EX_REG_offset,IF_EX_REG_opcode,outhazard1,outhazard2,outhazard3,outhazard4);
U_decode_control: decode_control port map(rst,clk,IF_ID_REG_inst_out(24 downto 22),ID_MUX_control);
U_Data_Hazard : data_hazatd_detect port map(rst,clk,IF_EX_REG_opcode,IF_ID_REG_inst_out(24 downto 22),IF_ID_REG_inst_out(21 downto 19), IF_ID_REG_inst_out(18 downto 16),
firstdest,seconddest,loadhazard,hazard1,hazard2,hazard3,hazard4);

U_sext: sext port map(rst,IF_EX_REG_offset,offset_out);
U_EX_ADDER: adder port map(IF_EX_REG_pc_out,offset_out,EX_ADDER_OUT);


U_EX_MUX_1: mux4 port map(rst,REGdata,EX_MEM_ALU,IF_EX_REG_vala,irrevalant,EX_MUX_control_1,EX_MUX_OUT_1);
U_EX_MUX_2: mux4 port map(rst,IF_EX_REG_valb,REGdata,EX_MEM_ALU,offset_out,EX_MUX_control_2,EX_MUX_OUT_2); 
  U_EX_MUX_3: mux4 port map(rst,IF_EX_REG_valb,REGdata,EX_MEM_ALU,offset_out,EX_MUX_control_3,EX_MUX_OUT_3); 
U_EX_ALU: LC2_ALU port map(rst,EX_MUX_OUT_1,EX_MUX_OUT_2,ALUsel,ALUout,ALUeql);
U_EX_MEM_REG: EX_MEM_REG port map(rst,clk,EX_ADDER_OUT,ALUeql,ALUout,EX_MUX_OUT_3,IF_EX_REG_opcode,
  target,EX_MEM_eq,EX_MEM_ALU,EX_MEM_valb ,EX_MEM_opcode);
U_excute_control : excute_control port map(rst,clk,IF_EX_REG_opcode,outhazard1,outhazard2,outhazard3,outhazard4,EX_MUX_control_1,EX_MUX_control_2,EX_MUX_control_3,ALUsel);
  
U_data_mem : data_mem port map(rst,clk,data_mem_enable,data_mem_R_W,EX_MEM_ALU,EX_MEM_valb ,data_mem_out,Inst_mem_en,PCout,Inst_mem_out);
U_MEM_WB_REG: MEM_WB_REG port map(clk,rst,EX_MEM_ALU,data_mem_out,EX_MEM_opcode,MEM_WB_ALU,MEM_WB_mdata,MEM_WB_opcode);
U_memory_control : memory_control port map(rst,clk,EX_MEM_opcode,data_mem_enable,data_mem_R_W);
  
U_WB_MUX: mux2 port map(rst,MEM_WB_ALU,MEM_WB_mdata,WB_MUX_sel,REGdata);
U_write_back_control : write_back_control port map(rst,clk,MEM_WB_opcode,WB_MUX_sel,REGen);

end str;

