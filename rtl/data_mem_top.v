module data_mem_top #(
    parameter INIT_MEM = 0
)(
    input wire clk,
    input wire rst,
    input wire we_re,
    input wire request,
    input wire load,
	 
	 //masking is needed only when writing something to the memory
    input wire [3:0]  mask,
    input wire [7:0]  address,
    input wire [31:0] data_in,
	 
	 //data that load from memory is valid or not
    output wire [31:0] data_out
    );


    memory #(
      .INIT_MEM(INIT_MEM)
    )u_memory(
        .clk(clk),
        .we_re(we_re),
        .request(request),
        .mask(mask),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );
endmodule
