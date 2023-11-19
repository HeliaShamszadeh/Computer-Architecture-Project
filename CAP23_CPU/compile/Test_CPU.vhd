-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : CAP23_CPU
-- Author      : PARSA
-- Company     : IUST
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\New folder\CAP23\CAP23_CPU\compile\Test_CPU.vhd
-- Generated   : Mon Jul 10 19:12:31 2023
-- From        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\New folder\CAP23\CAP23_CPU\src\Test_CPU.bde
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

entity Test_CPU is 
end Test_CPU;

architecture Test_CPU of Test_CPU is

---- Component declarations -----

component CPU
  port(
       clk : in STD_LOGIC;
       StatusRegister : out STD_LOGIC_VECTOR(15 downto 0);
       PC : out STD_LOGIC_VECTOR(15 downto 0);
       ALUOutput : out STD_LOGIC_VECTOR(15 downto 0);
       DataMem : out STD_LOGIC_VECTOR(15 downto 0);
       AddressMem : out STD_LOGIC_VECTOR(15 downto 0);
       Reset : in STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal clk : STD_LOGIC;
signal Reset : STD_LOGIC;
signal AddressMem : STD_LOGIC_VECTOR(15 downto 0);
signal ALUOutput : STD_LOGIC_VECTOR(15 downto 0);
signal DataMem : STD_LOGIC_VECTOR(15 downto 0);
signal PC : STD_LOGIC_VECTOR(15 downto 0);
signal StatusRegister : STD_LOGIC_VECTOR(15 downto 0);

begin

---- Processes ----

Process_1 :
process
-- Section above this comment may be overwritten according to
-- "Update sensitivity list automatically" option status
-- declarations

variable count : integer := 0;

begin
	
	if count = 34 then
		reset <= '1';
	elsif count = 35 then
		reset <= '0';
	
	end if;
	clk <= '0';
	count := count + 1;
	wait for 100ns;
	clk <= '1';	
	wait for 100ns;

	
-- statements
end process Process_1;







----  Component instantiations  ----

U1 : CPU
  port map(
       clk => clk,
       StatusRegister => StatusRegister,
       PC => PC,
       ALUOutput => ALUOutput,
       DataMem => DataMem,
       AddressMem => AddressMem,
       Reset => Reset
  );


end Test_CPU;
