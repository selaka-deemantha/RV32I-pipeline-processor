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
vlog -sv mux_2.sv
vlog -sv mux_4.sv
vlog -sv mux_8.sv
vlog -sv alu.sv
vlog -sv program_counter.sv
vlog -sv adder.sv
vlog -sv reg_file.sv
vlog -sv instruction_mem.sv
vlog -sv data_mem.sv
vlog -sv imm_generator.sv
vlog -sv control_decoder.sv
vlog -sv type_decoder.sv
vlog -sv control_unit.sv
vlog -sv branch.sv

# Pipeline stages
vlog -sv fetch_cycle.sv
vlog -sv decode_cycle.sv
vlog -sv execution_cycle.sv
vlog -sv mem_cycle.sv
vlog -sv write_back_cycle.sv

# Top-level core and testbench
vlog -sv core.sv
vlog -sv tb.sv

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