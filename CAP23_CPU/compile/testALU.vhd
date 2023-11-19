-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : CAP23_CPU
-- Author      : PARSA
-- Company     : IUST
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\compile\testALU.vhd
-- Generated   : Tue Jul  4 10:54:31 2023
-- From        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\src\testALU.bde
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

entity testALU is 
end testALU;

architecture testALU of testALU is

---- Component declarations -----

component Sign_Extension_12
  port(
       data_in : in STD_LOGIC_VECTOR(11 downto 0);
       data_out : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal data_in : STD_LOGIC_VECTOR(11 downto 0);
signal data_out : STD_LOGIC_VECTOR(15 downto 0);

begin

---- Processes ----

Process_1 :
process
-- Section above this comment may be overwritten according to
-- "Update sensitivity list automatically" option status
-- declarations
begin
	
	data_in <= "1011000100000010";
	wait;

-- statements
end process Process_1;


----  Component instantiations  ----

U4 : Sign_Extension_12
  port map(
       data_in => data_in,
       data_out => data_out
  );


end testALU;
