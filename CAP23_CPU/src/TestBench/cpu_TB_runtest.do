SetActiveLib -work
comp -include "$dsn\compile\CPU.vhd" 
comp -include "$dsn\src\TestBench\cpu_TB.vhd" 
asim +access +r TESTBENCH_FOR_cpu 
wave 
wave -noreg clk
wave -noreg StatusRegister
wave -noreg PC
wave -noreg ALUOutput
wave -noreg DataMem
wave -noreg AddressMem
wave -noreg Reset
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\cpu_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_cpu 
