module execution_cycle(
    input logic         clk,
    input logic         rst,
    //control sig
    input logic         reg_write_e,
    input logic [1:0]   write_back_e,
    input logic         branch_result_e,
    input logic         jump_e,
    input logic         op_a_sel_e,
    input logic         op_b_sel_e,
    input logic         load_e,
    input logic         store_e,
    input logic [3:0]   alu_ctrl_e,

    input logic [1:0]   forward_AE,
    input logic [1:0]   forward_BE,
    input logic [4:0]   rd_e,
    input logic [4:0]   rs_e1,
    input logic [4:0]   rs_e2,
    input logic [31:0]  rd_M,
    input logic [31:0]  rd_W,


    input logic [31:0]  pc4_e,
    input logic [31:0]  pc_e,
    input logic [31:0]  rd_e1,
    input logic [31:0]  rd_e2,
    input logic [31:0]  imm_e,

    output logic [31:0] alu_out_m, //
    output logic [31:0] alu_out_e, //
    output logic [31:0] op_b_m, //
    output logic [4:0]  rs_e1_o,
    output logic [4:0]  rs_e2_o,
    output logic [4:0]  rd_e_o,
    output logic [4:0]  rd_m, //
    output logic [31:0] pc4_m, //
    //control signal outputs
    output logic        jump_o,
    output logic        branch_out, //
    output logic        load_m, //
    output logic        store_m, //
    output logic        reg_write_m, //
    output logic [1:0]  write_back_m //


);

//internal signals

logic [31:0]            reg_a_sel_out;
logic [31:0]            reg_b_sel_out;
logic [31:0]            op_a;
logic [31:0]            op_b;
logic [31:0]            alu_out;


mux_4 reg_out_A_sel_mux(
    .a                  (rd_e1),
    .b                  (rd_M),
    .c                  (rd_W),
    .d                  (0),
    .sel                (forward_AE),
    .out                (reg_a_sel_out)
);

mux_4 reg_out_B_sel_mux(
    .a                  (rd_e2),
    .b                  (rd_M),
    .c                  (rd_W),
    .d                  (0),
    .sel                (forward_BE),
    .out                (reg_b_sel_out)
);

mux_2 op_a_sel_mux(
    .a                  (reg_a_sel_out),
    .b                  (pc_e),
    .sel                (op_a_sel_e),
    .c                  (op_a)
);

mux_2 op_b_sel_mux(
    .a                  (reg_b_sel_out),
    .b                  (imm_e),
    .sel                (op_b_sel_e),
    .c                  (op_b)
);

alu alu(
    .a_i                (op_a),
    .b_i                (op_b),
    .op_i               (alu_ctrl_e),
    .res_o              (alu_out)
);

assign branch_out=branch_result_e;
assign alu_out_e=alu_out;
assign rs_e1_o=rs_e1;
assign rs_e2_o=rs_e2;
assign rd_e_o=rd_e;
assign jump_o=jump_e;


always_ff @( posedge clk, posedge rst ) begin 
    if(rst) begin
    
    end
    else begin
        //control signals assign
        load_m<=load_e;
        store_m<=store_e;
        reg_write_m<=reg_write_e;
        write_back_m<=write_back_e;

        //other signals
        alu_out_m<=alu_out;
        op_b_m<=reg_b_sel_out;
        pc4_m<=pc4_e;
        rd_m<=rd_e;


    end
    
    
end



endmodule