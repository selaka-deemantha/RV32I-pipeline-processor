# =====================================================
# Questa run script for RISC-V Core
# =====================================================

# Remove old work library if it exists
if {[file exists "work"]} {
    vdel -all
}
vlib work

# =====================================================
# Compile all modules
# =====================================================
# Utility modules
vlog -sv src/mux_2.sv
vlog -sv src/mux_4.sv
vlog -sv src/mux_8.sv
vlog -sv src/alu.sv
vlog -sv src/program_counter.sv
vlog -sv src/adder.sv
vlog -sv src/reg_file.sv
vlog -sv src/instruction_mem.sv
vlog -sv src/data_mem.sv
vlog -sv src/imm_generator.sv
vlog -sv src/control_decoder.sv
vlog -sv src/type_decoder.sv
vlog -sv src/control_unit.sv
vlog -sv src/branch.sv

# Pipeline stages
vlog -sv src/fetch_cycle.sv
vlog -sv src/decode_cycle.sv
vlog -sv src/execution_cycle.sv
vlog -sv src/mem_cycle.sv
vlog -sv src/write_back_cycle.sv

# Top-level core 
vlog -sv src/core.sv

#Testbenches
vlog -sv tb/tb.sv

# =====================================================
# Launch simulation with waveform logging
# =====================================================
vsim -voptargs="+acc=npr" tb -wlf core_sim.wlf

# Log all signals recursively
log -r /*

add wave -position end sim:/tb/*
add wave -position end sim:/tb/uut/fetch/*

add wave -position end sim:/tb/uut/branch_out
add wave -position end sim:/tb/uut/jump_o

add wave -position end sim:/tb/uut/decode/jump_e
add wave -position end sim:/tb/uut/decode/jump_d
add wave -position end sim:/tb/uut/decode/instr
add wave -position end sim:/tb/uut/decode/opcode
add wave -position end sim:/tb/uut/decode/control_unit/opcode



add wave -position end sim:/tb/uut/decode/control_unit/next_sel
add wave -position end sim:/tb/uut/decode/control_unit/u_controldec0/jal
add wave -position end sim:/tb/uut/decode/control_unit/u_controldec0/jalr
add wave -position end sim:/tb/uut/decode/control_unit/u_typedec0/jal
add wave -position end sim:/tb/uut/decode/control_unit/u_typedec0/jalr
add wave -position end sim:/tb/uut/decode/control_unit/u_typedec0/opcode







run 800ns

# Quit after simulation
#quit -f