module program_counter(
    input logic             clk,
    input logic             rst,
    input logic [31:0]      pc_next,
    output logic [31:0]     pc,
    input logic             stall

);



    always_ff @( posedge clk, posedge rst )
    begin
        if(rst) begin
            pc              <=32'b0;
        end
        else if (!stall) begin
            pc              <=pc_next;
        end
        else begin
            pc              <= pc;
        end
    end
        

endmodule
