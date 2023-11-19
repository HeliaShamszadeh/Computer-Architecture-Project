library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory_3KB is
	port (
		Address     : in  std_logic_vector(15 downto 0);
		WriteData  : in  std_logic_vector(15 downto 0);
		MemWrite: in  std_logic;
		MemRead : in std_logic;
		reset   : in std_logic;
		ReadData : out std_logic_vector(15 downto 0)
		);
end entity Memory_3KB;


architecture Memory_Arch of Memory_3KB is										 
	type memory_array is array (0 to 3072) of std_logic_vector(7 downto 0);
	signal memory: memory_array := (others => (others => '0'));
	
begin
	process(Address, WriteData, MemWrite, MemRead, reset)
	begin
		if reset = '1' then
			memory <= (others => (others => '0'));
		else	
			if MemWrite = '1' then
				memory(to_integer(unsigned(Address))) <= WriteData(15 downto 8);
				memory(to_integer(unsigned(Address)) + 1) <= WriteData(7 downto 0);
			elsif MemRead = '1' then
				ReadData(15 downto 8) <= memory(to_integer(unsigned(Address)));
				ReadData(7 downto 0) <= memory(to_integer(unsigned(Address)) + 1);
			end if;
		end if;
	end process;
	
end architecture Memory_Arch;




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Memory_1KB is
	port (
		clk      : in  std_logic;
		Address  : in  std_logic_vector(15 downto 0); -- Should not exceed 4KB
		WriteData: in  std_logic_vector(15 downto 0);
		MemWrite : in  std_logic;
		MemRead  : in std_logic;
		reset    : in std_logic;
		ReadData : out std_logic_vector(15 downto 0)
		);
end entity Memory_1KB;


architecture Memory_1KB_Arch of Memory_1KB is
	type memory_array is array (0 to 1024) of std_logic_vector(7 downto 0);
	signal memory: memory_array := (others => (others => '0'));
	
begin

	process(clk)
	begin
		if rising_edge(clk) and reset = '1' then
			memory <= (others => (others => '0'));
		else
			if not rising_edge(clk) and MemWrite = '1' then 
				memory(to_integer(unsigned(Address))) <= WriteData(15 downto 8);
				memory(to_integer(unsigned(Address)) + 1) <= WriteData(7 downto 0);
				report "Data Writen";
				report integer'image(to_integer(signed(Address)));
				report integer'image(to_integer(unsigned(WriteData)));
			elsif rising_edge(clk) and MemRead = '1' then
				report "DataRead";
				ReadData(15 downto 8) <= memory(to_integer(unsigned(Address)));
				ReadData(7 downto 0)  <= memory(to_integer(unsigned(Address)) + 1);
			end if;
		end if;
	end process;	
		
end architecture Memory_1KB_Arch;




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Register_File is
	port (
		read_reg1  : in std_logic_vector(3 downto 0);
		read_reg2  : in std_logic_vector(3 downto 0);
		reg_write  : in std_logic;
		write_reg  : in std_logic_vector(3 downto 0);
		write_data : in std_logic_vector(15 downto 0);
		st_in	   : in std_logic_vector(15 downto 0);
		reset      : in std_logic;
		read_data1 : out std_logic_vector(15 downto 0);
		read_data2 : out std_logic_vector(15 downto 0);
		st_out     : out std_logic_vector(15 downto 0);
		zero       : out std_logic
		);
end Register_File;




architecture Register_File_Arch of Register_File is
	
	type register_file_array is array(11 downto 0) of std_logic_vector(15 downto 0);
	signal register_file : register_file_array := (others => (others => '0'));	
	
begin
	
	
	register_file(to_integer(unsigned(write_reg))) <= write_data when reg_write = '1' and write_reg /= "0000" and to_integer(unsigned(write_reg)) <= 11 else register_file(to_integer(unsigned(write_reg)));
	read_data1 <= register_file(to_integer(unsigned(read_reg1))) when to_integer(unsigned(read_reg1)) <= 11;
	read_data2 <= register_file(to_integer(unsigned(read_reg2))) when to_integer(unsigned(read_reg2)) <= 11;
		
		
	st_out(15 downto 12) <= write_data(15 downto 12) when write_reg = "1001" else st_in(15 downto 12);
	st_out(11 downto 0) <= "000000000000";
	zero <= write_data(15) when write_reg = "1001" else st_in(15);
		
