-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : CAP23_CPU
-- Author      : PARSA
-- Company     : IUST
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\compile\test.vhd
-- Generated   : Mon Jul  3 19:21:32 2023
-- From        : C:\Users\PARSA\Desktop\elmos\Subjects\CA\Project\CAP23\CAP23_CPU\src\test.bde
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

entity test is
  port(
       Input1 : in STD_LOGIC;
       Input2 : in STD_LOGIC;
       Output1 : out STD_LOGIC
  );
end test;

architecture test of test is

begin

----  Component instantiations  ----

Output1 <= not(Input2 or Input1);


end test;
