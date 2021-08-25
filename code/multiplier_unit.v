
//乘法器所需的最小乘法单元模块
module multiplier_unit
(
	input                clk,						//时钟输入
	input                rst_n,          		//复位信号
	input      			   x_o,						//被乘数奇数位
	input      			   x_e,						//被乘数偶数位
	input      			   y_o,						//乘数奇数位
	input      			   y_e,						//乘数偶数位
	input      			   add_up_in,				//上通道加法器输入
	input      			   add_down_in,			//下通道加法器输入
	output reg           x_o_out,             //x奇数输出
	output reg           x_e_out,					//x偶数输出
	output               add_up_out,          //上通道加法器输出
	output               add_down_out          //下通道加法器输出	
);

reg                  c0, c1;							//全加器所用到触发器
wire   					up0, up1;						//上通道的两个与门
wire   					down0, down1;					//下通道的两个与门	
wire						add_up0_s, add_up1_s, add_down0_s, add_down1_s, 
							add_up0_c, add_up1_c, add_down0_c, add_down1_c;	//全加器的和与进位

//四个与门编写
assign						up0 = x_e_out & y_e;
assign						up1 = x_e_out & y_o;		//上通道与门
assign						down0 = x_o & y_e;
assign						down1 = x_o_out & y_o;	//下通道与门
//模块输出
assign                  add_up_out = add_up1_s;
assign                  add_down_out = add_down1_s;

//四个加法器编写
full_add  full_add_up0
(
	.cin		(add_up_in),
	.a			(up0),
	.b			(c1),
	.sum		(add_up0_s),
	.cout		(add_up0_c)	
);

full_add  full_add_up1
(
	.cin		(add_down0_s),
	.a			(up1),
	.b			(add_down1_c),
	.sum		(add_up1_s),
	.cout		(add_up1_c)	
);

full_add  full_add_down0
(
	.cin		(add_down_in),
	.a			(down0),
	.b			(add_up0_c),
	.sum		(add_down0_s),
	.cout		(add_down0_c)	
);

full_add  full_add_down1
(
	.cin		(add_up0_s),
	.a			(c0),
	.b			(down1),
	.sum		(add_down1_s),
	.cout		(add_down1_c)	
);

//四个D触发器编写
always @ ( posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		x_o_out <= 1'b0;
		x_e_out <= 1'b0;
		c0 <= 1'b0;
		c1 <= 1'b0;
	end
	else
	begin
		x_o_out <= x_o;
		x_e_out <= x_e;
		c0 <= add_up1_c;
		c1 <= add_down0_c;
	end
end

endmodule
		


