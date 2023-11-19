-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : CAP23_CPU
-- Author      : PARSA
-- Company     : IUST
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\compile\ALU_Test.vhd
-- Generated   : Sat Jul  8 11:51:30 2023
-- From        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\src\ALU_Test.bde
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

entity ALU_Test is 
end ALU_Test;

architecture ALU_Test of ALU_Test is

---- Component declarations -----

component ALU
  port(
       data_in1 : in STD_LOGIC_VECTOR(15 downto 0);
       data_in2 : in STD_LOGIC_VECTOR(15 downto 0);
       ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
       result : out STD_LOGIC_VECTOR(15 downto 0);
       Z : out STD_LOGIC;
       N : out STD_LOGIC;
       C : out STD_LOGIC;
       O : out STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal C : STD_LOGIC;
signal N : STD_LOGIC;
signal O : STD_LOGIC;
signal Z : STD_LOGIC;
signal ALUOp : STD_LOGIC_VECTOR(1 downto 0);
signal data_in1 : STD_LOGIC_VECTOR(15 downto 0);
signal data_in2 : STD_LOGIC_VECTOR(15 downto 0);
signal result : STD_LOGIC_VECTOR(15 downto 0);

begin

---- Processes ----

Process_1 :
process
-- Section above this comment may be overwritten according to
-- "Update sensitivity list automatically" option status
-- declarations
begin
	wait for 100ns;
	ALUOp <= "00";
	data_in1 <= "0111111111111111";
	data_in2 <= "0111111111111111";
	wait for 100ns;
	ALUOp <= "01";
	data_in1 <= "0000000000001100";
	data_in2 <= "0000000000001100";
	wait for  100ns;
	ALUOp <= "00";
	data_in1 <= "1000000000010000";
	data_in2 <= "1000000000000010";
	wait; 
	
-- statements
end process Process_1;


----  Component instantiations  ----

U1 : ALU
  port map(
       data_in1 => data_in1,
       data_in2 => data_in2,
       ALUOp => ALUOp,
       result => result,
       Z => Z,
       N => N,
       C => C,
       O => O
  );


end ALU_Test;
