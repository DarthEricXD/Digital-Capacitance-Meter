module top(
    input clk,    //时基信号
    input gate,   //闸门信号
    output reg [11:0] lcd    //输入数码管的值
	 );

parameter [1:0]  IDLE = 2'b00;    //IDLE空闲状态
parameter [1:0]  CLR = 2'b01;    //清零状态的实现，在gate信号上升沿后的第一个时钟周期内实现
parameter [1:0]  CNT = 2'b10;    //计数信号的实现，在CLR信号后时钟的上升沿实现
parameter [1:0]  LOCK = 2'b11;   //锁存信号的实现，在gate信号为低电平时实现，实现计数器数值的所存

reg [1:0] now_state;    //当前状态
reg [1:0] next_state;   //下一时刻状态
reg clear_n;     //计数器清零信号
reg en;      //计数器使能信号
wire [27:0] count_cnt;     //计数器
reg [27:0] lock;   //锁存器

initial now_state = IDLE;

//有限状态机的实现
always @(posedge clk) begin
	now_state <= next_state;
end

always @(*) begin    //状态转移的实现
	case(now_state)
			IDLE: next_state <= CLR;
			CLR: next_state <= CNT;
			CNT: next_state <= (gate) ? CNT : LOCK;
			LOCK: next_state <= (gate) ? CLR : LOCK;
	endcase
end

always @(posedge clk) begin    //转移逻辑的实现
	case(now_state)
		CLR: begin 
					clear_n <= 1'b0;      //将清零信号置0，计数器实现清0
					en <= 1'b0;      //将使能信号也置0
					lock <= lock;    //锁存信号的值不变
	        end
	   CNT: begin
					clear_n <= 1'b1;    //清零信号置1
					en <= 1'b1;      //使能信号置1，计数器正常工作
					lock <= lock;    //锁存信号的值不变
			  end
	   LOCK: begin
					clear_n <= 1'b1;  //清0置1
					en <= 1'b0;     //使能关闭，计数器保持
					lock <= count_cnt;  //锁存器开始工作
				end
	endcase
end

always @(*) begin      //倍率转换显示电路
	if(!lock[23:4] || lock[27:24])
		lcd <= {lock[3:0],4'd0,4'd0};
	else if(!lock[23:8])
		lcd <= {lock[7:0],4'd1};
	else if(!lock[23:12])
		lcd <= {lock[11:4],4'd2};
	else if(!lock[23:16])
		lcd <= {lock[15:8],4'd3};
	else if(!lock[23:20])
		lcd <= {lock[19:12],4'd4};
	else 
		lcd <= {lock[23:16],4'd5};
end
//计数器级联，形成28位计数器
count count1(
    .clk       (clk),    
    .clear_n   (clear_n), 
	 .en        (en),
    .dout      (count_cnt[3:0]),
    .co        (co1)
    );
count count2(
    .clk       (~co1),    
    .clear_n   (clear_n),
	 .en        (en),
    .dout      (count_cnt[7:4]),
    .co        (co2)
    );    
count count3(
    .clk       (~co2),    
    .clear_n   (clear_n),
	 .en        (en),
    .dout      (count_cnt[11:8]),
    .co        (co3)
    );    
count count4(
    .clk       (~co3),    
    .clear_n   (clear_n),
	 .en        (en),
    .dout      (count_cnt[15:12]),
    .co        (co4)
    );    
count count5(
    .clk       (~co4),    
    .clear_n   (clear_n),
	 .en        (en),
    .dout      (count_cnt[19:16]),
    .co        (co5)
    );    
count count6(
    .clk       (~co5),    
    .clear_n   (clear_n),
	 .en        (en),
    .dout      (count_cnt[23:20]),
    .co        (co6)
    );    
count count7(
    .clk       (~co6),    
    .clear_n   (clear_n),
	 .en        (en),
    .dout      (count_cnt[27:24]),
    .co        (x)
    );   
 
endmodule