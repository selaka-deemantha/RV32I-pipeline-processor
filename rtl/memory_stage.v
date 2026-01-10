module memory_stage (
    input rst,
	 //control signals for memory
    input wire load,
    input wire store,
	 //data input when store instruction
    input wire [31:0] op_b,
	 //calculated address when store and load instruction
    input wire [31:0] alu_out_address,
	 //wrapper memory is an intermediate between memory and memory stage
	 //there are several load and store variations like sb, lw, lhw ...
	 //in order to do those things we use wrapper memory 
	 //it took data to be stored (opb) and output store data out
	 //it took data that came from memory and needs to be stored in rd (wrap_load_in, wrap_load_out)
	 //this wrapper mem needs func3 to identify operation so we need to give instruction as input
    input wire [31:0] instruction,
    input wire [31:0] wrap_load_in,
	 //data mem write request
    output reg we_re,
	 //data mem request
    output reg request,
    output wire [3:0]  mask,
    output wire [31:0] store_data_out,
    output wire [31:0] wrap_load_out
    );

    // WRAPPER MEMORY
    wrappermem u_wrap_mem0 (
        .data_i(op_b),
        .byteadd(alu_out_address [1:0]),
        .fun3(instruction [14:12]),
        .mem_en(store),
        .Load(load),
        .wrap_load_in(wrap_load_in),
        .masking(mask),
        .data_o(store_data_out),
        .wrap_load_out(wrap_load_out)
    );

    always @ (*) begin
        if (load || store) begin
				request = load | store ;
            we_re = store ;
     
        end
        else begin
            request = 0 ;
            we_re = 0 ;
        end
    end
endmodule
