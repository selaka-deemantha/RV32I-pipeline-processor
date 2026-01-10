module fetch (
//control signals
    input wire clk,
    input wire rst,
    input wire next_sel,
    //input wire valid,
    //input wire load,
    input wire branch_result,
	 
    input wire [31:0] next_address,//this next address is calculated in alu because in here we do not perform any calculations
	 //in immediate generator
    input wire [31:0] address_in,// hardwired to zero in core
    input wire [31:0] instruction_fetch, //instruction that fetched from instr mem

	 //control signals for 
    //output reg we_re,
    //output reg request,
    //output reg [3:0] mask,
	 
    output wire [31:0] address_out,//program counter
    output reg  [31:0] instruction,// instruction
    output wire [31:0] pre_address_pc
    );

    // PROGRAM COUNTER
    pc u_pc0 
    (
        .clk(clk),
        .rst(rst),
        //.load(load),
        .next_sel(next_sel),
        //.dmem_valid(valid),
        .next_address(next_address),
        .branch_result(branch_result),
        .address_in(0),
        .address_out(address_out),
        .pre_address_pc(pre_address_pc)
    );
	 
	 //mask-instr mem mask 
	 //we_re-instr mem write request
	 //request-instr mem request
/*
    always @ (*) begin
        if ((load && !valid)) begin
		  //we do not write instruction parts. we always write full instruction so we give mask as 1111
            mask = 4'b1111; 
            we_re = 1'b0;
            request = 1'b0;
        end
        else begin
            mask = 4'b1111; 
            we_re = 1'b0;
            request = 1'b1;
        end
    end
	 */
	 //most important part 
	 //return the instruction to decode stage
    always @ (*) begin
        instruction = instruction_fetch ;
    end
endmodule