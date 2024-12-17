vlog mux_4.sv
vlog mux_2.sv
vlog alu.sv
vlog data_mem.sv
vlog control_unit.sv
vlog reg_file.sv
vlog imm_generator.sv
vlog mux_8.sv
vlog branch.sv
vlog program_counter.sv
vlog instruction_mem.sv
vlog adder.sv
vlog control_decoder.sv
vlog type_decoder.sv


vlog execution_cycle.sv
vlog mem_cycle.sv
vlog write_back_cycle.sv
vlog fetch_cycle.sv
vlog decode_cycle.sv
vlog core.sv

vsim core -c -do "run -all; quit"