module buffer_reg #(parameter buff_len = 4) (q, x, load, clk, clr);

input [buff_len - 1 : 0] x;
input load, clk, clr; 
output [buff_len - 1 : 0] q;

wire [buff_len - 1 : 0] d;

// Long-form assignments for each bit
assign d[0] = (x[0] & load) | ((~load) & q[0]);
assign d[1] = (x[1] & load) | ((~load) & q[1]);
assign d[2] = (x[2] & load) | ((~load) & q[2]);
assign d[3] = (x[3] & load) | ((~load) & q[3]);

// Long-form instantiations for each flip-flop
dff_new u_dff0(q[0], d[0], clk, clr);
dff_new u_dff1(q[1], d[1], clk, clr);
dff_new u_dff2(q[2], d[2], clk, clr);
dff_new u_dff3(q[3], d[3], clk, clr);

endmodule