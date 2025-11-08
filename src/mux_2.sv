module mux_2(
    a,
    b,
    sel,
    c
);

input logic [31:0] a,b;
input logic sel;
output logic [31:0] c;

assign c = (sel) ? b : a;

endmodule