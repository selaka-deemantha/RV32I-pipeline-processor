module reg_file  (
    clk,
    rst,
    en,
    rs1,
    rs2,
    rd,
    data,
    op_a,
    op_b
);



input logic         clk;
input logic         rst;
input logic         en;
input logic [4:0]   rs1;
input logic [4:0]   rs2;
input logic [4:0]   rd;
input logic [31:0]  data;

output logic [31:0] op_a;
output logic [31:0] op_b;

reg [31:0]          register[31:0];
integer             i;

always @(posedge clk or posedge rst) begin
    if(rst)begin
        for (i = 0; i < 32; i = i + 1) begin
            register[i] <= 32'b0;
        end
    end
    else if(en)begin
        register[rd] <= data;
    end
end

assign op_a = (rs1 != 0) ? register[rs1] : 0;
assign op_b = (rs2 != 0) ? register[rs2] : 0;

endmodule