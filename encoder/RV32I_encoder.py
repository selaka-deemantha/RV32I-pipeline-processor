#R type instruction

opcode_map = {
    "add":      {"opcode":"0b0110011","func3":"000","func7":"0000000"},
    "sub":      {"opcode":"0b0110011","func3":"000","func7":"0100000"},
    "xor":      {"opcode":"0b0110011","func3":"100","func7":"0000000"},
    "or":       {"opcode":"0b0110011","func3":"110","func7":"0000000"},
    "and":      {"opcode":"0b0110011","func3":"111","func7":"0000000"},
    "sll":      {"opcode":"0b0110011","func3":"001","func7":"0000000"},
    "srl":      {"opcode":"0b0110011","func3":"101","func7":"0000000"},
    "sra":      {"opcode":"0b0110011","func3":"101","func7":"0100000"},
    "slt":      {"opcode":"0b0110011","func3":"010","func7":"0000000"},
    "sltu":     {"opcode":"0b0110011","func3":"011","func7":"0000000"},


    "addi":     {"opcode":"0b0010011","func3":"000","func7":"NONE"}, 
    "xori":     {"opcode":"0b0010011","func3":"100","func7":"NONE"}, 
    "ori":      {"opcode":"0b0010011","func3":"110","func7":"NONE"}, 
    "andi":     {"opcode":"0b0010011","func3":"111","func7":"NONE"}, 
    "slli":     {"opcode":"0b0010011","func3":"001","func7":"0000000"}, 
    "srli":     {"opcode":"0b0010011","func3":"101","func7":"0000000"}, 
    "srai":     {"opcode":"0b0010011","func3":"101","func7":"0100000"}, 
    "slti":     {"opcode":"0b0010011","func3":"010","func7":"NONE"}, 
    "sltiu":    {"opcode":"0b0010011","func3":"011","func7":"NONE"}, 

    "lb":       {"opcode":"0b0000011","func3":"000"}, 
    "lh":       {"opcode":"0b0000011","func3":"001"}, 
    "lw":       {"opcode":"0b0000011","func3":"010"}, 
    "lbu":      {"opcode":"0b0000011","func3":"100"}, 
    "lhu":      {"opcode":"0b0000011","func3":"101"}, 

    "sb":       {"opcode":"0b0100011","func3":"000"}, 
    "sh":       {"opcode":"0b0100011","func3":"001"}, 
    "sw":       {"opcode":"0b0100011","func3":"010"}, 

    "beq":      {"opcode":"0b1100011","func3":"000"}, 
    "bne":      {"opcode":"0b1100011","func3":"001"}, 
    "blt":      {"opcode":"0b1100011","func3":"100"}, 
    "bge":      {"opcode":"0b1100011","func3":"101"}, 
    "bltu":     {"opcode":"0b1100011","func3":"110"}, 
    "bgeu":     {"opcode":"0b1100011","func3":"111"}, 

    "jal":      {"opcode":"0b1101111"},

    "jalr":     {"opcode":"0b1100111"}, 

    "lui":      {"opcode":"0b0110111"}, 

    "auipc":    {"opcode":"0b0010111"}, 

}

