-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : CAP23_CPU
-- Author      : PARSA
-- Company     : IUST
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\compile\CPU_Test.vhd
-- Generated   : Fri Jul  7 17:24:27 2023
-- From        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\src\CPU_Test.bde
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

entity CPU_Test is 
end CPU_Test;

architecture CPU_Test of CPU_Test is

---- Component declarations -----

component CPU
  port(
       clk : in STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal clk : STD_LOGIC;

begin

---- Processes ----

Process_1 :
process
-- Section above this comment may be overwritten according to
-- "Update sensitivity list automatically" option status
-- declarations
begin
	
	clk <= '0';
	wait for 100ns;
	clk <= '1';
	wait for 100ns;
--	clk <= '0';
--	wait for 100ns;
--	clk <= '1';
--	wait for 100ns;
--	clk <= '0';
--	wait for 100ns;
--	clk <= '1';
--	wait for 100ns;
--	clk <= '0';
--	wait for 100ns;
--	clk <= '1';
--	wait;
	
-- statements
end process Process_1;



----  Component instantiations  ----

U1 : CPU
  port map(
       clk => clk
  );


end CPU_Test;
