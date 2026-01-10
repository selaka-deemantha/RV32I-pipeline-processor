
module memory#(
    parameter INIT_MEM = 0
)(
    input wire clk,
	 //write request
    input wire we_re,
    input wire request,
	 //store load address
    input wire [7:0]address,
	 //store data input
    input wire [31:0]data_in,
    input wire [3:0]mask,
	 //load data output
    output reg [31:0]data_out
);
	 //initialize the memory
    reg [31:0] mem [0:255];

    //initial begin
        //if (INIT_MEM)
            //$readmemh("tb/instr.mem",mem);
   //end

    always @(posedge clk) begin
        if (request && we_re) begin
		  //write data to the memory
		  //we_re=store
		  //request=load | store
		  //if mask==1111 full data will be written to the memory
            if(mask[0]) begin
                mem[address][7:0] <= data_in[7:0];
            end
            if(mask[1]) begin
                mem[address][15:8] <= data_in[15:8];
            end
            if(mask[2]) begin
                mem[address][23:16] <= data_in[23:16];
            end
            if(mask[3]) begin
                mem[address][31:24] <= data_in[31:24];
            end
        end
		 end

		  //request && !we_re is true only when the load signal is true and store signal is false
	always @(*) begin
		 
        if (request && !we_re) begin
            data_out <= mem[address];
        end
    end
endmodule
