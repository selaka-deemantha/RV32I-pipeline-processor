# =========================
# RV32I Instruction Encoder
# =========================

# -------------------------
# Opcode map
# -------------------------
opcode_map = {
    # R-type
    "add":  {"opcode":"0110011","func3":"000","func7":"0000000"},
    "sub":  {"opcode":"0110011","func3":"000","func7":"0100000"},
    "and":  {"opcode":"0110011","func3":"111","func7":"0000000"},
    "or":   {"opcode":"0110011","func3":"110","func7":"0000000"},
    "xor":  {"opcode":"0110011","func3":"100","func7":"0000000"},
    "sll":  {"opcode":"0110011","func3":"001","func7":"0000000"},
    "srl":  {"opcode":"0110011","func3":"101","func7":"0000000"},
    "sra":  {"opcode":"0110011","func3":"101","func7":"0100000"},
    "slt":  {"opcode":"0110011","func3":"010","func7":"0000000"},
    "sltu": {"opcode":"0110011","func3":"011","func7":"0000000"},

    # I-type arithmetic
    "addi": {"opcode":"0010011","func3":"000"},
    "andi": {"opcode":"0010011","func3":"111"},
    "ori":  {"opcode":"0010011","func3":"110"},
    "xori": {"opcode":"0010011","func3":"100"},
    "slti": {"opcode":"0010011","func3":"010"},
    "sltiu":{"opcode":"0010011","func3":"011"},

    # Loads
    "lb":   {"opcode":"0000011","func3":"000"},
    "lh":   {"opcode":"0000011","func3":"001"},
    "lw":   {"opcode":"0000011","func3":"010"},
    "lbu":  {"opcode":"0000011","func3":"100"},
    "lhu":  {"opcode":"0000011","func3":"101"},

    # Stores
    "sb":   {"opcode":"0100011","func3":"000"},
    "sh":   {"opcode":"0100011","func3":"001"},
    "sw":   {"opcode":"0100011","func3":"010"},

    # Branch
    "beq":  {"opcode":"1100011","func3":"000"},
    "bne":  {"opcode":"1100011","func3":"001"},
    "blt":  {"opcode":"1100011","func3":"100"},
    "bge":  {"opcode":"1100011","func3":"101"},
    "bltu": {"opcode":"1100011","func3":"110"},
    "bgeu": {"opcode":"1100011","func3":"111"},

    # U / J
    "lui":   {"opcode":"0110111"},
    "auipc":{"opcode":"0010111"},
    "jal":  {"opcode":"1101111"},
    "jalr": {"opcode":"1100111","func3":"000"},
}

# -------------------------
# Helpers
# -------------------------
def reg_to_bin(reg):
    if not reg.startswith("x"):
        raise ValueError(f"Invalid register: {reg}")
    n = int(reg[1:])
    if n < 0 or n > 31:
        raise ValueError(f"Register out of range: {reg}")
    return format(n, "05b")

def imm_to_bin(val, bits):
    if val < 0:
        val = (1 << bits) + val
    return format(val & ((1 << bits) - 1), f"0{bits}b")

# -------------------------
# Encoders
# -------------------------

# R-type: m rd rs1 rs2
def encode_r(m, rd, rs1, rs2):
    i = opcode_map[m]
    print(i["func7"], " | ", reg_to_bin(rs2), " | ", reg_to_bin(rs1), " | ", i["func3"], " | ", reg_to_bin(rd), " | ", i["opcode"])
    return (
        i["func7"] +
        reg_to_bin(rs2) +
        reg_to_bin(rs1) +
        i["func3"] +
        reg_to_bin(rd) +
        i["opcode"]
    )

# I-type arithmetic/load/jalr: m rd rs1 imm
def encode_i(m, rd, rs1, imm):
    i = opcode_map[m]
    print(imm_to_bin(imm, 12), " | ", reg_to_bin(rs1), " | ", i["func3"], " | ", reg_to_bin(rd), " | ", i["opcode"])
    return (
        imm_to_bin(imm, 12) +
        reg_to_bin(rs1) +
        i["func3"] +
        reg_to_bin(rd) +
        i["opcode"]
    )

