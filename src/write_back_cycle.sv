module write_back_cycle(
    //control signals
    input logic reg_write_w,
    input logic [1:0] write_back_w,

    input logic [31:0] alu_out_w,
    input logic [31:0] mem_data_w,
    input logic [31:0] pc4_w,
    input logic [4:0] rd_w,         //to the hazard unit

    output logic [31:0] write_back_result,
    output logic reg_write,
    output logic [4:0] rd_w_out
);

mux_4 write_back_mux(
    .a(alu_out_w),
    .b(mem_data_w),
    .c(pc4_w),
    .d(32'b0),
    .sel(write_back_w),
    .out(write_back_result)
);

always_comb begin
    reg_write=reg_write_w;
    rd_w_out=rd_w;
end





endmodule
