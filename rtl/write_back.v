module write_back(
    input wire [1:0]  mem_to_reg,
	 //in write back stage we use 3 input for mux
	 //alu output
	 //data_memory_output
	 //next_set_address: pc + 4 
	 //we need this mux to save pc+4 in a destination register
    input wire [31:0] alu_out,
    input wire [31:0] data_mem_out,
    input wire [31:0] next_sel_address,
	 //this mux out directly goes to 
    output wire [31:0] rd_sel_mux_out
    );

    //WRITE BACK MUX
    mux2_4 u_mux2 (
        .a(alu_out),
        .b(data_mem_out),
        .c(next_sel_address),
        .sel(mem_to_reg),
        .out(rd_sel_mux_out)
    ); 
endmodule
