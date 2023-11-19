library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_SIGNED.all;
use ieee.STD_LOGIC_TEXTIO.all;
library std;
use std.TEXTIO.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity cpu_tb is
end cpu_tb;

architecture TB_ARCHITECTURE of cpu_tb is
	-- Component declaration of the tested unit
	component cpu
	port(
		clk : in STD_LOGIC;
		StatusRegister : out STD_LOGIC_VECTOR(15 downto 0);
		PC : out STD_LOGIC_VECTOR(15 downto 0);
		ALUOutput : out STD_LOGIC_VECTOR(15 downto 0);
		DataMem : out STD_LOGIC_VECTOR(15 downto 0);
		AddressMem : out STD_LOGIC_VECTOR(15 downto 0);
		Reset : in STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal Reset : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal StatusRegister : STD_LOGIC_VECTOR(15 downto 0);
	signal PC : STD_LOGIC_VECTOR(15 downto 0);
	signal ALUOutput : STD_LOGIC_VECTOR(15 downto 0);
	signal DataMem : STD_LOGIC_VECTOR(15 downto 0);
	signal AddressMem : STD_LOGIC_VECTOR(15 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : cpu
		port map (
			clk => clk,
			StatusRegister => StatusRegister,
			PC => PC,
			ALUOutput => ALUOutput,
			DataMem => DataMem,
			AddressMem => AddressMem,
			Reset => Reset
		);

	-- Add your stimulus here ...
	

process

variable count : integer := 0;

begin
	
	if count = 34 then
		Reset <= '1';
	elsif count = 35 then
		Reset <= '0';
	
	end if;
	clk <= '0';
	count := count + 1;
	wait for 100ns;
	clk <= '1';	
	wait for 100ns;

	
end process ;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cpu of cpu_tb is
	for TB_ARCHITECTURE
		for UUT : cpu
			use entity work.cpu(cpu);
		end for;
	end for;
end TESTBENCH_FOR_cpu;

