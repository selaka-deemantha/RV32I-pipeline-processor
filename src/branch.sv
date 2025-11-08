module branch (op_a,op_b,fun3,en,result);

   input logic [31:0] op_a, op_b;
   input logic [2:0]  fun3;
   input en;

   output logic result;

   always_comb begin
      if(en==1)begin
         case (fun3)
            3'b000 : result = (op_a == op_b) ? 1 : 0 ;                     //beq
            3'b001 : result = (op_a != op_b) ? 1 : 0 ;                     //bne
            3'b100 : result = ($signed (op_a) < $signed (op_b)) ? 1 : 0 ;  //blt 
            3'b101 : result = ($signed (op_a) >= $signed (op_b)) ? 1 : 0 ; //bge
            3'b110 : result = (op_a < op_b) ? 1 : 0 ;                      //bltu
            3'b111 : result = (op_a >= op_b) ? 1 : 0 ;                     //bgeu
         endcase
      end
      else begin
         result = 0;
      end
   end
   
endmodule