end Register_File_Arch;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ALU is
	port (
		data_in1 : in std_logic_vector(15 downto 0);
		data_in2 : in std_logic_vector(15 downto 0);
		ALUOp    : in std_logic_vector(1 downto 0);
		result   : out std_logic_vector(15 downto 0);
		status   : out std_logic_vector(15 downto 0)
		);
end ALU;


architecture ALU_Arch of ALU is
	
	signal temp : std_logic_vector(15 downto 0); 
	signal Z : std_logic;
	signal C : std_logic;
	signal O : std_logic;
	signal N : std_logic;
	
	
begin
	
	temp <= std_logic_vector(signed(data_in1) + signed(data_in2)) when ALUOp = "00" else
	std_logic_vector(signed(data_in1) - signed(data_in2)) when ALUOp = "01" else
	data_in1 and data_in2 when ALUOp = "10" else
	std_logic_vector(unsigned(data_in1) sll to_integer(signed(data_in2))) when ALUOp = "11" else
		"0000000000000000";
	
	Z <= '1' when temp = "0000000000000000" else	'0';
	O <= '1' when (ALUOp = "00" and 
	((data_in1(15) = '0' and data_in2(15) = '0' and temp(15) = '1')
	or (data_in1(15) = '1' and data_in2(15) = '1' and temp(15) = '0')))
	or (ALUOp = "01" and
	((data_in1(15) = '0' and data_in2(15) = '1' and temp(15) = '1')
	or (data_in1(15) = '1' and data_in2(15) = '0' and temp(15) = '0'))) else '0';
		
	N <= '1' when temp(15) = '1' else '0';

	C <= '1' when (ALUOp = "00" and (data_in1(15) = '1' and data_in2(15) = '1' and temp(15) = '0'))
	or (ALUOp = "01" and (data_in1(15) = '1' and data_in2(15) = '0') and temp(15) = '0') else '0';
	result <= temp;
	status(15) <= Z;
	status(14) <= N;
	status(13) <= C;
	status(12) <= O;
	status(11 downto 0) <= "000000000000";
	
	
end ALU_Arch;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity PC_Reg is
	port (
		PCWrite  : in std_logic;
		PCWrite2 : in std_logic;
		data_in  : in std_logic_vector(15 downto 0);
		reset    : in std_logic;
		data_out : out std_logic_vector(15 downto 0)
		
		);
end PC_Reg;


architecture PC_Reg_Arch of PC_Reg is
	
	signal pc_reg : std_logic_vector(15 downto 0) := "0000000000000000";
	
	
begin
	
	process(PCWrite, data_in, reset)
		
	begin
	
		if PCWrite = '1' and PCWrite2 /= '0' then
			pc_reg <= data_in;
			data_out <= data_in;
		else
			data_out <= pc_reg;
		end if;
		
		if reset = '1' then
			pc_reg <= "0000000000000000";
			data_out <= "0000000000000000";
		end if;
			
		
	end process;
		
end PC_Reg_Arch;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Adder is
	port (
		data_in1 : in std_logic_vector(15 downto 0);
		data_in2 : in std_logic_vector(15 downto 0);
		result   : out std_logic_vector(15 downto 0) 
		);
end Adder;



architecture Adder_Arch of Adder is
begin
	
	result <= std_logic_vector(signed(data_in1) + signed(data_in2));
	
end Adder_Arch;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity AdderEnable is
	port (
		data_in1 : in std_logic_vector(15 downto 0);
		data_in2 : in std_logic_vector(15 downto 0);
		enable   : in std_logic;
		result   : out std_logic_vector(15 downto 0) 
		);
end AdderEnable;



architecture AdderEnable_Arch of AdderEnable is
begin
	
	result <= std_logic_vector(signed(data_in1) + signed(data_in2)) when enable = '1' else data_in1;
	
