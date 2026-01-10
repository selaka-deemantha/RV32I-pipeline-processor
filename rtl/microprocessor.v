module microprocessor (
    input wire clk,
    input wire rst,
	 
	 //test outputs
	 output wire [31:0] st_data,
	 output wire [31:0] ld_data,
	 output wire [31:0] pc_ad,
	 output wire load_sig,
	 output wire [31:0] instruction,
	 output wire [31:0] alu_o_a,
	 output wire d_req,
	 output wire d_w_req,
	 output wire d_valid
    );
	 

    wire [31:0] instruction_data; //instruction data came from instr mem and goes to fetch stage 
    wire [31:0] pc_address; //pc address came from fetch stage and goes to instr mem
    wire [31:0] load_data_out; // load data out came from data mem and goes to core
    wire [31:0] alu_out_address;// alu out address came from core and goes to data mem(memory address for load and store)
    wire [31:0] store_data;// store data came from core and goes to data mem(data that needs to be saved in data mem)
    wire [3:0]  mask;//wrapper memory calculate this one
    //wire [3:0]  instruc_mask_singal;//always 1111 because we do not write patial instruction
    //wire instruction_mem_we_re;//always 0
    //wire instruction_mem_request;//if load && !valid then 0 else (normally) 1
    //wire instruc_mem_valid;//if rst=0 then 0 else equal to request 
    wire data_mem_valid;
    wire data_mem_we_re;
    wire data_mem_request;
    wire load_signal;
    wire store;
	 
	 
	 
	 assign st_data=store_data;
	 assign ld_data=load_data_out;
	 assign pc_ad=pc_address;
	 assign load_sig=load_signal;
	 assign alu_o_a=alu_out_address;
	 assign instruction=instruction_data;
	 assign d_req=data_mem_request;
	 assign d_w_req=data_mem_we_re;
	 assign d_valid=data_mem_valid;

    // INSTRUCTION MEMORY
    instruc_mem_top #(
        .INIT_MEM(0)
    )u_instruction_memory(
        //.clk(clk),
        //.rst(rst),
        //.we_re(instruction_mem_we_re),
        //.request(instruction_mem_request),
        //.mask(instruc_mask_singal),//always 1111
        .address(pc_address[9:2]),
        //.data_in(instruction),
        //.valid(instruc_mem_valid),
        .data_out(instruction_data)
    );

    //CORE
    core u_core(
        .clk(clk),
        .rst(rst),
        .instruction(instruction_data),
        .load_data_in(load_data_out),
        .mask_singal(mask),
        .load_signal(load_signal),
        //.instruc_mask_singal(instruc_mask_singal),
        //.instruction_mem_we_re(instruction_mem_we_re),
        //.instruction_mem_request(instruction_mem_request),
        .data_mem_we_re(data_mem_we_re),
        .data_mem_request(data_mem_request),
        //.instruc_mem_valid(instruc_mem_valid),
        //.data_mem_valid(data_mem_valid),
        .store_data_out(store_data),
        .pc_address(pc_address),
        .alu_out_address(alu_out_address)
    );


    // DATA MEMORY
    data_mem_top u_data_memory(
        .clk(clk),
        .rst(rst),
        .we_re(data_mem_we_re),
        .request(data_mem_request),
        .address(alu_out_address[9:2]),
        .data_in(store_data),
        .mask(mask),
        .load(load_signal),
        //.valid(data_mem_valid),
        .data_out(load_data_out)
    );
endmodule