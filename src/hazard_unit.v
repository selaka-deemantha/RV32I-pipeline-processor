module hazard_unit
(
    input logic clk,
    input logic rst,

    // source register addresses in decode stage
    input logic [4:0] rs_1d,
    input logic [4:0] rs_2d,

    // source register addresses in execute stage
    input logic [4:0] rs_1e,
    input logic [4:0] rs_2e,

    // destination register addresses in memory and writeback stages
    input logic [4:0] rd_m,
    input logic [4:0] rd_w,

    // write back control signals from memory and writeback stages
    input logic reg_write_m,
    input logic reg_write_w,

    output logic [1:0] forward_a,
    output logic [1:0] forward_b

);

    always @(*) begin
        if(rst) begin
            forward_a <= 0;
            forward_b <= 0;
        end
        else begin
            // Forwarding for source operand A
            if((reg_write_m) && (rd_m != 0) && (rd_m == rs_1e)) begin
                forward_a <= 2'b10; // Forward from memory stage
            end
            else if((reg_write_w) && (rd_w != 0) && (rd_w == rs_1e)) begin
                forward_a <= 2'b01; // Forward from writeback stage
            end
            else begin
                forward_a <= 2'b00; // No forwarding
            end

            // Forwarding for source operand B
            if((reg_write_m) && (rd_m != 0) && (rd_m == rs_2e)) begin
                forward_b <= 2'b10; // Forward from memory stage
            end
            else if((reg_write_w) && (rd_w != 0) && (rd_w == rs_2e)) begin
                forward_b <= 2'b01; // Forward from writeback stage
            end
            else begin
                forward_b <= 2'b00; // No forwarding
            end


        end

    end


endmodule

