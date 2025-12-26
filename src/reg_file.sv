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

always_comb begin
    if(en && rs1 == rd && rs1 != 0) begin
        op_a = data;
    end
    else begin
        if (rs1 == 0) op_a = 32'b0; 
        else op_a = register[rs1];
    end
    if(en && rs2 == rd && rs2 != 0) begin
        op_b = data;
    end
    else begin
        if (rs2 == 0) op_b = 32'b0;
        else  op_b = register[rs2];
    end
end



endmodule