end AdderEnable_Arch;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Mux_2_1 is
	port (
		data_in1 : in std_logic_vector(15 downto 0);
		data_in2 : in std_logic_vector(15 downto 0);
		data_out : out std_logic_vector(15 downto 0);
		select_bit : in std_logic
		);
end Mux_2_1;


architecture Mux_2_1_Arch of Mux_2_1 is
begin
	
	data_out <= data_in1 when select_bit = '0' else data_in2;
	
	
end Mux_2_1_Arch;


library ieee;
use ieee.std_logic_1164.all;
entity Mux_2_4bit is
	port (
		data_in1 : in std_logic_vector(3 downto 0);
		data_in2 : in std_logic_vector(3 downto 0);
		data_out : out std_logic_vector(3 downto 0);
		select_bit : in std_logic
		);
end Mux_2_4bit;



architecture Mux_2_4bit_Arch of Mux_2_4bit is
begin
	
	data_out <= data_in1 when select_bit = '0' else data_in2;
	
end Mux_2_4bit_Arch;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Mux_3_1 is
	port (
		data_in1    : in std_logic_vector(15 downto 0);
		data_in2    : in std_logic_vector(15 downto 0);
		data_in3    : in std_logic_vector(15 downto 0);
		data_out    : out std_logic_vector(15 downto 0);
		select_bits : in std_logic_vector(1 downto 0)
		);
end Mux_3_1;


architecture Mux_3_1_Arch of Mux_3_1 is
begin

data_out <= data_in1 when select_bits = "00" else
data_in2 when select_bits = "01" else
data_in3 when select_bits = "10" else "XXXXXXXXXXXXXXXX";


end Mux_3_1_Arch;



library ieee;
use ieee.std_logic_1164.all;

entity IF_ID_Reg is
	port ( 
	clk : in std_logic;
	reg_write : in std_logic;
	flush : in std_logic;
	op_in : in std_logic_vector(3 downto 0);
	rd_in : in std_logic_vector(3 downto 0);
	rs_in : in std_logic_vector(3 downto 0);
	immediate_in : in std_logic_vector(7 downto 0);
	address_in : in std_logic_vector(11 downto 0);
	incremented_pc_in : in std_logic_vector(15 downto 0);
	op_out : out std_logic_vector(3 downto 0);
	rd_out : out std_logic_vector(3 downto 0);
	rs_out : out std_logic_vector(3 downto 0);
	immediate_out : out std_logic_vector(7 downto 0);
	address_out : out std_logic_vector(11 downto 0);
	incremented_pc_out : out std_logic_vector(15 downto 0);
	reset              : in std_logic
	
		);
end IF_ID_Reg;


architecture IF_ID_Reg_Arch of IF_ID_Reg is

signal op : std_logic_vector(3 downto 0);
signal rd : std_logic_vector(3 downto 0);
signal rs : std_logic_vector(3 downto 0);
signal immediate : std_logic_vector(7 downto 0);
signal address : std_logic_vector(11 downto 0);
signal incremented_pc : std_logic_vector(15 downto 0) := "0000000000000000";



begin
	
	process(clk) 
		
	begin
		
		if rising_edge(clk) and reset = '1' then
			op <= "0000";
			rd <= "0000";
			rs <= "0000";
			immediate <= "00000000";
			address <= "000000000000";
			incremented_pc <= "0000000000000000";
			op_out <= "0000";
			rd_out <= "0000";
			rs_out <= "0000";
			immediate_out <= "00000000";
			address_out <= "000000000000";
			incremented_pc_out <= "0000000000000000";
		else 
			if rising_edge(clk) then
				op_out <= op;
				rd_out <= rd;
				rs_out <= rs;
				immediate_out <= immediate;
				address_out <= address;
				incremented_pc_out <= incremented_pc;
			elsif not rising_edge(clk) and flush = '1' then
				op <= "0000";
				rd <= "0000";
				rs <= "0000";
				immediate <= "00000000";
				address <= "000000000000";
				incremented_pc <= incremented_pc_in;
			elsif not rising_edge(clk) and reg_write = '1' then
				op <= op_in;
				rd <= rd_in;
				rs <= rs_in;
				immediate <= immediate_in;
				address <= address_in;
				incremented_pc <= incremented_pc_in;
			end if;
		end if;
	end process;	
	
	