# S-type: m rs2 rs1 imm
def encode_s(m, rs2, rs1, imm):
    i = opcode_map[m]
    imm12 = imm_to_bin(imm, 12)
    print(imm12[11:5], " | ", reg_to_bin(rs2), " | ", reg_to_bin(rs1), " | ", i["func3"], " | ", imm12[4:0], " | ", i["opcode"])
    return (
        imm12[11:5] +
        reg_to_bin(rs2) +
        reg_to_bin(rs1) +
        i["func3"] +
        imm12[4:0] +
        i["opcode"]
    )

# B-type: m rs1 rs2 imm
def encode_b(m, rs1, rs2, imm):
    i = opcode_map[m]
    imm13 = imm_to_bin(imm, 13)
    print(imm13[12], " | ", imm13[10:5], " | ", reg_to_bin(rs2), " | ", reg_to_bin(rs1), " | ", i["func3"], " | ", imm13[4:1], " | ", imm13[11], " | ", i["opcode"])
    return (
        imm13[12] +
        imm13[10:5] +
        reg_to_bin(rs2) +
        reg_to_bin(rs1) +
        i["func3"] +
        imm13[4:1] +
        imm13[11] +
        i["opcode"]
    )

# U-type: m rd imm
def encode_u(m, rd, imm):
    i = opcode_map[m]
    print(imm_to_bin(imm >> 12, 20), " | ", reg_to_bin(rd), " | ", i["opcode"])
    return (
        imm_to_bin(imm >> 12, 20) +
        reg_to_bin(rd) +
        i["opcode"]
    )

def encode_j(m, rd, imm):
    i = opcode_map[m]
    imm21 = imm_to_bin(imm, 21)
    print(imm21[20], " | ", imm21[10:1], " | ", imm21[11], " | ", imm21[19:12], " | ", reg_to_bin(rd), " | ", i["opcode"])
    return (
        imm21[20] +
        imm21[10:1] +
        imm21[11] +
        imm21[19:12] +
        reg_to_bin(rd) +
        i["opcode"]
    )

# -------------------------
# Assembler
# -------------------------
def assemble(instr):
    t = instr.replace(",", "").split()
    m = t[0]

    # R-type
    if m in ["add","sub","and","or","xor","sll","srl","sra","slt","sltu"]:
        return encode_r(m, t[1], t[2], t[3])

    # I-type arithmetic
    if m in ["addi","andi","ori","xori","slti","sltiu"]:
        return encode_i(m, t[1], t[2], int(t[3]))

    # Loads: lw rd imm rs1
    if m in ["lb","lh","lw","lbu","lhu"]:
        return encode_i(m, t[1], t[3], int(t[2]))

    # Stores: sw rs2 imm rs1
    if m in ["sb","sh","sw"]:
        return encode_s(m, t[1], t[3], int(t[2]))

    # Branch: beq rs1 rs2 imm
    if m in ["beq","bne","blt","bge","bltu","bgeu"]:
        return encode_b(m, t[1], t[2], int(t[3]))

    # U-type
    if m in ["lui","auipc"]:
        return encode_u(m, t[1], int(t[2]))

    # J-type
    if m == "jal":
        return encode_j(m, t[1], int(t[2]))

    # JALR
    if m == "jalr":
        return encode_i(m, t[1], t[2], int(t[3]))

    raise ValueError(f"Unsupported instruction: {instr}")

# -------------------------
# Test
# -------------------------
if __name__ == "__main__":
    tests = [
        # Initialize registers
        "addi x1 x0 5",
        "addi x0 x0 0",
        "addi x0 x0 0",

        "addi x2 x0 10",
        "addi x0 x0 0",
        "addi x0 x0 0",

        # Arithmetic
        "add x3 x1 x2",
        "addi x0 x0 0",
        "addi x0 x0 0",

        "sub x4 x2 x1",
        "addi x0 x0 0",
        "addi x0 x0 0"

        # # Logical
        # "and x5 x3 x4",
        # "addi x0 x0 0",
        # "addi x0 x0 0",

        # "or x6 x3 x4",
        # "addi x0 x0 0",
        # "addi x0 x0 0",

        # # Compare
        # "slt x7 x1 x2",
        # "addi x0 x0 0",
        # "addi x0 x0 0",

        # "slt x8 x2 x1",
    ]

    for t in tests:
        print(t, "->", assemble(t))
