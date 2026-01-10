module execute (
	 //inputs to the alu: a and b
    input wire [31:0] a_i,
    input wire [31:0] b_i,
	 //alu control signal
    input wire [3:0]  alu_control,
    input wire [31:0] pc_address,
	 //alu output
    output wire [31:0] alu_res_out,
	 //we dont compute pc+immediate inside immediate generator here
	 //so we need to use alu for that but we also need to save pc+4 in rd
	 //inorder to do that we use seperate adder for calculate pc+4 and this pc+4(next_sel_address) 
	 //goes to mux in write stage 
    output wire [31:0] next_sel_address
    );

    // ALU
    alu u_alu0 
    (
        .a_i(a_i),
        .b_i(b_i),
        .op_i(alu_control),
        .res_o(alu_res_out)
    );
    //adder
    adder u_adder0(
        .a(pc_address),
        .adder_out(next_sel_address)
    );
endmodule