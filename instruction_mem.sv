module instruction_mem(
    addr,
    instr_out
);

input logic [31:0] addr;
output logic [31:0] instr_out;

reg [31:0] mem [0:255];

initial begin

    mem[0]=32'h00200513;
    mem[1]=32'h00100113;
    mem[2]=32'h00250233;
    mem[3]=32'h00412223;
    mem[4]=32'h00412203;
    mem[5]=32'h00200513;
    mem[6]=32'h00200513;
    mem[7]=32'h00200513;
    mem[8]=32'h00200513;
    mem[9]=32'h00200513;
    mem[10]=32'h00200513;
    mem[11]=32'h00200513;
end
	 
always_comb begin

    instr_out = mem[addr];

end
	 

endmodule