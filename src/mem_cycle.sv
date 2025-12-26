module mem_cycle(
    input logic         clk,
    input logic         rst,
    
    //control signals
    input logic         reg_write_m,
    input logic [1:0]   write_back_m,
    input logic         load_m,
    input logic         store_m,

    //To write back mux
    input logic [31:0]  alu_out_m,      //alu out and memory address
    input logic [31:0]  op_b_m,         //memory write data
    input logic [31:0]  pc4_m,

    //To hazard unit
    input logic [4:0]   rd_m,

    //control signals
    output logic        reg_write_w,
    output logic [1:0]  write_back_w,

    output logic [31:0] mem_data_w,
    output logic [31:0] alu_out_w,
    output logic [31:0] pc4_w,
    output logic [4:0]  rd_w,

    //non pipe outputs
    output logic [4:0]  rd_m_addr,          //to the hazard unit
    output logic [31:0] rd_m_data,          //to the execution stage for forwarding
    output logic        rd_m_write_signal  //to the hazard unit 

);

logic [31:0]            mem_data_m;


data_mem data_memory(
    .clk                (clk),
    .rst                (rst),
    .store              (store_m),
    .load               (load_m),
    .mask               (4'b1111),
    .address            (alu_out_m),
    .data_in            (op_b_m),
    .data_out           (mem_data_m)
);

always_comb begin
    rd_m_addr           = rd_m;
    rd_m_data           = alu_out_m;
    rd_m_write_signal   = reg_write_m;
end


always_ff @(posedge clk, posedge rst) begin
    if(rst) begin
        reg_write_w     <= 1'b0;
        write_back_w    <= 2'b0;
        mem_data_w      <= 32'b0;
        alu_out_w       <= 32'b0;
        rd_w            <= 5'b0;
        pc4_w           <= 32'b0;
    
    end
    else begin
        reg_write_w     <= reg_write_m;
        write_back_w    <= write_back_m;
        mem_data_w      <= mem_data_m;
        alu_out_w       <= alu_out_m;
        rd_w            <= rd_m;
        pc4_w           <= pc4_m;

    end
end




endmodule