end IF_ID_Reg_Arch;

library ieee;
use ieee.std_logic_1164.all;

entity ID_EXE_Reg is
	port ( 
	clk         : in std_logic;
	MemtoReg_in : in std_logic_vector(1 downto 0);
	RegWrite_in : in std_logic;
	MemRead_in  : in std_logic;
	MemWrite_in : in std_logic; 
	ALUSrc1_in  : in std_logic;
	ALUSrc2_in  : in std_logic;
	ALUOp_in    : in std_logic_vector(1 downto 0);
	rs_in       : in std_logic_vector(3 downto 0);
	rd_in       : in std_logic_vector(3 downto 0);
	data1_in       : in std_logic_vector(15 downto 0);
	data2_in       : in std_logic_vector(15 downto 0);
	sign_extend_in : in std_logic_vector(15 downto 0);
	CZero          : in std_logic;
	reset          : in std_logic;
	MemtoReg_out : out std_logic_vector(1 downto 0);
	RegWrite_out : out std_logic;
	MemRead_out  : out std_logic;
	MemWrite_out : out std_logic; 
	ALUSrc1_out  : out std_logic;
	ALUSrc2_out  : out std_logic;
	ALUOp_out    : out std_logic_vector(1 downto 0);
	rs_out       : out std_logic_vector(3 downto 0);
	rd_out       : out std_logic_vector(3 downto 0);
	data1_out       : out std_logic_vector(15 downto 0);
	data2_out       : out std_logic_vector(15 downto 0);
	sign_extend_out : out std_logic_vector(15 downto 0)
		);
end ID_EXE_Reg;

architecture ID_EXE_Reg_Arch of ID_EXE_Reg is
	signal MemtoReg : std_logic_vector(1 downto 0);
	signal RegWrite : std_logic;
	signal MemRead  : std_logic;
	signal MemWrite : std_logic; 
	signal ALUSrc1  : std_logic;
	signal ALUSrc2  : std_logic;
	signal ALUOp    : std_logic_vector(1 downto 0);
	signal rs       : std_logic_vector(3 downto 0);
	signal rd       : std_logic_vector(3 downto 0);
	signal data1       : std_logic_vector(15 downto 0);
	signal data2       : std_logic_vector(15 downto 0);
	signal sign_extend : std_logic_vector(15 downto 0);
begin
	process(clk) 
	begin
	if rising_edge(clk) and reset = '1' then
		MemtoReg_out <= "00";
		RegWrite_out <= '0';
		MemRead_out  <= '0';
		MemWrite_out <= '0'; 
		ALUSrc1_out  <= '0';
		ALUSrc2_out  <= '0';
		ALUOp_out    <= "00";
		rs_out       <= "0000";
		rd_out       <= "0000";
		data1_out       <= "0000000000000000";
		data2_out       <= "0000000000000000";
		sign_extend_out <= "0000000000000000";
		
		MemtoReg <= "00";
		RegWrite <= '0';
		MemRead  <= '0';
		MemWrite <= '0'; 
		ALUSrc1  <= '0';
		ALUSrc2  <= '0';
		ALUOp    <= "00";
		rs       <= "0000";
		rd       <= "0000";
		data1       <= "0000000000000000";
		data2       <= "0000000000000000";
		sign_extend <= "0000000000000000";
	else
		if rising_edge(clk) then 
			MemtoReg_out <= MemtoReg;
			RegWrite_out <= RegWrite;
			MemRead_out  <= MemRead;
			MemWrite_out <= MemWrite; 
			ALUSrc1_out  <= ALUSrc1;
			ALUSrc2_out  <= ALUSrc2;
			ALUOp_out    <= ALUOp;
			rs_out       <= rs;
			rd_out       <= rd;
			data1_out       <= data1;
			data2_out       <= data2;
			sign_extend_out <= sign_extend;
		elsif not rising_edge(clk) then
			MemtoReg <= MemtoReg_in;
	 		ALUSrc1  <= ALUSrc1_in;
			ALUSrc2  <= ALUSrc2_in;
			ALUOp    <= ALUOp_in;
			rs       <= rs_in;
			rd       <= rd_in;
			data1       <= data1_in;
			data2       <= data2_in;
			sign_extend <= sign_extend_in;
			if CZero = '1' then
				MemRead  <= '0';	
				MemWrite <= '0';
				RegWrite <= '0';
			else
				MemRead  <= MemRead_in;	
				MemWrite <= MemWrite_in;
				RegWrite <= RegWrite_in;
			end if;
		end if;
	end if;
	end process;
