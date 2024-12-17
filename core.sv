module core(
    input clk,
    input rst,

    output logic [31:0] instr_t             // Instruction
    // output logic [31:0] pc_f_d_t,            // Program counter from fetch to decode
    // output logic [31:0] pc_d_e_t,            // Program counter from decode to execute
    // output logic [31:0] pc4_f_d_t,           // PC+4 from fetch to decode
    // output logic [31:0] pc4_d_e_t,           // PC+4 from decode to execute
    // output logic [31:0] pc4_e_m_t,           // PC+4 from execute to memory
    // output logic [31:0] pc4_m_w_t,           // PC+4 from memory to write-back
    // output logic reg_write_w_f_t,            // Register write flag from write-back to fetch
    // output logic [31:0] alu_out_e_f_t,       // ALU output from execute to fetch
    // output logic [31:0] alu_out_e_m_t,       // ALU output from execute to memory
    // output logic [31:0] alu_out_m_w_t,       // ALU output from memory to write-back
    // output logic [31:0] write_back_data_t,   // Data to write-back
    // output logic [4:0] write_back_addr_t    // Address for write-back register
    // output logic reg_write_d_e_t,            // Register write flag from decode to execute
    // output logic reg_write_e_m_t,            // Register write flag from execute to memory
    // output logic reg_write_m_w_t,            // Register write flag from memory to write-back
    // output logic [1:0] write_back_d_e_t,     // Write-back signal from decode to execute
    // output logic [1:0] write_back_e_m_t,     // Write-back signal from execute to memory
    // output logic [1:0] write_back_m_w_t,     // Write-back signal from memory to write-back
    // output logic [31:0] mem_data_t,          // Memory data from memory stage
    // output logic [31:0] op_b_e_m_t,          // Operand B from execute to memory
    // output logic load_d_e_t,                 // Load flag from decode to execute
    // output logic load_e_m_t,                 // Load flag from execute to memory
    // output logic store_d_e_t,                // Store flag from decode to execute
    // output logic store_e_m_t,                // Store flag from execute to memory
    // output logic jump_d_e_t,                 // Jump flag from decode to execute
    // output logic op_a_sel_d_e_t,             // Operand A select signal from decode to execute
    // output logic op_b_sel_d_e_t,             // Operand B select signal from decode to execute
    // output logic [3:0] alu_ctrl_d_e_t,       // ALU control signal from decode to execute
    // output logic [31:0] rd_d1_e_t,           // First read data from decode to execute
    // output logic [31:0] rd_d2_e_t,           // Second read data from decode to execute
    // output logic [31:0] imm_d_e_t,           // Immediate data from decode to execute
    // output logic branch_result_d_e_t,        // Branch result from decode to execute
    // output logic [4:0] rs_e1_d_t,            // Source register 1 from decode to execute
    // output logic [4:0] rs_e2_d_t,            // Source register 2 from decode to execute
    // output logic [4:0] rd_e_d_t,             // Destination register from decode to execute
    // output logic [4:0] rs_e1_h_t,            // Source register 1 (in the next stage, if any)
    // output logic [4:0] rs_e2_h_t,            // Source register 2 (in the next stage, if any)
    // output logic [4:0] rd_e_h_t,             // Destination register (in the next stage, if any)
    // output logic [31:0] rd_M_t,              // Read data from memory stage
    // output logic [4:0] rd_M_addr_t,          // Address from memory stage
    // output logic rd_M_sig_h_t,               // Signal to indicate data validity from memory stage
    // output logic pc_src_t,                   // PC source signal (branch or jump)
    // output logic branch_out_t,               // Branch outcome signal
    // output logic jump_o_t                    // Jump outcome signaloutput logic reg_write_d_e_t,            // Register write flag from decode to execute
    // output logic reg_write_e_m_t,            // Register write flag from execute to memory
    // output logic reg_write_m_w_t,            // Register write flag from memory to write-back
    // output logic [1:0] write_back_d_e_t,     // Write-back signal from decode to execute
    // output logic [1:0] write_back_e_m_t,     // Write-back signal from execute to memory
    // output logic [1:0] write_back_m_w_t,     // Write-back signal from memory to write-back
    // output logic [31:0] mem_data_t,          // Memory data from memory stage
    // output logic [31:0] op_b_e_m_t,          // Operand B from execute to memory
    // output logic load_d_e_t,                 // Load flag from decode to execute
    // output logic load_e_m_t,                 // Load flag from execute to memory
    // output logic store_d_e_t,                // Store flag from decode to execute
    // output logic store_e_m_t,                // Store flag from execute to memory
    // output logic jump_d_e_t,                 // Jump flag from decode to execute
    // output logic op_a_sel_d_e_t,             // Operand A select signal from decode to execute
    // output logic op_b_sel_d_e_t,             // Operand B select signal from decode to execute
    // output logic [3:0] alu_ctrl_d_e_t,       // ALU control signal from decode to execute
    // output logic [31:0] rd_d1_e_t,           // First read data from decode to execute
    // output logic [31:0] rd_d2_e_t,           // Second read data from decode to execute
    // output logic [31:0] imm_d_e_t,           // Immediate data from decode to execute
    // output logic branch_result_d_e_t,        // Branch result from decode to execute
    // output logic [4:0] rs_e1_d_t,            // Source register 1 from decode to execute
    // output logic [4:0] rs_e2_d_t,            // Source register 2 from decode to execute
    // output logic [4:0] rd_e_d_t,             // Destination register from decode to execute
    // output logic [4:0] rs_e1_h_t,            // Source register 1 (in the next stage, if any)
    // output logic [4:0] rs_e2_h_t,            // Source register 2 (in the next stage, if any)
    // output logic [4:0] rd_e_h_t,             // Destination register (in the next stage, if any)
    // output logic [31:0] rd_M_t,              // Read data from memory stage
    // output logic [4:0] rd_M_addr_t,          // Address from memory stage
    // output logic rd_M_sig_h_t,               // Signal to indicate data validity from memory stage
    // output logic pc_src_t,                   // PC source signal (branch or jump)
    // output logic branch_out_t,               // Branch outcome signal
    // output logic jump_o_t                    // Jump outcome signal
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




// Add assignments to output the desired values for testing purposes
 assign instr_t = instr;
// assign pc_f_d_t = pc_f_d;
// assign pc_d_e_t = pc_d_e;
// assign pc4_f_d_t = pc4_f_d;
// assign pc4_d_e_t = pc4_d_e;
// assign pc4_e_m_t = pc4_e_m;
// assign pc4_m_w_t = pc4_m_w;
// assign reg_write_w_f_t = reg_write_w_f;
// assign alu_out_e_f_t = alu_out_e_f;
// assign alu_out_e_m_t = alu_out_e_m;
// assign alu_out_m_w_t = alu_out_m_w;
// assign write_back_data_t = write_back_data;
// assign write_back_addr_t = write_back_addr;
// assign reg_write_d_e_t = reg_write_d_e;
// assign reg_write_e_m_t = reg_write_e_m;
// assign reg_write_m_w_t = reg_write_m_w;
// assign write_back_d_e_t = write_back_d_e;
// assign write_back_e_m_t = write_back_e_m;
// assign write_back_m_w_t = write_back_m_w;
// assign mem_data_t = mem_data;
// assign op_b_e_m_t = op_b_e_m;
// assign load_d_e_t = load_d_e;
// assign load_e_m_t = load_e_m;
// assign store_d_e_t = store_d_e;
// assign store_e_m_t = store_e_m;
// assign jump_d_e_t = jump_d_e;
// assign op_a_sel_d_e_t = op_a_sel_d_e;
// assign op_b_sel_d_e_t = op_b_sel_d_e;
// assign alu_ctrl_d_e_t = alu_ctrl_d_e;
// assign rd_d1_e_t = rd_d1_e;
// assign rd_d2_e_t = rd_d2_e;
// assign imm_d_e_t = imm_d_e;
// assign branch_result_d_e_t = branch_result_d_e;
// assign rs_e1_d_t = rs_e1_d;
// assign rs_e2_d_t = rs_e2_d;
// assign rd_e_d_t = rd_e_d;
// assign rs_e1_h_t = rs_e1_h;
// assign rs_e2_h_t = rs_e2_h;
// assign rd_e_h_t = rd_e_h;
// assign rd_M_t = rd_M;
// assign rd_M_addr_t = rd_M_addr;
// assign rd_M_sig_h_t = rd_M_sig_h;
// assign pc_src_t = pc_src;
// assign branch_out_t = branch_out;
// assign jump_o_t = jump_o;



assign pc_src= branch_out || jump_o;


fetch_cycle fetch(
    .clk                (clk),
    .rst                (rst),
    .pc_src             (pc_src),////////////////////////
    .pc_target          (alu_out_e_f),
    .instr              (instr),
    .pc                 (pc_f_d),
    .pc_4               (pc4_f_d)
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
    .jump_e             (jump_d_e)

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