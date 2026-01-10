module instruc_mem_top #(
    parameter INIT_MEM = 0
)(
    //input wire clk,
    //input wire rst,
    //input wire we_re,
    //input wire request,
	 //instruction mask signal always 1111
    //input wire [3:0]  mask,
	
    input wire [7:0]  address,
    //input wire [31:0] data_in,

    //output reg valid,
    output reg [31:0] data_out
    );
/*
    always @(posedge clk or negedge rst ) begin
        if(!rst)begin
            valid <= 0;
        end
        else begin
            valid <= request;
        end
    end
	 */
	 /////////////////////////////////////////
	 reg [31:0] mem [0:255];
	 initial begin
	 /*
		mem[0]=32'h00200513;
		mem[1]=32'h00100113;
		mem[2]=32'h014000EF;
		mem[3]=32'h00810193;
		mem[4]=32'h000012B7;
		mem[5]=32'h03000317;
		mem[6]=32'h00A19663;
		mem[7]=32'h00210233;
		mem[8]=32'h00008067;
		mem[9]=32'h00000033;
		mem[10]=32'h00352323;
		mem[11]=32'h00652383;
		*/
		
		mem[0]=32'h00200513;
		mem[1]=32'h00100113;
		mem[2]=32'h00250233;
		mem[3]=32'h00412223;
		mem[4]=32'h00412203;
		mem[5]=32'h00200513;
		mem[6]=32'h00200513;
		mem[7]=32'h00200513;
		mem[8]=32'h00200513;
		mem[9]=32'h00200513;
		mem[10]=32'h00200513;
		mem[11]=32'h00200513;
		end
	 
	    always @(*) begin

           data_out <= mem[address];
        
    end
	 
	 ////////////////////////////////////
	 
	 
	 
	 
/*
    memory #(
      .INIT_MEM(INIT_MEM)
    )u_memory(
        .clk(clk),
        .we_re(we_re),
        .request(request),
        .mask(mask),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );
	 
	 */
endmodule