end ID_EXE_Reg_Arch;   

library ieee;
use ieee.std_logic_1164.all;

entity EXE_MEM_Reg is
	port (
	clk         : in std_logic;
	RegWrite_in : in std_logic;
	MemtoReg_in : in std_logic_vector(1 downto 0);
	MemRead_in  : in std_logic;
	MemWrite_in : in std_logic;
	ALUResult_in: in std_logic_vector(15 downto 0);
	rd_val_in   : in std_logic_vector(15 downto 0);
	rd_in       : in std_logic_vector(3 downto 0); 
	reset       : in std_logic;
	RegWrite_out : out std_logic;
	MemtoReg_out : out std_logic_vector(1 downto 0);
	MemRead_out  : out std_logic;
	MemWrite_out : out std_logic;
	ALUResult_out: out std_logic_vector(15 downto 0);
	rd_val_out   : out std_logic_vector(15 downto 0);
	rd_out       : out std_logic_vector(3 downto 0)
		);
end EXE_MEM_Reg;  

architecture EXE_MEM_Reg_Arch of EXE_MEM_Reg is	
signal RegWrite : std_logic;
signal MemtoReg : std_logic_vector(1 downto 0);
signal MemRead  : std_logic;
signal MemWrite : std_logic;
signal ALUResult: std_logic_vector(15 downto 0);
signal rd_val   : std_logic_vector(15 downto 0);
signal rd       : std_logic_vector(3 downto 0);
begin
	process(clk)
	begin
		if rising_edge(clk) and reset = '1' then
		     RegWrite_out <= '0';
			 MemtoReg_out <= "00";
			 MemRead_out  <= '0';
			 MemWrite_out <= '0';
			 ALUResult_out<= "0000000000000000";
			 rd_val_out   <= "0000000000000000";
			 rd_out       <= "0000";
			 
			 RegWrite <= '0';
			 MemtoReg <= "00";
			 MemRead  <= '0';
			 MemWrite <= '0';
			 ALUResult<= "0000000000000000";
			 rd_val   <= "0000000000000000";
			 rd       <= "0000";
		else
			if rising_edge(clk)	then
				 RegWrite_out <= RegWrite;
				 MemtoReg_out <= MemtoReg;
				 MemRead_out  <= MemRead;
				 MemWrite_out <= MemWrite;
				 ALUResult_out<= ALUResult;
				 rd_val_out   <= rd_val;
				 rd_out       <= rd;
				
			elsif not rising_edge(clk) then
				RegWrite <= RegWrite_in;
				MemtoReg <= MemtoReg_in;
				MemRead <= MemRead_in; 
				MemWrite <= MemWrite_in;
				ALUResult <= ALUResult_in;
				rd_val  <= rd_val_in; 
				rd  <= rd_in;
				
			end if;
		end if;
	end process;
end EXE_MEM_Reg_Arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity MEM_WB_Reg is
	port (
	clk          : in std_logic;
	RegWrite_in  : in std_logic;
	MemtoReg_in  : in std_logic_vector(1 downto 0);
	ALUResult_in : in std_logic_vector(15 downto 0);
	MemResult_in : in std_logic_vector(15 downto 0);
	rd_in        : in std_logic_vector(3 downto 0);
	AdderResult_in  : in std_logic_vector(15 downto 0);
	reset        : in std_logic;
	RegWrite_out : out std_logic;
	MemtoReg_out : out std_logic_vector(1 downto 0);
	ALUResult_out: out std_logic_vector(15 downto 0);
	MemResult_out: out std_logic_vector(15 downto 0);
	rd_out       : out std_logic_vector(3 downto 0);
	AdderResult_out : out std_logic_vector(15 downto 0)
		);
