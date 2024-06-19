`timescale 1ns / 1ps

module tb_top();
reg clk;
reg gate;
wire [11:0] lcd;

top u_top(
    .clk        (clk), 
    .gate       (gate),
    .lcd  (lcd)
    );
    
initial begin
    clk = 0;
    gate = 0;
    forever #60000 gate = ~gate;
end

always #20 clk = ~clk;
endmodule
