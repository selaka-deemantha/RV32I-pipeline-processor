module fetch_cycle #(
    parameter INSTR_SIZE            = 32
)(

    input logic                     clk,
    input logic                     rst,
    input logic                     pc_src,
    input logic [INSTR_SIZE-1:0]    pc_target,
    output logic [INSTR_SIZE-1:0]   instr,
    output logic [INSTR_SIZE-1:0]   pc,
    output logic [INSTR_SIZE-1:0]   pc_4,

    input logic                     stall
);

logic [31:0]                        pc_4_w;
logic [31:0]                        pcf;
logic [31:0]                        pco;
logic [31:0]                        instro;



mux_2 pc_mux(
    .a                              (pc_4_w),
    .b                              (pc_target),
    .sel                            (pc_src),
    .c                              (pcf)
);

program_counter program_counter(
    .clk                            (clk),
    .rst                            (rst),
    .pc_next                        (pcf),
    .pc                             (pco),
    .stall                          (stall)
);

instruction_mem imem(
    .addr                           (pco),
    .instr_out                      (instro)
);

adder pc_adder(
    .a                              (pco),
    .c                              (pc_4_w)
);


always_ff @(posedge clk, posedge rst) begin
    if(rst) begin
        instr                       <=32'b0;
        pc                          <=32'b0;
        pc_4                        <=32'b0;

    end
    else if (!stall) begin
        instr                       <=instro;
        pc                          <=pco;
        pc_4                        <=pc_4_w;
    end
    else begin
        instr                       <= instr;
        pc                          <= pc;
        pc_4                        <= pc_4;
    end

end


endmodule