end MEM_WB_Reg;


architecture MEM_WB_Reg_Arch of MEM_WB_Reg is
signal RegWrite : std_logic;
signal MemtoReg : std_logic_vector(1 downto 0);
signal ALUResult: std_logic_vector(15 downto 0);
signal rd       : std_logic_vector(3 downto 0);
signal AdderResult : std_logic_vector(15 downto 0);	
signal MemResult   : std_logic_vector(15 downto 0);
begin
	process(clk)
	begin
		if rising_edge(clk) and reset = '1' then
			RegWrite_out <= '0'; 
			MemtoReg_out <= "00";
			ALUResult_out<= "0000000000000000";
			rd_out       <= "0000";
			AdderResult_out <= "0000000000000000";
			MemResult_out   <= "0000000000000000";
			
			RegWrite <= '0'; 
			MemtoReg <= "00";
			ALUResult<= "0000000000000000";
			rd       <= "0000";
			AdderResult <= "0000000000000000";
			MemResult   <= "0000000000000000";
		else
			if rising_edge(clk)	then
				 RegWrite_out <= RegWrite;
				 MemtoReg_out <= MemtoReg;
				 ALUResult_out<= ALUResult;
				 rd_out       <= rd;
				 AdderResult_out <= AdderResult;
				 MemResult_out   <= MemResult;
				
			elsif not rising_edge(clk) then
				RegWrite <= RegWrite_in;
				MemtoReg <= MemtoReg_in;
				ALUResult <= ALUResult_in; 
				rd  <= rd_in;
				AdderResult <= AdderResult_in;
				MemResult <= MemResult_in;
			end if;
		end if;
		
	end process;
	
end MEM_WB_Reg_Arch;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Sign_Extension_8 is
	port (
	data_in : in std_logic_vector(7 downto 0);
	data_out : out std_logic_vector(15 downto 0)
		);
end Sign_Extension_8;



architecture Sign_Extension_8_Arch of Sign_Extension_8 is
begin

	data_out(15 downto 8) <= (others => data_in(7));
	data_out(7 downto 0) <= data_in; 
								 	
end Sign_Extension_8_Arch;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Sign_Extension_12 is
	port (
	data_in : in std_logic_vector(11 downto 0);
	data_out : out std_logic_vector(15 downto 0)
		);
end Sign_Extension_12;



architecture Sign_Extension_12_Arch of Sign_Extension_12 is
begin

	data_out(15 downto 12) <= (others => data_in(11));
	data_out(11 downto 0) <= data_in;
	
end Sign_Extension_12_Arch;

library ieee;
use ieee.std_logic_1164.all;

entity Controller is
	port (
	OpCode : in std_logic_vector(3 downto 0);
	ReadReg1 : out std_logic;
	ReadReg2 : out std_logic;
	RegWrite : out std_logic;
	ALUSrc1 : out std_logic;
	ALUSrc2 : out std_logic;
	ALUOp   : out std_logic_vector(1 downto 0);
	MemRead : out std_logic;
	MemWrite : out std_logic;	 
	MemtoReg : out std_logic_vector(1 downto 0);
	Branch  : out std_logic;
	Jump    : out std_logic
		);
end Controller;	


