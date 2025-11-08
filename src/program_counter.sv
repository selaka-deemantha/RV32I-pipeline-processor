module program_counter(
    clk,
    rst,
    pc_next,
    pc
);

input logic clk;
input logic rst;
input logic [31:0] pc_next;
output logic [31:0] pc;

always_ff @( posedge clk, posedge rst )
begin
    if(rst) begin
        pc<=32'b0;
    end
    else begin
        pc<=pc_next;
    end
end
    

endmodule
