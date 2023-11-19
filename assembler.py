import sys;
import re;


def decimal_to_binary_twos_complement(decimal_num, num_bits):
    binary_num = bin(decimal_num & int("1" * num_bits, 2))[2:].zfill(num_bits)

    return binary_num


register_num = {"Zero" : "0000", 
                "d0" : "0001", "d1" : "0010", "d2" : "0011", "d3" : "0100", 
                "a0" : "0101", "a1" : "0110", "a2" : "0111", "a3" : "1000", 
                "SR" : "1001", 
                "BA" : "1010", 
                "PC" : "1011"}

opCodes = {"Add" : "0000", "Add2" : "0001", "Sub" : "0010", "Addi" : "0011", 
           "And" : "0101", "Sll" : "0110", "Lw" : "0111", "Sw" : "1001", 
           "CLR" : "1011", "CLM" : "1000", "Mov" : "1100", "CMP" : "1101", 
           "Bne" : "1110", "Jmp" : "1111"}


with open(sys.argv[1], "r") as f:
    lines = f.readlines()

    machineCodes = []

    error = False

    for i in range(0, len(lines)):
        
        try:
            
            line = lines[i]
            if line.split()[0] in ["Add", "Lw", "Sw"] and bool(re.match("-?\d+", line.split()[-1])):
                instruction = line.split()[0]
                argument1 = line.split()[1].replace(",", "")
                argument2 = int(line.split()[2]) * 2
                if (argument2 < -128 or argument2 > 127):
                    raise ValueError("Immediate field must be an integer number from -64 to 63")

                if (instruction == "Add"):
                    machineCode = opCodes["Add2"] + register_num[argument1] + str(decimal_to_binary_twos_complement(argument2, 8))
                    machineCodes.append(machineCode)
                else:
                    machineCode = opCodes[instruction] + register_num[argument1] + str(decimal_to_binary_twos_complement(argument2, 8))
                    machineCodes.append(machineCode)

            elif line.split()[0] in ["Add", "Sub", "And", "CMP"] :
                instruction = line.split()[0]
                argument1 = line.split()[1].replace(",", "")
                argument2 = line.split()[2]
                machineCode = opCodes[instruction] + register_num[argument1] + register_num[argument2] + "0000"
                machineCodes.append(machineCode)

            elif line.split()[0] in ["Addi", "Mov", "Sll"] and bool(re.match("-?\d+", line.split()[-1])):
                instruction = line.split()[0]
                argument1 = line.split()[1].replace(",", "")
                argument2 = int(line.split()[2])
                if (argument2 < -128 or argument2 > 127):
                    raise ValueError("Immediate field must be an integer number from -128 to 127")
                machineCode = opCodes[instruction] + register_num[argument1] + str(decimal_to_binary_twos_complement(argument2, 8))
                machineCodes.append(machineCode)

            elif line.split()[0] in ["Jmp", "Bne"]:
                instruction = line.split()[0]
                if instruction == "Bne":
                    argument1 = int(line.split()[1]) * 2 - 2
                    if (argument1 < -2048 or argument1 > 2047):
                        raise ValueError("Immediate field must be an integer number from -1023 to 1024") 
                else:
                    argument1 = int(line.split()[1]) * 2
                    if (argument1 < -2048 or argument1 > 2047):
                        raise ValueError("Immediate field must be an integer number from -1024 to 1023")

                machineCode = opCodes[instruction] + str(decimal_to_binary_twos_complement(argument1, 12))
                machineCodes.append(machineCode)

            elif line.split()[0] in ["CLR", "CLM,"]:

                instruction = line.split()[0]
                argument1 = line.split()[1]
                machineCode = opCodes[instruction] + register_num[argument1] + "00000000"
                machineCodes.append(machineCode)

            else:
                raise SyntaxError()

        except:
            error = True
            print(f"There was an error on line {i + 1}")

    if not error:
        with open ("./CAP23/CAP23_CPU/src/input.txt", 'w') as inputFile:
            for line in machineCodes:
                inputFile.write(line + "\n")
        print("File was assembled successfully")