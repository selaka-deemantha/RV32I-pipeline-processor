module decode_cycle(
    input logic         clk,
    input logic         rst,
    input logic [31:0]  pc_d,
    input logic [31:0]  pc4_d,
    input logic [31:0]  instr,
    input logic         reg_write, //control signal from write back stage
    input logic [4:0]   w_addr,    //write back address from write back stage
    input logic [31:0]  w_data,    //write back data from write back stage

    //data to execute stage

    output logic [31:0] rd_e1,
    output logic [31:0] rd_e2,
    output logic [31:0] imm_e,
    output logic [31:0] pc_e,
    output logic [31:0] pc4_e,

    //Hazard unit signals

    output logic [4:0]  rs_e1,
    output logic [4:0]  rs_e2,
    output logic [4:0]  rd_e,

    //control signals to execute stage

    output logic        branch_result_e,
    output logic        reg_write_e,
    output logic [1:0]  write_back_e,
    output logic        op_a_sel_e,
    output logic        op_b_sel_e,
    output logic        load_e,
    output logic        store_e,
    output logic [3:0]  alu_ctrl_e,
    output logic        jump_e
    

);
//internal signal for control signals
logic [2:0]             imm_sel; 

logic                   reg_write_d;
logic                   op_a_sel_d;
logic                   op_b_sel_d;
logic [1:0]             write_back_d;
logic                   load_d;
logic                   store_d;
logic                   branch_d;
logic                   mem_en_d;
logic                   jump_d;
logic [3:0]             alu_control_d;

//internal wires for immediate generator
logic [31:0]            i_imm,s_imm,sb_imm,uj_imm,u_imm;
logic [31:0]            imm_d;

//internal signals for reg file
logic [31:0]            rd_d1;
logic [31:0]            rd_d2;

//internal signals for branch unit
logic                   branch_out_d;
logic [6:0]             opcode;
logic [4:0]             rs1;
logic [4:0]             rs2; 
logic [4:0]             rd; 
logic [2:0]             fun3;
logic                   fun7;


always_comb begin
    opcode              = instr[6:0];
    rs1                 = instr[19:15];
    rs2                 = instr[24:20];
    rd                  = instr[11:7];
    fun3                = instr[14:12];
    fun7                = instr[30];
end



control_unit control_unit(

    .opcode             (opcode),
    .fun3               (fun3),
    .fun7               (fun7),

    //control signals
    .reg_write          (reg_write_d),              //write back enable
    .imm_sel            (imm_sel),                  //immediate select
    .operand_b          (op_b_sel_d),               //ALU operand B select
    .operand_a          (op_a_sel_d),               //ALU operand A select
    .mem_to_reg         (write_back_d),             //write back data select
    .Load               (load_d),                   //load enable
    .Store              (store_d),                  //store enable
    .Branch             (branch_d),                 //branch enable
    .mem_en             (mem_en_d),                 //memory enable
    .next_sel           (jump_d),                   //jump enable
    .alu_control        (alu_control_d)             //ALU control signals

);

reg_file reg_file(
    .clk                (clk),
    .rst                (rst),
    .en                 (reg_write),
    .rs1                (rs1),
    .rs2                (rs2),
    .rd                 (w_addr),
    .data               (w_data),
    .op_a               (rd_d1),
    .op_b               (rd_d2)

);

imm_generator imm_gen(
    .instr              (instr),
    .i_imme             (i_imm),
    .s_imme             (s_imm),
    .sb_imme            (sb_imm),
    .uj_imme            (uj_imm),
    .u_imme             (u_imm)
);

mux_8 imm_mux(
	.a                  (i_imm),
	.b                  (s_imm),
	.c                  (sb_imm),
	.d                  (uj_imm),
	.e                  (u_imm),
	.f                  (0),
	.g                  (0),
	.h                  (0),
	.sel                (imm_sel),
	.out                (imm_d)
	);

branch branch(
    .op_a               (rd_d1),
    .op_b               (rd_d2),
    .fun3               (fun3),
    .en                 (branch_d),
    .result             (branch_out_d)
);

always_ff @( posedge clk, posedge rst ) begin
    if(rst) begin

        branch_result_e <= 1'b0;
        reg_write_e     <= 1'b0;
        write_back_e    <= 2'b0;
        op_a_sel_e      <= 1'b0;
        op_b_sel_e      <= 1'b0;
        load_e          <= 1'b0;
        store_e         <= 1'b0;
        alu_ctrl_e      <= 4'b0;
        jump_e          <= 1'b0;

        //

        rd_e1           <= 32'b0;
        rd_e2           <= 32'b0;
        imm_e           <= 32'b0;
        pc_e            <= 32'b0;
        pc4_e           <= 32'b0;
        rs_e1           <= 5'b0;
        rs_e2           <= 5'b0;
        rd_e            <= 5'b0;
    
    end
    else begin

        //control signals
        branch_result_e <= branch_out_d;
        reg_write_e     <= reg_write_d;
        write_back_e    <= write_back_d;
        op_a_sel_e      <= op_a_sel_d;
        op_b_sel_e      <= op_b_sel_d;
        load_e          <= load_d;
        store_e         <= store_d;
        alu_ctrl_e      <= alu_control_d;
        jump_e          <= jump_d;

        //

        rd_e1           <= rd_d1;
        rd_e2           <= rd_d2;
        imm_e           <= imm_d;
        pc_e            <= pc_d;
        pc4_e           <= pc4_d;
        rs_e1           <= rs1;
        rs_e2           <= rs2;
        rd_e            <= rd;


    end
end





endmodule