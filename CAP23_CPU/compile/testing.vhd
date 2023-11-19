-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : CAP23_CPU
-- Author      : PARSA
-- Company     : IUST
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\compile\testing.vhd
-- Generated   : Tue Jul  4 14:52:09 2023
-- From        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\src\testing.bde
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
use IEEE.std_logic_unsigned.all;

entity testing is 
end testing;

architecture testing of testing is

---- Component declarations -----

component Adder
  port(
       data_in1 : in STD_LOGIC_VECTOR(15 downto 0);
       data_in2 : in STD_LOGIC_VECTOR(15 downto 0);
       result : out STD_LOGIC_VECTOR(15 downto 0)
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
       StWrite : out STD_LOGIC;
       Branch : out STD_LOGIC;
       Jump : out STD_LOGIC
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
       rs_in : in STD_LOGIC;
       rd_in : in STD_LOGIC;
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
       rs_out : out STD_LOGIC;
       rd_out : out STD_LOGIC;
       data1_out : out STD_LOGIC_VECTOR(15 downto 0);
       data2_out : out STD_LOGIC_VECTOR(15 downto 0);
       sign_extend_out : out STD_LOGIC_VECTOR(15 downto 0)
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
       incremented_pc_out : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;
component Register_File
  port(
       clk : in STD_LOGIC;
       read_reg1 : in STD_LOGIC_VECTOR(3 downto 0);
       read_reg2 : in STD_LOGIC_VECTOR(3 downto 0);
       reg_write : in STD_LOGIC;
       write_reg : in STD_LOGIC_VECTOR(3 downto 0);
       write_data : in STD_LOGIC_VECTOR(15 downto 0);
       read_data1 : out STD_LOGIC_VECTOR(15 downto 0);
       read_data2 : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;
component Sign_Extension_8
  port(
       data_in : in STD_LOGIC_VECTOR(7 downto 0);
       data_out : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := 'Z';

---- Signal declarations used on the diagram ----

signal ALUSrc1_out : STD_LOGIC;
signal ALUSrc2_out : STD_LOGIC;
signal clk : STD_LOGIC;
signal MemRead_out : STD_LOGIC;
signal MemWrite_out : STD_LOGIC;
signal NET221 : STD_LOGIC;
signal NET229 : STD_LOGIC;
signal NET237 : STD_LOGIC;
signal NET253 : STD_LOGIC;
signal NET261 : STD_LOGIC;
signal NET465 : STD_LOGIC;
signal rd_in : STD_LOGIC;
signal rd_out : STD_LOGIC;
signal RegWrite_out : STD_LOGIC;
signal rs_in : STD_LOGIC;
signal rs_out : STD_LOGIC;
signal ALUOp_out : STD_LOGIC_VECTOR(1 downto 0);
signal BUS148 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS161 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS165 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS172 : STD_LOGIC_VECTOR(7 downto 0);
signal BUS180 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS188 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS201 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS245 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS269 : STD_LOGIC_VECTOR(1 downto 0);
signal BUS438 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS446 : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000010";
signal data1_out : STD_LOGIC_VECTOR(15 downto 0);
signal data2_out : STD_LOGIC_VECTOR(15 downto 0);
signal instruction : STD_LOGIC_VECTOR(15 downto 0);
signal MemtoReg_out : STD_LOGIC_VECTOR(1 downto 0);
signal PC : STD_LOGIC_VECTOR(15 downto 0);
signal sign_extend_out : STD_LOGIC_VECTOR(15 downto 0);

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;

begin

---- Processes ----

Process_1 :
process
-- Section above this comment may be overwritten according to
-- "Update sensitivity list automatically" option status
-- declarations
begin
	
	clk <= '0';
	instruction <= "0010000100100000";
	PC <= "0000000000000000";
	wait for 100ns;
	clk <= '1';
	wait for 100ns;
	clk <= '0';
	instruction <= "0110001000110000";
	PC <= "0000000000000010";
	wait for 100ns;
	clk <= '1';
	wait;
	
	
-- statements
end process Process_1;




----  Component instantiations  ----

U1 : Register_File
  port map(
       clk => clk,
       read_reg1 => BUS161,
       read_reg2 => BUS165,
       reg_write => Dangling_Input_Signal,
       write_reg(3) => Dangling_Input_Signal,
       write_reg(2) => Dangling_Input_Signal,
       write_reg(1) => Dangling_Input_Signal,
       write_reg(0) => Dangling_Input_Signal,
       write_data(15) => Dangling_Input_Signal,
       write_data(14) => Dangling_Input_Signal,
       write_data(13) => Dangling_Input_Signal,
       write_data(12) => Dangling_Input_Signal,
       write_data(11) => Dangling_Input_Signal,
       write_data(10) => Dangling_Input_Signal,
       write_data(9) => Dangling_Input_Signal,
       write_data(8) => Dangling_Input_Signal,
       write_data(7) => Dangling_Input_Signal,
       write_data(6) => Dangling_Input_Signal,
       write_data(5) => Dangling_Input_Signal,
       write_data(4) => Dangling_Input_Signal,
       write_data(3) => Dangling_Input_Signal,
       write_data(2) => Dangling_Input_Signal,
       write_data(1) => Dangling_Input_Signal,
       write_data(0) => Dangling_Input_Signal,
       read_data1 => BUS188,
       read_data2 => BUS201
  );

U2 : IF_ID_Reg
  port map(
       clk => clk,
       reg_write => NET465,
       flush => Dangling_Input_Signal,
       op_in(3) => instruction(15),
       op_in(2) => instruction(14),
       op_in(1) => instruction(13),
       op_in(0) => instruction(12),
       rd_in(3) => instruction(11),
       rd_in(2) => instruction(10),
       rd_in(1) => instruction(9),
       rd_in(0) => instruction(8),
       rs_in(3) => instruction(7),
       rs_in(2) => instruction(6),
       rs_in(1) => instruction(5),
       rs_in(0) => instruction(4),
       immediate_in(7) => instruction(7),
       immediate_in(6) => instruction(6),
       immediate_in(5) => instruction(5),
       immediate_in(4) => instruction(4),
       immediate_in(3) => instruction(3),
       immediate_in(2) => instruction(2),
       immediate_in(1) => instruction(1),
       immediate_in(0) => instruction(0),
       address_in(11) => instruction(11),
       address_in(10) => instruction(10),
       address_in(9) => instruction(9),
       address_in(8) => instruction(8),
       address_in(7) => instruction(7),
       address_in(6) => instruction(6),
       address_in(5) => instruction(5),
       address_in(4) => instruction(4),
       address_in(3) => instruction(3),
       address_in(2) => instruction(2),
       address_in(1) => instruction(1),
       address_in(0) => instruction(0),
       incremented_pc_in => BUS438,
       op_out => BUS148,
       rd_out => BUS161,
       rs_out => BUS165,
       immediate_out => BUS172
  );

U3 : ID_EXE_Reg
  port map(
       clk => clk,
       MemtoReg_in => BUS269,
       RegWrite_in => NET237,
       MemRead_in => NET253,
       MemWrite_in => NET261,
       ALUSrc1_in => NET221,
       ALUSrc2_in => NET229,
       ALUOp_in => BUS245,
       rs_in => rs_in,
       rd_in => rd_in,
       data1_in => BUS188,
       data2_in => BUS201,
       sign_extend_in => BUS180,
       MemtoReg_out => MemtoReg_out,
       RegWrite_out => RegWrite_out,
       MemRead_out => MemRead_out,
       MemWrite_out => MemWrite_out,
       ALUSrc1_out => ALUSrc1_out,
       ALUSrc2_out => ALUSrc2_out,
       ALUOp_out => ALUOp_out,
       rs_out => rs_out,
       rd_out => rd_out,
       data1_out => data1_out,
       data2_out => data2_out,
       sign_extend_out => sign_extend_out
  );

U4 : Controller
  port map(
       OpCode => BUS148,
       RegWrite => NET237,
       ALUSrc1 => NET221,
       ALUSrc2 => NET229,
       ALUOp => BUS245,
       MemRead => NET253,
       MemWrite => NET261,
       MemtoReg => BUS269
  );

U5 : Sign_Extension_8
  port map(
       data_in => BUS172,
       data_out => BUS180
  );

U6 : Adder
  port map(
       data_in1 => PC,
       data_in2 => BUS446,
       result => BUS438
  );


---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;

end testing;
