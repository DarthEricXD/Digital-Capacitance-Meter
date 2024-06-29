module count(
    input clk,    //时基信号
    input clear_n,    //清零信号
	 input en,         //使能信号
    output  [3:0] dout,
    output reg co    //进位信号
);

reg [3:0] cnt;     //计数器用于计算在一个闸门周期内脉冲信号的个数
assign dout = cnt;

always @(posedge clk or negedge clear_n) begin   //计数器计数模块   
	 if(!clear_n)
        cnt <= 4'd0;
	 else if(cnt == 4'd9)
        cnt <= 4'd0;
	 else if(en)
		  cnt <= cnt + 1'b1;
    else
		  cnt <= cnt;
end

always @(cnt) begin    //进位信号控制模块
    if(cnt == 4'd9)
        co <= 1'd1;
    else 
        co <= 1'd0;
end

endmodule
