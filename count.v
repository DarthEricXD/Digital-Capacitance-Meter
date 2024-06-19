module count(
    input clk,    //ʱ���ź�
    input clear_n,    //�����ź�
	 input en,         //ʹ���ź�
    output  [3:0] dout,
    output reg co    //��λ�ź�
);

reg [3:0] cnt;     //���������ڼ�����һ��բ�������������źŵĸ���
assign dout = cnt;

always @(posedge clk or negedge clear_n) begin   //����������ģ��   
	 if(!clear_n)
        cnt <= 4'd0;
	 else if(cnt == 4'd9)
        cnt <= 4'd0;
	 else if(en)
		  cnt <= cnt + 1'b1;
    else
		  cnt <= cnt;
end

always @(cnt) begin    //��λ�źſ���ģ��
    if(cnt == 4'd9)
        co <= 1'd1;
    else 
        co <= 1'd0;
end

endmodule