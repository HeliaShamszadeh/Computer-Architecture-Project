-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : CAP23_CPU
-- Author      : PARSA
-- Company     : IUST
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\New folder\CAP23\CAP23_CPU\compile\CPU.vhd
-- Generated   : Mon Jul 10 21:36:29 2023
-- From        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\New folder\CAP23\CAP23_CPU\src\CPU.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity CPU is
  port(
       clk : in STD_LOGIC;
       StatusRegister : out STD_LOGIC_VECTOR(15 downto 0);
       PC : out STD_LOGIC_VECTOR(15 downto 0);
       ALUOutput : out STD_LOGIC_VECTOR(15 downto 0);
       DataMem : out STD_LOGIC_VECTOR(15 downto 0);
       AddressMem : out STD_LOGIC_VECTOR(15 downto 0);
       Reset : in STD_LOGIC
  );
end CPU;

architecture CPU of CPU is

---- Component declarations -----

component Adder
  port(
       data_in1 : in STD_LOGIC_VECTOR(15 downto 0);
       data_in2 : in STD_LOGIC_VECTOR(15 downto 0);
       result : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;
component AdderEnable
  port(
       data_in1 : in STD_LOGIC_VECTOR(15 downto 0);
       data_in2 : in STD_LOGIC_VECTOR(15 downto 0);
       enable : in STD_LOGIC;
       result : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;
component ALU
  port(
       data_in1 : in STD_LOGIC_VECTOR(15 downto 0);
       data_in2 : in STD_LOGIC_VECTOR(15 downto 0);
       ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
       result : out STD_LOGIC_VECTOR(15 downto 0);
       status : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;
component Controller
  port(
       OpCode : in STD_LOGIC_VECTOR(3 downto 0);
       ReadReg1 : out STD_LOGIC;
       ReadReg2 : out STD_LOGIC;
       RegWrite : out STD_LOGIC;
       ALUSrc1 : out STD_LOGIC;
       ALUSrc2 : out STD_LOGIC;
       ALUOp : out STD_LOGIC_VECTOR(1 downto 0);
       MemRead : out STD_LOGIC;
       MemWrite : out STD_LOGIC;
       MemtoReg : out STD_LOGIC_VECTOR(1 downto 0);
       Branch : out STD_LOGIC;
       Jump : out STD_LOGIC
  );
end component;
component EXE_MEM_Reg
  port(
       clk : in STD_LOGIC;
       RegWrite_in : in STD_LOGIC;
       MemtoReg_in : in STD_LOGIC_VECTOR(1 downto 0);
       MemRead_in : in STD_LOGIC;
       MemWrite_in : in STD_LOGIC;
       ALUResult_in : in STD_LOGIC_VECTOR(15 downto 0);
       rd_val_in : in STD_LOGIC_VECTOR(15 downto 0);
       rd_in : in STD_LOGIC_VECTOR(3 downto 0);
       RegWrite_out : out STD_LOGIC;
       MemtoReg_out : out STD_LOGIC_VECTOR(1 downto 0);
       MemRead_out : out STD_LOGIC;
       MemWrite_out : out STD_LOGIC;
       ALUResult_out : out STD_LOGIC_VECTOR(15 downto 0);
       rd_val_out : out STD_LOGIC_VECTOR(15 downto 0);
       rd_out : out STD_LOGIC_VECTOR(3 downto 0);
       reset : in STD_LOGIC
  );
end component;
component ForwardingUnit
  port(
       MemWrite : in STD_LOGIC;
       MemRead : in STD_LOGIC;
       RegWrite_EXE : in STD_LOGIC;
       RegWrite_MEM : in STD_LOGIC;
       rd_ID : in STD_LOGIC_VECTOR(3 downto 0);
       rs_ID : in STD_LOGIC_VECTOR(3 downto 0);
       rd_EXE : in STD_LOGIC_VECTOR(3 downto 0);
       rd_MEM : in STD_LOGIC_VECTOR(3 downto 0);
       ForwardA : out STD_LOGIC_VECTOR(1 downto 0);
       ForwardB : out STD_LOGIC_VECTOR(1 downto 0);
       ForwardC : out STD_LOGIC_VECTOR(1 downto 0)
  );
end component;
component HazardDetectionUnit
  port(
       EXE_MemRead : in STD_LOGIC;
       ALUSrc2 : in STD_LOGIC;
       EXE_rd : in STD_LOGIC_VECTOR(3 downto 0);
       ID_rd : in STD_LOGIC_VECTOR(3 downto 0);
       ID_rs : in STD_LOGIC_VECTOR(3 downto 0);
       Hazard : out STD_LOGIC
  );
end component;
component ID_EXE_Reg
  port(
       clk : in STD_LOGIC;
       MemtoReg_in : in STD_LOGIC_VECTOR(1 downto 0);
       RegWrite_in : in STD_LOGIC;
       MemRead_in : in STD_LOGIC;
       MemWrite_in : in STD_LOGIC;
       ALUSrc1_in : in STD_LOGIC;
       ALUSrc2_in : in STD_LOGIC;
       ALUOp_in : in STD_LOGIC_VECTOR(1 downto 0);
       rs_in : in STD_LOGIC_VECTOR(3 downto 0);
       rd_in : in STD_LOGIC_VECTOR(3 downto 0);
       data1_in : in STD_LOGIC_VECTOR(15 downto 0);
       data2_in : in STD_LOGIC_VECTOR(15 downto 0);
       sign_extend_in : in STD_LOGIC_VECTOR(15 downto 0);
       MemtoReg_out : out STD_LOGIC_VECTOR(1 downto 0);
       RegWrite_out : out STD_LOGIC;
       MemRead_out : out STD_LOGIC;
       MemWrite_out : out STD_LOGIC;
       ALUSrc1_out : out STD_LOGIC;
       ALUSrc2_out : out STD_LOGIC;
       ALUOp_out : out STD_LOGIC_VECTOR(1 downto 0);
       rs_out : out STD_LOGIC_VECTOR(3 downto 0);
       rd_out : out STD_LOGIC_VECTOR(3 downto 0);
       data1_out : out STD_LOGIC_VECTOR(15 downto 0);
       data2_out : out STD_LOGIC_VECTOR(15 downto 0);
       sign_extend_out : out STD_LOGIC_VECTOR(15 downto 0);
       CZero : in STD_LOGIC;
       reset : in STD_LOGIC
  );
end component;
component IF_ID_Reg
  port(
       clk : in STD_LOGIC;
       reg_write : in STD_LOGIC;
       flush : in STD_LOGIC;
       op_in : in STD_LOGIC_VECTOR(3 downto 0);
       rd_in : in STD_LOGIC_VECTOR(3 downto 0);
       rs_in : in STD_LOGIC_VECTOR(3 downto 0);
       immediate_in : in STD_LOGIC_VECTOR(7 downto 0);
       address_in : in STD_LOGIC_VECTOR(11 downto 0);
       incremented_pc_in : in STD_LOGIC_VECTOR(15 downto 0);
       op_out : out STD_LOGIC_VECTOR(3 downto 0);
       rd_out : out STD_LOGIC_VECTOR(3 downto 0);
       rs_out : out STD_LOGIC_VECTOR(3 downto 0);
       immediate_out : out STD_LOGIC_VECTOR(7 downto 0);
       address_out : out STD_LOGIC_VECTOR(11 downto 0);
       incremented_pc_out : out STD_LOGIC_VECTOR(15 downto 0);
       reset : in STD_LOGIC
  );
end component;
component Memory_1KB
  port(
       clk : in STD_LOGIC;
       Address : in STD_LOGIC_VECTOR(15 downto 0);
       WriteData : in STD_LOGIC_VECTOR(15 downto 0);
       MemWrite : in STD_LOGIC;
       MemRead : in STD_LOGIC;
       ReadData : out STD_LOGIC_VECTOR(15 downto 0);
       reset : in STD_LOGIC
  );
end component;
component Memory_3KB
  port(
       Address : in STD_LOGIC_VECTOR(15 downto 0);
       WriteData : in STD_LOGIC_VECTOR(15 downto 0);
       MemWrite : in STD_LOGIC;
       MemRead : in STD_LOGIC;
       ReadData : out STD_LOGIC_VECTOR(15 downto 0);
       reset : in STD_LOGIC
  );
end component;
component MEM_WB_Reg
  port(
       clk : in STD_LOGIC;
       RegWrite_in : in STD_LOGIC;
       MemtoReg_in : in STD_LOGIC_VECTOR(1 downto 0);
       ALUResult_in : in STD_LOGIC_VECTOR(15 downto 0);
       MemResult_in : in STD_LOGIC_VECTOR(15 downto 0);
       rd_in : in STD_LOGIC_VECTOR(3 downto 0);
       AdderResult_in : in STD_LOGIC_VECTOR(15 downto 0);
       RegWrite_out : out STD_LOGIC;
       MemtoReg_out : out STD_LOGIC_VECTOR(1 downto 0);
       ALUResult_out : out STD_LOGIC_VECTOR(15 downto 0);
       MemResult_out : out STD_LOGIC_VECTOR(15 downto 0);
       rd_out : out STD_LOGIC_VECTOR(3 downto 0);
       AdderResult_out : out STD_LOGIC_VECTOR(15 downto 0);
       reset : in STD_LOGIC
  );
end component;
component Mux_2_1
  port(
       data_in1 : in STD_LOGIC_VECTOR(15 downto 0);
       data_in2 : in STD_LOGIC_VECTOR(15 downto 0);
       data_out : out STD_LOGIC_VECTOR(15 downto 0);
       select_bit : in STD_LOGIC
  );
end component;
component Mux_2_4bit
  port(
       data_in1 : in STD_LOGIC_VECTOR(3 downto 0);
       data_in2 : in STD_LOGIC_VECTOR(3 downto 0);
       data_out : out STD_LOGIC_VECTOR(3 downto 0);
       select_bit : in STD_LOGIC
  );
end component;
component Mux_3_1
  port(
       data_in1 : in STD_LOGIC_VECTOR(15 downto 0);
       data_in2 : in STD_LOGIC_VECTOR(15 downto 0);
       data_in3 : in STD_LOGIC_VECTOR(15 downto 0);
       data_out : out STD_LOGIC_VECTOR(15 downto 0);
       select_bits : in STD_LOGIC_VECTOR(1 downto 0)
  );
end component;
component PC_Reg
  port(
       PCWrite : in STD_LOGIC;
       data_in : in STD_LOGIC_VECTOR(15 downto 0);
       data_out : out STD_LOGIC_VECTOR(15 downto 0);
       PCWrite2 : in STD_LOGIC;
       reset : in STD_LOGIC
  );
end component;
component Register_File
  port(
       read_reg1 : in STD_LOGIC_VECTOR(3 downto 0);
       read_reg2 : in STD_LOGIC_VECTOR(3 downto 0);
       reg_write : in STD_LOGIC;
       write_reg : in STD_LOGIC_VECTOR(3 downto 0);
       write_data : in STD_LOGIC_VECTOR(15 downto 0);
       read_data1 : out STD_LOGIC_VECTOR(15 downto 0);
       read_data2 : out STD_LOGIC_VECTOR(15 downto 0);
       st_in : in STD_LOGIC_VECTOR(15 downto 0);
       st_out : out STD_LOGIC_VECTOR(15 downto 0);
       zero : out STD_LOGIC;
       reset : in STD_LOGIC
  );
end component;
component Sign_Extension_12
  port(
       data_in : in STD_LOGIC_VECTOR(11 downto 0);
       data_out : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;
component Sign_Extension_8
  port(
       data_in : in STD_LOGIC_VECTOR(7 downto 0);
       data_out : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal En : STD_LOGIC := '0';
signal InsMemRead : STD_LOGIC;
signal InsMemWrite : STD_LOGIC;
signal LoadMem : STD_LOGIC;
signal NET1085 : STD_LOGIC;
signal NET1097 : STD_LOGIC;
signal NET1640 : STD_LOGIC;
signal NET1648 : STD_LOGIC;
signal NET16929 : STD_LOGIC;
signal NET1712 : STD_LOGIC;
signal NET1742 : STD_LOGIC;
signal NET17800 : STD_LOGIC;
signal NET17820 : STD_LOGIC;
signal NET19339 : STD_LOGIC;
signal NET2038 : STD_LOGIC;
signal NET2046 : STD_LOGIC;
signal NET206 : STD_LOGIC;
signal NET20826 : STD_LOGIC;
signal NET20945 : STD_LOGIC;
signal NET20951 : STD_LOGIC;
signal NET248 : STD_LOGIC;
signal NET28675 : STD_LOGIC;
signal NET32542 : STD_LOGIC;
signal NET32550 : STD_LOGIC;
signal NET398 : STD_LOGIC;
signal NET43 : STD_LOGIC;
signal NET438 : STD_LOGIC;
signal NET51 : STD_LOGIC;
signal NET5471 : STD_LOGIC;
signal PCWrite : STD_LOGIC;
signal BA_num : STD_LOGIC_VECTOR(3 downto 0) := "1010";
signal BUS1138 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1390 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1406 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1424 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1432 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS1501 : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal BUS1523 : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal BUS1589 : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal BUS16833 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1690 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS16904 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS16913 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS1790 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS181 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS185 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1969 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS1996 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS20701 : STD_LOGIC_VECTOR(11 downto 0);
signal BUS20781 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2266 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS228 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2305 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2316 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS2344 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS274 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS2753 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS2783 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS32473 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS32477 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS32491 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS35 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS3598 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS41428 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS41432 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS41436 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS41446 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS467 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS66 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS70 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS7226 : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
signal BUS7251 : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
signal BUS9255 : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
signal BUS987 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS991 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS9934 : STD_LOGIC_VECTOR(15 downto 0);
signal BusAddMem : STD_LOGIC_VECTOR(15 downto 0);
signal BusAlu : STD_LOGIC_VECTOR(15 downto 0);
signal BusDataMem : STD_LOGIC_VECTOR(15 downto 0);
signal InsMemData : STD_LOGIC_VECTOR(15 downto 0);
signal Instruction : STD_LOGIC_VECTOR(15 downto 0);
signal Inst_Im : STD_LOGIC_VECTOR(7 downto 0);
signal LoadInsAddr : STD_LOGIC_VECTOR(15 downto 0);
signal TwoConstant : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000010";
signal ZeroB : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";

begin

---- Processes ----

LoadInstructions :
process(clk)
-- Section above this comment may be overwritten according to
-- "Update sensitivity list automatically" option status
-- declarations

	File MachineCode : text;
	variable FileOpened : boolean := false;
	variable Line : line;
	variable Code : std_logic_vector(15 downto 0);
	variable Addr : integer := 0;
begin
-- statements
	
	if rising_edge(clk) and not FileOpened then
		FileOpened := true;
		file_open(MachineCode, "input.txt", read_mode);
		PCWrite <= '0';
		LoadMem <= '1';
		InsMemWrite <= '1';
		InsMemRead <= '0';							 
	elsif rising_edge(clk) and not endfile(MachineCode) then
		readline(MachineCode, Line);
		read(Line, Code);
		InsMemData <= Code;
		LoadInsAddr <= std_logic_vector(to_unsigned(Addr, 16));
		Addr := Addr + 2;
		if endfile(MachineCode) then
			En <= '1';
		end if;
	elsif FileOpened and not rising_edge(clk) and endfile(MachineCode) then
		LoadMem <= '0';
		InsMemRead <= '1';
		InsMemWrite <= '0';
		PCWrite <= '1';
	elsif rising_edge(clk) and Reset = '1' then
		FileOpened := false;
		Addr := 0;
		LoadInsAddr <= std_logic_vector(to_unsigned(Addr, 16));
		En <= '0';
		file_close(MachineCode);
	end if;

end process LoadInstructions;
























----  Component instantiations  ----

U1 : IF_ID_Reg
  port map(
       clk => clk,
       reg_write => NET17820,
       flush => NET28675,
       op_in(3) => Instruction(15),
       op_in(2) => Instruction(14),
       op_in(1) => Instruction(13),
       op_in(0) => Instruction(12),
       rd_in(3) => Instruction(11),
       rd_in(2) => Instruction(10),
       rd_in(1) => Instruction(9),
       rd_in(0) => Instruction(8),
       rs_in(3) => Instruction(7),
       rs_in(2) => Instruction(6),
       rs_in(1) => Instruction(5),
       rs_in(0) => Instruction(4),
       immediate_in(7) => Instruction(7),
       immediate_in(6) => Instruction(6),
       immediate_in(5) => Instruction(5),
       immediate_in(4) => Instruction(4),
       immediate_in(3) => Instruction(3),
       immediate_in(2) => Instruction(2),
       immediate_in(1) => Instruction(1),
       immediate_in(0) => Instruction(0),
       address_in(11) => Instruction(11),
       address_in(10) => Instruction(10),
       address_in(9) => Instruction(9),
       address_in(8) => Instruction(8),
       address_in(7) => Instruction(7),
       address_in(6) => Instruction(6),
       address_in(5) => Instruction(5),
       address_in(4) => Instruction(4),
       address_in(3) => Instruction(3),
       address_in(2) => Instruction(2),
       address_in(1) => Instruction(1),
       address_in(0) => Instruction(0),
       incremented_pc_in => BUS7226,
       op_out => BUS35,
       rd_out => BUS16904,
       rs_out => BUS16913,
       immediate_out => Inst_Im,
       address_out => BUS20701,
       incremented_pc_out => BUS7251,
       reset => Reset
  );

U10 : Mux_3_1
  port map(
       data_in1 => BUS1390,
       data_in2 => BUS2753,
       data_in3 => BusAddMem,
       data_out => BUS991,
       select_bits => BUS1523
  );

U11 : Mux_2_1
  port map(
       data_in1 => BUS991,
       data_in2 => BUS1138,
       data_out => BUS1424,
       select_bit => NET1097
  );

U12 : Mux_2_1
  port map(
       data_in1 => BUS987,
       data_in2 => ZeroB,
       data_out => BUS1406,
       select_bit => NET1085
  );

U13 : ALU
  port map(
       data_in1 => BUS1406,
       data_in2 => BUS1424,
       ALUOp => BUS1432,
       result => BusAlu,
       status => BUS16833
  );

U14 : ForwardingUnit
  port map(
       MemWrite => NET1648,
       MemRead => NET1640,
       RegWrite_EXE => NET1712,
       RegWrite_MEM => NET5471,
       rd_ID => BUS1996,
       rs_ID => BUS1690,
       rd_EXE => BUS2316,
       rd_MEM => BUS2783,
       ForwardA => BUS1589,
       ForwardB => BUS1523,
       ForwardC => BUS1501
  );

U15 : Mux_3_1
  port map(
       data_in1 => BUS1390,
       data_in2 => BUS2753,
       data_in3 => BusAddMem,
       data_out => BUS1969,
       select_bits => BUS1501
  );

U16 : EXE_MEM_Reg
  port map(
       clk => clk,
       RegWrite_in => NET1742,
       MemtoReg_in => BUS1790,
       MemRead_in => NET1640,
       MemWrite_in => NET1648,
       ALUResult_in => BusAlu,
       rd_val_in => BUS1969,
       rd_in => BUS1996,
       RegWrite_out => NET1712,
       MemtoReg_out => BUS2344,
       MemRead_out => NET2038,
       MemWrite_out => NET2046,
       ALUResult_out => BusAddMem,
       rd_val_out => BUS2305,
       rd_out => BUS2316,
       reset => Reset
  );

U17 : AdderEnable
  port map(
       data_in1 => BUS9255,
       data_in2 => TwoConstant,
       enable => En,
       result => BUS7226
  );

U18 : Memory_3KB
  port map(
       Address => BusAddMem,
       WriteData => BUS2305,
       MemWrite => NET2046,
       MemRead => NET2038,
       ReadData => BusDataMem,
       reset => Reset
  );

U19 : MEM_WB_Reg
  port map(
       clk => clk,
       RegWrite_in => NET1712,
       MemtoReg_in => BUS2344,
       ALUResult_in => BusAddMem,
       MemResult_in => BusDataMem,
       rd_in => BUS2316,
       AdderResult_in => BUS2266,
       RegWrite_out => NET5471,
       MemtoReg_out => BUS41428,
       ALUResult_out => BUS41432,
       MemResult_out => BUS41436,
       rd_out => BUS2783,
       AdderResult_out => BUS41446,
       reset => Reset
  );

U2 : Register_File
  port map(
       read_reg1 => BUS66,
       read_reg2 => BUS70,
       reg_write => NET5471,
       write_reg => BUS2783,
       write_data => BUS2753,
       read_data1 => BUS181,
       read_data2 => BUS185,
       st_in => BUS16833,
       st_out => StatusRegister,
       zero => NET20945,
       reset => Reset
  );

U20 : Memory_1KB
  port map(
       clk => clk,
       Address => BUS9934,
       WriteData => InsMemData,
       MemWrite => InsMemWrite,
       MemRead => InsMemRead,
       ReadData => Instruction,
       reset => Reset
  );

U21 : Adder
  port map(
       data_in1 => BusDataMem,
       data_in2 => BUS2305,
       result => BUS2266
  );

U22 : Mux_3_1
  port map(
       data_in1 => BUS41432,
       data_in2 => BUS41436,
       data_in3 => BUS41446,
       data_out => BUS2753,
       select_bits => BUS41428
  );

U23 : PC_Reg
  port map(
       PCWrite => PCWrite,
       data_in => BUS20781,
       data_out => BUS9255,
       PCWrite2 => NET19339,
       reset => Reset
  );

U24 : HazardDetectionUnit
  port map(
       EXE_MemRead => NET1640,
       ALUSrc2 => NET16929,
       EXE_rd => BUS1996,
       ID_rd => BUS16904,
       ID_rs => BUS16913,
       Hazard => NET17800
  );

NET17820 <= not(NET17800);

U27 : Sign_Extension_12
  port map(
       data_in => BUS20701,
       data_out => BUS32491
  );

U28 : Adder
  port map(
       data_in1 => BUS7251,
       data_in2 => BUS32491,
       result => BUS32473
  );

NET19339 <= not(NET17800);

U3 : Controller
  port map(
       OpCode => BUS35,
       ReadReg1 => NET43,
       ReadReg2 => NET51,
       RegWrite => NET206,
       ALUSrc1 => NET248,
       ALUSrc2 => NET16929,
       ALUOp => BUS274,
       MemRead => NET398,
       MemWrite => NET438,
       MemtoReg => BUS467,
       Branch => NET20826,
       Jump => NET32550
  );

U30 : Mux_2_1
  port map(
       data_in1 => BUS7251,
       data_in2 => BUS32477,
       data_out => BUS20781,
       select_bit => NET28675
  );

NET20951 <= not(NET20945);

NET32542 <= NET20951 and NET20826;

U33 : Mux_2_1
  port map(
       data_in1 => BUS32473,
       data_in2 => BUS32491,
       data_out => BUS32477,
       select_bit => NET32550
  );

NET28675 <= NET32550 or NET32542;

U4 : Mux_2_4bit
  port map(
       data_in1 => BUS16913,
       data_in2 => BUS16904,
       data_out => BUS70,
       select_bit => NET51
  );

U5 : Mux_2_4bit
  port map(
       data_in1 => BUS16904,
       data_in2 => BA_num,
       data_out => BUS66,
       select_bit => NET43
  );

U6 : ID_EXE_Reg
  port map(
       clk => clk,
       MemtoReg_in => BUS467,
       RegWrite_in => NET206,
       MemRead_in => NET398,
       MemWrite_in => NET438,
       ALUSrc1_in => NET248,
       ALUSrc2_in => NET16929,
       ALUOp_in => BUS274,
       rs_in => BUS16913,
       rd_in => BUS16904,
       data1_in => BUS181,
       data2_in => BUS185,
       sign_extend_in => BUS228,
       MemtoReg_out => BUS1790,
       RegWrite_out => NET1742,
       MemRead_out => NET1640,
       MemWrite_out => NET1648,
       ALUSrc1_out => NET1085,
       ALUSrc2_out => NET1097,
       ALUOp_out => BUS1432,
       rs_out => BUS1690,
       rd_out => BUS1996,
       data1_out => BUS3598,
       data2_out => BUS1390,
       sign_extend_out => BUS1138,
       CZero => NET17800,
       reset => Reset
  );

U7 : Sign_Extension_8
  port map(
       data_in => Inst_Im,
       data_out => BUS228
  );

U8 : Mux_2_1
  port map(
       data_in1 => BUS9255,
       data_in2 => LoadInsAddr,
       data_out => BUS9934,
       select_bit => LoadMem
  );

U9 : Mux_3_1
  port map(
       data_in1 => BUS3598,
       data_in2 => BUS2753,
       data_in3 => BusAddMem,
       data_out => BUS987,
       select_bits => BUS1589
  );


---- Terminal assignment ----

    -- Output\buffer terminals
	ALUOutput <= BusAlu;
	AddressMem <= BusAddMem;
	DataMem <= BusDataMem;
	PC <= BUS9255;


end CPU;
