module pc(
	input wire clk,
	input wire rst,
	//input wire load,
	input wire next_sel,
	//input wire dmem_valid,
	input wire branch_result,
	input wire [31:0] next_address,
	input wire [31:0] address_in,
	
	output reg [31:0] address_out,
	output wire [31:0] pre_address_pc);
	
	initial begin
		address_out=0;
	end
	
	

  reg [31:0] pre_address;
    always @(posedge clk or negedge rst) begin
        if(!rst)begin
            address_out <= 0;
        end
        else if (next_sel | branch_result)begin
            address_out <= next_address;
				//next address came from alu
				//here we do not use imm generator to add pc with offset 
				//we use alu for that and we use seperate mux in write back stage
				//for save the pc+4 in a register
        end
		  /*
        else if ((load && !dmem_valid))begin
            address_out <= address_out;
        end
		  */
        else begin
            address_out <= address_out + 32'd4;
				//normal increment of the pc
        end

        pre_address <= address_out;
    end

    assign pre_address_pc = pre_address;
endmodule