module core(
    input clk,
    input rst
);

logic [31:0] instr;
logic [31:0] pc_f_d, pc_d_e;
logic [31:0] pc4_f_d, pc4_d_e, pc4_e_m, pc4_m_w;
logic reg_write_w_f;
logic [31:0] alu_out_e_f, alu_out_e_m, alu_out_m_w;
logic [31:0] write_back_data;
logic [4:0] write_back_addr;
logic reg_write_d_e, reg_write_e_m,reg_write_m_w;
logic [1:0] write_back_d_e, write_back_e_m, write_back_m_w;
logic [31:0] mem_data;
logic [31:0] op_b_e_m;
logic load_d_e, load_e_m, store_d_e, store_e_m;
logic jump_d_e;
logic op_a_sel_d_e, op_b_sel_d_e;
logic [3:0] alu_ctrl_d_e;
logic [31:0] rd_d1_e, rd_d2_e, imm_d_e;
logic branch_result_d_e;
logic [4:0] rs_e1_d, rs_e2_d, rd_e_d, rd_e_m, rd_m_w;
logic [4:0] rs_e1_h, rs_e2_h, rd_e_h;
logic [31:0] rd_M;
logic [4:0] rd_M_addr;
logic rd_M_sig_h;
logic pc_src;
logic branch_out;
logic jump_o;


 assign instr_t = instr;
 assign pc_src= branch_out || jump_o;


fetch_cycle fetch(
    .clk                (clk),
    .rst                (rst),
    .pc_src             (pc_src),
    .pc_target          (alu_out_e_f),
    .instr              (instr),
    .pc                 (pc_f_d),
    .pc_4               (pc4_f_d),
    .stall              (0)
);

decode_cycle decode(

    .clk                (clk),
    .rst                (rst),
    .pc_d               (pc_f_d),
    .pc4_d              (pc4_f_d),
    .instr              (instr),
    .reg_write          (reg_write_w_f), 
    .w_addr             (write_back_addr),
    .w_data             (write_back_data),
    ////
    .rd_e1              (rd_d1_e),
    .rd_e2              (rd_d2_e),
    .imm_e              (imm_d_e),
    .pc_e               (pc_d_e),
    .pc4_e              (pc4_d_e),

    .rs_e1              (rs_e1_d),
    .rs_e2              (rs_e2_d),
    .rd_e               (rd_e_d),

    .branch_result_e    (branch_result_d_e),
    .reg_write_e        (reg_write_d_e),
    .write_back_e       (write_back_d_e),
    .op_a_sel_e         (op_a_sel_d_e),
    .op_b_sel_e         (op_b_sel_d_e),
    .load_e             (load_d_e),
    .store_e            (store_d_e),
    .alu_ctrl_e         (alu_ctrl_d_e),
    .jump_e             (jump_d_e),
    .bubble             (0)

);

execution_cycle execute(

    .clk                (clk),
    .rst                (rst),
    .reg_write_e        (reg_write_d_e),
    .write_back_e       (write_back_d_e),
    .branch_result_e    (branch_result_d_e),
    .jump_e             (jump_d_e),
    .op_a_sel_e         (op_a_sel_d_e),
    .op_b_sel_e         (op_b_sel_d_e),
    .load_e             (load_d_e),
    .store_e            (store_d_e),
    .alu_ctrl_e         (alu_ctrl_d_e),

    .forward_AE         (2'b0),
    .forward_BE         (2'b0),
    .rd_e               (rd_e_d),
    .rs_e1              (rs_e1_d),
    .rs_e2              (rs_e2_d),
    .rd_M               (rd_M),
    .rd_W               (write_back_data),


    .pc4_e              (pc4_d_e),
    .pc_e               (pc_d_e),
    .rd_e1              (rd_d1_e),
    .rd_e2              (rd_d2_e),
    .imm_e              (imm_d_e),
    ////
    .alu_out_m          (alu_out_e_m), //
    .alu_out_e          (alu_out_e_f), //
    .op_b_m             (op_b_e_m), //
    .rs_e1_o            (rs_e1_h),
    .rs_e2_o            (rs_e2_h),
    .rd_e_o             (rd_e_h),
    .jump_o             (jump_o),
    .rd_m               (rd_e_m), //
    .pc4_m              (pc4_e_m), //
    .branch_out         (branch_out), //
    .load_m             (load_e_m), //
    .store_m            (store_e_m), //
    .reg_write_m        (reg_write_e_m), //
    .write_back_m       (write_back_e_m) //


);

mem_cycle mem(
    .clk                (clk),
    .rst                (rst),

    .reg_write_m        (reg_write_e_m),
    .write_back_m       (write_back_e_m),
    .load_m             (load_e_m),
    .store_m            (store_e_m),


    .alu_out_m          (alu_out_e_m),
    .op_b_m             (op_b_e_m),
    .pc4_m              (pc4_e_m),
    .rd_m               (rd_e_m),

    .reg_write_w        (reg_write_m_w),
    .write_back_w       (write_back_m_w),

    .mem_data_w         (mem_data),
    .alu_out_w          (alu_out_m_w),
    .pc4_w              (pc4_m_w),
    .rd_w               (rd_m_w),

    .rd_m_addr          (rd_M_addr), //h
    .rd_m_data          (rd_M), //h
    .rd_m_write_signal  (rd_M_sig_h)  //h

    );

write_back_cycle write_back(
    .reg_write_w        (reg_write_m_w),
    .write_back_w       (write_back_m_w),

    .alu_out_w          (alu_out_m_w),
    .mem_data_w         (mem_data),
    .pc4_w              (pc4_m_w),
    .rd_w               (rd_m_w),
    ////
    .write_back_result  (write_back_data),
    .reg_write          (reg_write_w_f),
    .rd_w_out           (write_back_addr)

);


endmodule