architecture Controller_Arch of Controller is
begin 
	process(OpCode)
	begin
		if OpCode = "0000" then	-- add  
			ReadReg1 <= '0';
			ReadReg2 <= '0';
			RegWrite <= '1';
			ALUSrc1 <= '0';
			ALUSrc2 <= '0';
			ALUOp   <= "00";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "00";
			Branch  <= '0';
			Jump    <= '0';
		elsif OpCode = "0001" then	  -- add mem
			ReadReg1 <= '1';
			ReadReg2 <= '1';
			RegWrite <= '1';
			ALUSrc1 <= '0';
			ALUSrc2 <= '1';
			ALUOp   <= "00";
			MemRead <= '1';
			MemWrite <= '0';	 
			MemtoReg <= "10";
			Branch  <= '0';
			Jump    <= '0';
		elsif OpCode = "0010" then	  -- sub
			ReadReg1 <= '0';
			ReadReg2 <= '0';
			RegWrite <= '1';
			ALUSrc1 <= '0';
			ALUSrc2 <= '0';
			ALUOp   <= "01";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "00";
			Branch  <= '0';
			Jump    <= '0';
		elsif OpCode = "0011" then	  -- add imm
			ReadReg1 <= '0';
			ReadReg2 <= '-';
			RegWrite <= '1';
			ALUSrc1 <= '0';
			ALUSrc2 <= '1';
			ALUOp   <= "00";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "00";
			Branch  <= '0';
			Jump    <= '0';	
		elsif OpCode = "0101" then	  -- and
			ReadReg1 <= '0';
			ReadReg2 <= '0';
			RegWrite <= '1';
			ALUSrc1 <= '0';
			ALUSrc2 <= '0';
			ALUOp   <= "10";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "00";
			Branch  <= '0';
			Jump    <= '0';	
		elsif OpCode = "0110" then	  -- sll
			ReadReg1 <= '0';
			ReadReg2 <= '-';
			RegWrite <= '1';
			ALUSrc1 <= '0';
			ALUSrc2 <= '1';
			ALUOp   <= "11";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "00";
			Branch  <= '0';
			Jump    <= '0';
		elsif OpCode = "0111" then	  --lw
			ReadReg1 <= '1';
			ReadReg2 <= '-';
			RegWrite <= '1';
			ALUSrc1 <= '0';
			ALUSrc2 <= '1';
			ALUOp   <= "00";
			MemRead <= '1';
			MemWrite <= '0';	 
			MemtoReg <= "01";
			Branch  <= '0';
			Jump    <= '0';
		elsif OpCode = "1001" then	  -- sw
			ReadReg1 <= '1';
			ReadReg2 <= '-';
			RegWrite <= '0';
			ALUSrc1 <= '0';
			ALUSrc2 <= '1';
			ALUOp   <= "00";
			MemRead <= '0';
			MemWrite <= '1';	 
			MemtoReg <= "--";
			Branch  <= '0';
			Jump    <= '0';
		elsif OpCode = "1011" then	   -- clr reg
			ReadReg1 <= '-';
			ReadReg2 <= '-';
			RegWrite <= '1';
			ALUSrc1 <= '1';
			ALUSrc2 <= '1';
			ALUOp   <= "00";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "00";
			Branch  <= '0';
			Jump    <= '0';	
		elsif OpCode = "1000" then	  -- clr mem
			ReadReg1 <= '0';
			ReadReg2 <= '0';
			RegWrite <= '0';
			ALUSrc1 <= '0';
			ALUSrc2 <= '1';
			ALUOp   <= "00";
			MemRead <= '0';
			MemWrite <= '1';	 
			MemtoReg <= "--";
			Branch  <= '0';
			Jump    <= '0';
		elsif OpCode = "1100" then	 -- move 
			ReadReg1 <= '-';
			ReadReg2 <= '-';
			RegWrite <= '1';
			ALUSrc1 <= '1';
			ALUSrc2 <= '1';
			ALUOp   <= "00";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "00";
			Branch  <= '0';
			Jump    <= '0';
		elsif OpCode = "1101" then	 -- cmp 
			ReadReg1 <= '0';
			ReadReg2 <= '0';
			RegWrite <= '0';
			ALUSrc1 <= '0';
			ALUSrc2 <= '0';
			ALUOp   <= "01";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "--";
			Branch  <= '0';
			Jump    <= '0';
		elsif OpCode = "1110" then	 -- branch 
			ReadReg1 <= '-';
			ReadReg2 <= '-';
			RegWrite <= '0';
			ALUSrc1 <= '-';
			ALUSrc2 <= '-';
			ALUOp   <= "--";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "--";
			Branch  <= '1';
			Jump    <= '0';
		elsif OpCode = "1111" then	 -- jump  
			ReadReg1 <= '-';
			ReadReg2 <= '-';
			RegWrite <= '0';
			ALUSrc1 <= '-';
			ALUSrc2 <= '-';
			ALUOp   <= "--";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "--";
			Branch  <= '0';
			Jump    <= '1';
		else
			ReadReg1 <= '-';
			ReadReg2 <= '-';
			RegWrite <= '0';
			ALUSrc1 <= '-';
			ALUSrc2 <= '-';
			ALUOp   <= "--";
			MemRead <= '0';
			MemWrite <= '0';	 
			MemtoReg <= "--";
			Branch  <= '0';
			Jump    <= '0';
		end if;
	end process;
