module top(
    input clk,    //ʱ���ź�
    input gate,   //բ���ź�
    output reg [11:0] lcd    //��������ܵ�ֵ
	 );

parameter [1:0]  IDLE = 2'b00;    //IDLE����״̬
parameter [1:0]  CLR = 2'b01;    //����״̬��ʵ�֣���gate�ź������غ�ĵ�һ��ʱ��������ʵ��
parameter [1:0]  CNT = 2'b10;    //�����źŵ�ʵ�֣���CLR�źź�ʱ�ӵ�������ʵ��
parameter [1:0]  LOCK = 2'b11;   //�����źŵ�ʵ�֣���gate�ź�Ϊ�͵�ƽʱʵ�֣�ʵ�ּ�������ֵ������

reg [1:0] now_state;    //��ǰ״̬
reg [1:0] next_state;   //��һʱ��״̬
reg clear_n;     //�����������ź�
reg en;      //������ʹ���ź�
wire [27:0] count_cnt;     //������
reg [27:0] lock;   //������

initial now_state = IDLE;

//����״̬����ʵ��
always @(posedge clk) begin
	now_state <= next_state;
end

always @(*) begin    //״̬ת�Ƶ�ʵ��
	case(now_state)
			IDLE: next_state <= CLR;
			CLR: next_state <= CNT;
			CNT: next_state <= (gate) ? CNT : LOCK;
			LOCK: next_state <= (gate) ? CLR : LOCK;
	endcase
end

always @(posedge clk) begin    //ת���߼���ʵ��
	case(now_state)
		CLR: begin 
					clear_n <= 1'b0;      //�������ź���0��������ʵ����0
					en <= 1'b0;      //��ʹ���ź�Ҳ��0
					lock <= lock;    //�����źŵ�ֵ����
	        end
	   CNT: begin
					clear_n <= 1'b1;    //�����ź���1
					en <= 1'b1;      //ʹ���ź���1����������������
					lock <= lock;    //�����źŵ�ֵ����
			  end
	   LOCK: begin
					clear_n <= 1'b1;  //��0��1
					en <= 1'b0;     //ʹ�ܹرգ�����������
					lock <= count_cnt;  //��������ʼ����
				end
	endcase
end

always @(*) begin      //����ת����ʾ��·
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
//�������������γ�28λ������
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