end Controller_Arch; 


library ieee;
use ieee.std_logic_1164.all;


entity ForwardingUnit is
	port (
	MemWrite : in std_logic;
	MemRead  : in std_logic;
	RegWrite_EXE : in std_logic;
	RegWrite_MEM : in std_logic;
	rd_ID    : in std_logic_vector(3 downto 0);
	rs_ID    : in std_logic_vector(3 downto 0);
	rd_EXE   : in std_logic_vector(3 downto 0);
	rd_MEM   : in std_logic_vector(3 downto 0);
	ForwardA : out std_logic_vector(1 downto 0);
	ForwardB : out std_logic_vector(1 downto 0);
	ForwardC : out std_logic_vector(1 downto 0)
		);
end ForwardingUnit;

architecture ForwardingUnit_Arch of ForwardingUnit is
begin
	process(MemWrite, MemRead, RegWrite_EXE, RegWrite_MEM, rd_ID, rs_ID, rd_EXE, rd_MEM)
	begin		  
		if MemRead = '1' or MemWrite = '1' then	 -- ForwardA
			if rd_EXE = "1010" then
				ForwardA <= "10";	 
			elsif rd_MEM = "1010" then
				ForwardA <= "01";
			else
				ForwardA <= "00";
			end if;
		elsif RegWrite_EXE = '1' and rd_ID = rd_EXE then
			ForwardA <= "10";
		elsif RegWrite_MEM = '1' and rd_ID = rd_MEM then
			ForwardA <= "01";
		else
			ForwardA <= "00";
		end if;
		
		if RegWrite_EXE = '1' and rs_ID = rd_EXE then  -- ForwardB
			ForwardB <= "10";
		elsif RegWrite_MEM = '1' and rs_ID = rd_MEM then
			ForwardB <= "01";
		else
			ForwardB <= "00";
		end if;
		
		if (MemWrite = '1' or MemRead = '1') and (rd_ID = rd_EXE) then  -- ForwardC
			ForwardC <= "10";
		elsif (MemWrite = '1' or MemRead = '1') and (rd_ID = rd_MEM) then	 
			ForwardC <= "01";
		else
			ForwardC <= "00";
		end if;
			
	end process;
end ForwardingUnit_Arch;



library ieee;
use ieee.std_logic_1164.all;
entity HazardDetectionUnit is
	port (
	EXE_MemRead : in std_logic;
	ALUSrc2     : in std_logic;
	EXE_rd      : in std_logic_vector(3 downto 0);
	ID_rd       : in std_logic_vector(3 downto 0);
	ID_rs       : in std_logic_vector(3 downto 0);
	Hazard      : out std_logic
		);
end HazardDetectionUnit;


architecture HazardDetectionUnit_Arch of HazardDetectionUnit is
begin
	
	process(EXE_MemRead, ALUSrc2, EXE_rd, Id_rd, ID_rs) 
		
	begin
		
		if EXE_MemRead = '1' and ALUSrc2 = '0' and (EXE_rd = ID_rd or EXE_rd = ID_rs) then
			Hazard <= '1';
		elsif EXE_MemRead = '1' and ALUSrc2 = '1' and EXE_rd = ID_rd then
			Hazard <= '1';
		else
			Hazard <= '0';
		end if;
	
	end process;	
	
	
end HazardDetectionUnit_Arch;

















