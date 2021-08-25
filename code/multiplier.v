
//64位双通道乘法器，顶层文件
module multiplier
(  
	input                clk_in,					//时钟输入
	input		     clk_en,					//时钟使能				
	input                rst_n,          		                //复位信号
	input     [63:0]     x,						//被乘数
	input     [63:0]     y,						//乘数
	output    [127:0]    p						//乘积   
);



wire                    up_0, up_1;						//前两位数输入端上通道的两个与门
wire                    down_0, down_1;						//前两位数输入端下通道的两个与门
wire								add_up_s, add_down_s, 
								add_up_c, add_down_c;				//前两位数用到的全加器的和与进位
wire								x_o_out0, x_o_out1, x_o_out2, x_o_out3, x_o_out4,
								x_o_out5, x_o_out6, x_o_out7, x_o_out8, x_o_out9,
								x_o_out10, x_o_out11, x_o_out12, x_o_out13, x_o_out14,
								x_o_out15, x_o_out16, x_o_out17, x_o_out18, x_o_out19,
								x_o_out20, x_o_out21, x_o_out22, x_o_out23, x_o_out24,
								x_o_out25, x_o_out26, x_o_out27, x_o_out28, x_o_out29,
								x_o_out30;															//例化所用的x奇数输出
wire								x_e_out0, x_e_out1, x_e_out2, x_e_out3, x_e_out4,
								x_e_out5, x_e_out6, x_e_out7, x_e_out8, x_e_out9,
								x_e_out10, x_e_out11, x_e_out12, x_e_out13, x_e_out14,
								x_e_out15, x_e_out16, x_e_out17, x_e_out18, x_e_out19,
								x_e_out20, x_e_out21, x_e_out22, x_e_out23, x_e_out24,
								x_e_out25, x_e_out26, x_e_out27, x_e_out28, x_e_out29,
								x_e_out30;															//例化所用的x偶数输出
wire								add_up_out0, add_up_out1, add_up_out2, add_up_out3, add_up_out4,
								add_up_out5, add_up_out6, add_up_out7, add_up_out8, add_up_out9,
								add_up_out10, add_up_out11, add_up_out12, add_up_out13, add_up_out14,
								add_up_out15, add_up_out16, add_up_out17, add_up_out18, add_up_out19,
								add_up_out20, add_up_out21, add_up_out22, add_up_out23, add_up_out24,
								add_up_out25, add_up_out26, add_up_out27, add_up_out28, add_up_out29,
								add_up_out30;								  //例化所用的上全加器输出
wire								add_down_out0, add_down_out1, add_down_out2, add_down_out3, add_down_out4,
								add_down_out5, add_down_out6, add_down_out7, add_down_out8, add_down_out9,
								add_down_out10, add_down_out11, add_down_out12, add_down_out13, add_down_out14,
								add_down_out15, add_down_out16, add_down_out17, add_down_out18, add_down_out19,
								add_down_out20, add_down_out21, add_down_out22, add_down_out23, add_down_out24,
								add_down_out25, add_down_out26, add_down_out27, add_down_out28, add_down_out29,
								add_down_out30;								//例化所用的下全加器输出
								
wire 				clk;			
wire				temp_en;					//门控时钟使能信号

wire		 [7:0]          cnt_out_1;							
wire		 [7:0]		cnt_in_1;
reg		 [7:0] 		cnt_out;					//输出所用计数器													
reg		 [7:0]          cnt_in;						//输入所用计数器
						
reg                    		x_even ,x_odd;					//上下通道的输入
reg				c;						//前两位数的全加器进位后的触发器
reg				x_odd_out;					//前两位数的下通道的移位


//门控时钟
assign						temp_en = (!clk_in) ? clk_en : temp_en;
assign						clk = clk_in & temp_en;
//前两位数所用到的的四个与门
assign						up_0 = x_even & y[0];
assign						up_1 = x_even & y[1];		//上通道与门
assign						down_0 = x_odd & y[0];
assign						down_1 = x_odd_out & y[1];	//下通道与门
//计数器
assign						cnt_in_1 = cnt_in + 8'd1;
assign						cnt_out_1 = cnt_out - 8'd2;



//输出结果
assign   					p[0] = (cnt_out_1 == 8'd0) ? add_down_out30 : p[0]; 
assign						p[1] = (cnt_out_1 == 8'd0) ? add_up_out30 : p[1];
assign   					p[2] = (cnt_out_1 == 8'd2) ? add_down_out30 : p[2]; 
assign						p[3] = (cnt_out_1 == 8'd2) ? add_up_out30 : p[3];
assign   					p[4] = (cnt_out_1 == 8'd4) ? add_down_out30 : p[4]; 
assign						p[5] = (cnt_out_1 == 8'd4) ? add_up_out30 : p[5];
assign   					p[6] = (cnt_out_1 == 8'd6) ? add_down_out30 : p[6]; 
assign						p[7] = (cnt_out_1 == 8'd6) ? add_up_out30 : p[7];
assign   					p[8] = (cnt_out_1 == 8'd8) ? add_down_out30 : p[8]; 
assign						p[9] = (cnt_out_1 == 8'd8) ? add_up_out30 : p[9];
assign   					p[10] = (cnt_out_1 == 8'd10) ? add_down_out30 : p[10]; 
assign						p[11] = (cnt_out_1 == 8'd10) ? add_up_out30 : p[11];
assign   					p[12] = (cnt_out_1 == 8'd12) ? add_down_out30 : p[12]; 
assign						p[13] = (cnt_out_1 == 8'd12) ? add_up_out30 : p[13];
assign   					p[14] = (cnt_out_1 == 8'd14) ? add_down_out30 : p[14]; 
assign						p[15] = (cnt_out_1 == 8'd14) ? add_up_out30 : p[15];
assign   					p[16] = (cnt_out_1 == 8'd16) ? add_down_out30 : p[16]; 
assign						p[17] = (cnt_out_1 == 8'd16) ? add_up_out30 : p[17];
assign   					p[18] = (cnt_out_1 == 8'd18) ? add_down_out30 : p[18]; 
assign						p[19] = (cnt_out_1 == 8'd18) ? add_up_out30 : p[19];
assign   					p[20] = (cnt_out_1 == 8'd20) ? add_down_out30 : p[20]; 
assign						p[21] = (cnt_out_1 == 8'd20) ? add_up_out30 : p[21];
assign   					p[22] = (cnt_out_1 == 8'd22) ? add_down_out30 : p[22]; 
assign						p[23] = (cnt_out_1 == 8'd22) ? add_up_out30 : p[23];
assign   					p[24] = (cnt_out_1 == 8'd24) ? add_down_out30 : p[24]; 
assign						p[25] = (cnt_out_1 == 8'd24) ? add_up_out30 : p[25];
assign   					p[26] = (cnt_out_1 == 8'd26) ? add_down_out30 : p[26]; 
assign						p[27] = (cnt_out_1 == 8'd26) ? add_up_out30 : p[27];
assign   					p[28] = (cnt_out_1 == 8'd28) ? add_down_out30 : p[28]; 
assign						p[29] = (cnt_out_1 == 8'd28) ? add_up_out30 : p[29];
assign   					p[30] = (cnt_out_1 == 8'd30) ? add_down_out30 : p[30]; 
assign						p[31] = (cnt_out_1 == 8'd30) ? add_up_out30 : p[31];
assign   					p[32] = (cnt_out_1 == 8'd32) ? add_down_out30 : p[32]; 
assign						p[33] = (cnt_out_1 == 8'd32) ? add_up_out30 : p[33];
assign   					p[34] = (cnt_out_1 == 8'd34) ? add_down_out30 : p[34]; 
assign						p[35] = (cnt_out_1 == 8'd34) ? add_up_out30 : p[35];
assign   					p[36] = (cnt_out_1 == 8'd36) ? add_down_out30 : p[36]; 
assign						p[37] = (cnt_out_1 == 8'd36) ? add_up_out30 : p[37];
assign   					p[38] = (cnt_out_1 == 8'd38) ? add_down_out30 : p[38]; 
assign						p[39] = (cnt_out_1 == 8'd38) ? add_up_out30 : p[39];
assign   					p[40] = (cnt_out_1 == 8'd40) ? add_down_out30 : p[40]; 
assign						p[41] = (cnt_out_1 == 8'd40) ? add_up_out30 : p[41];
assign   					p[42] = (cnt_out_1 == 8'd42) ? add_down_out30 : p[42]; 
assign						p[43] = (cnt_out_1 == 8'd42) ? add_up_out30 : p[43];
assign   					p[44] = (cnt_out_1 == 8'd44) ? add_down_out30 : p[44]; 
assign						p[45] = (cnt_out_1 == 8'd44) ? add_up_out30 : p[45];
assign   					p[46] = (cnt_out_1 == 8'd46) ? add_down_out30 : p[46]; 
assign						p[47] = (cnt_out_1 == 8'd46) ? add_up_out30 : p[47];
assign   					p[48] = (cnt_out_1 == 8'd48) ? add_down_out30 : p[48]; 
assign						p[49] = (cnt_out_1 == 8'd48) ? add_up_out30 : p[49];
assign   					p[50] = (cnt_out_1 == 8'd50) ? add_down_out30 : p[50]; 
assign						p[51] = (cnt_out_1 == 8'd50) ? add_up_out30 : p[51];
assign   					p[52] = (cnt_out_1 == 8'd52) ? add_down_out30 : p[52]; 
assign						p[53] = (cnt_out_1 == 8'd52) ? add_up_out30 : p[53];
assign   					p[54] = (cnt_out_1 == 8'd54) ? add_down_out30 : p[54]; 
assign						p[55] = (cnt_out_1 == 8'd54) ? add_up_out30 : p[55];
assign   					p[56] = (cnt_out_1 == 8'd56) ? add_down_out30 : p[56]; 
assign						p[57] = (cnt_out_1 == 8'd56) ? add_up_out30 : p[57];
assign   					p[58] = (cnt_out_1 == 8'd58) ? add_down_out30 : p[58]; 
assign						p[59] = (cnt_out_1 == 8'd58) ? add_up_out30 : p[59];
assign   					p[60] = (cnt_out_1 == 8'd60) ? add_down_out30 : p[60]; 
assign						p[61] = (cnt_out_1 == 8'd60) ? add_up_out30 : p[61];
assign   					p[62] = (cnt_out_1 == 8'd62) ? add_down_out30 : p[62]; 
assign						p[63] = (cnt_out_1 == 8'd62) ? add_up_out30 : p[63];
assign   					p[64] = (cnt_out_1 == 8'd64) ? add_down_out30 : p[64]; 
assign						p[65] = (cnt_out_1 == 8'd64) ? add_up_out30 : p[65];
assign   					p[66] = (cnt_out_1 == 8'd66) ? add_down_out30 : p[66]; 
assign						p[67] = (cnt_out_1 == 8'd66) ? add_up_out30 : p[67];
assign   					p[68] = (cnt_out_1 == 8'd68) ? add_down_out30 : p[68]; 
assign						p[69] = (cnt_out_1 == 8'd68) ? add_up_out30 : p[69];
assign   					p[70] = (cnt_out_1 == 8'd70) ? add_down_out30 : p[70]; 
assign						p[71] = (cnt_out_1 == 8'd70) ? add_up_out30 : p[71];
assign   					p[72] = (cnt_out_1 == 8'd72) ? add_down_out30 : p[72]; 
assign						p[73] = (cnt_out_1 == 8'd72) ? add_up_out30 : p[73];
assign   					p[74] = (cnt_out_1 == 8'd74) ? add_down_out30 : p[74]; 
assign						p[75] = (cnt_out_1 == 8'd74) ? add_up_out30 : p[75];
assign   					p[76] = (cnt_out_1 == 8'd76) ? add_down_out30 : p[76]; 
assign						p[77] = (cnt_out_1 == 8'd76) ? add_up_out30 : p[77];
assign   					p[78] = (cnt_out_1 == 8'd78) ? add_down_out30 : p[78]; 
assign						p[79] = (cnt_out_1 == 8'd78) ? add_up_out30 : p[79];
assign   					p[80] = (cnt_out_1 == 8'd80) ? add_down_out30 : p[80]; 
assign						p[81] = (cnt_out_1 == 8'd80) ? add_up_out30 : p[81];
assign   					p[82] = (cnt_out_1 == 8'd82) ? add_down_out30 : p[82]; 
assign						p[83] = (cnt_out_1 == 8'd82) ? add_up_out30 : p[83];
assign   					p[84] = (cnt_out_1 == 8'd84) ? add_down_out30 : p[84]; 
assign						p[85] = (cnt_out_1 == 8'd84) ? add_up_out30 : p[85];
assign   					p[86] = (cnt_out_1 == 8'd86) ? add_down_out30 : p[86]; 
assign						p[87] = (cnt_out_1 == 8'd86) ? add_up_out30 : p[87];
assign   					p[88] = (cnt_out_1 == 8'd88) ? add_down_out30 : p[88]; 
assign						p[89] = (cnt_out_1 == 8'd88) ? add_up_out30 : p[89];
assign   					p[90] = (cnt_out_1 == 8'd90) ? add_down_out30 : p[90]; 
assign						p[91] = (cnt_out_1 == 8'd90) ? add_up_out30 : p[91];
assign   					p[92] = (cnt_out_1 == 8'd92) ? add_down_out30 : p[92]; 
assign						p[93] = (cnt_out_1 == 8'd92) ? add_up_out30 : p[93];
assign   					p[94] = (cnt_out_1 == 8'd94) ? add_down_out30 : p[94]; 
assign						p[95] = (cnt_out_1 == 8'd94) ? add_up_out30 : p[95];
assign   					p[96] = (cnt_out_1 == 8'd96) ? add_down_out30 : p[96]; 
assign						p[97] = (cnt_out_1 == 8'd96) ? add_up_out30 : p[97];
assign   					p[98] = (cnt_out_1 == 8'd98) ? add_down_out30 : p[98]; 
assign						p[99] = (cnt_out_1 == 8'd98) ? add_up_out30 : p[99];
assign   					p[100] = (cnt_out_1 == 8'd100) ? add_down_out30 : p[100]; 
assign						p[101] = (cnt_out_1 == 8'd100) ? add_up_out30 : p[101];
assign   					p[102] = (cnt_out_1 == 8'd102) ? add_down_out30 : p[102]; 
assign						p[103] = (cnt_out_1 == 8'd102) ? add_up_out30 : p[103];
assign   					p[104] = (cnt_out_1 == 8'd104) ? add_down_out30 : p[104]; 
assign						p[105] = (cnt_out_1 == 8'd104) ? add_up_out30 : p[105];
assign   					p[106] = (cnt_out_1 == 8'd106) ? add_down_out30 : p[106]; 
assign						p[107] = (cnt_out_1 == 8'd106) ? add_up_out30 : p[107];
assign   					p[108] = (cnt_out_1 == 8'd108) ? add_down_out30 : p[108]; 
assign						p[109] = (cnt_out_1 == 8'd108) ? add_up_out30 : p[109];
assign   					p[110] = (cnt_out_1 == 8'd110) ? add_down_out30 : p[110]; 
assign						p[111] = (cnt_out_1 == 8'd110) ? add_up_out30 : p[111];
assign   					p[112] = (cnt_out_1 == 8'd112) ? add_down_out30 : p[112]; 
assign						p[113] = (cnt_out_1 == 8'd112) ? add_up_out30 : p[113];
assign   					p[114] = (cnt_out_1 == 8'd114) ? add_down_out30 : p[114]; 
assign						p[115] = (cnt_out_1 == 8'd114) ? add_up_out30 : p[115];
assign   					p[116] = (cnt_out_1 == 8'd116) ? add_down_out30 : p[116]; 
assign						p[117] = (cnt_out_1 == 8'd116) ? add_up_out30 : p[117];
assign   					p[118] = (cnt_out_1 == 8'd118) ? add_down_out30 : p[118]; 
assign						p[119] = (cnt_out_1 == 8'd118) ? add_up_out30 : p[119];
assign   					p[120] = (cnt_out_1 == 8'd120) ? add_down_out30 : p[120]; 
assign						p[121] = (cnt_out_1 == 8'd120) ? add_up_out30 : p[121];
assign   					p[122] = (cnt_out_1 == 8'd122) ? add_down_out30 : p[122]; 
assign						p[123] = (cnt_out_1 == 8'd122) ? add_up_out30 : p[123];
assign   					p[124] = (cnt_out_1 == 8'd124) ? add_down_out30 : p[124]; 
assign						p[125] = (cnt_out_1 == 8'd124) ? add_up_out30 : p[125];
assign   					p[126] = (cnt_out_1 == 8'd126) ? add_down_out30 : p[126]; 
assign						p[127] = (cnt_out_1 == 8'd126) ? add_up_out30 : p[127];




//前两位用到的两个全加器
full_add  full_add_up
(
	.cin		(down_0),
	.a			(up_1),
	.b			(add_down_c),
	.sum		(add_up_s),
	.cout		(add_up_c)	
);

full_add  full_add_down
(
	.cin		(up_0),
	.a			(down_1),
	.b			(c),
	.sum		(add_down_s),
	.cout		(add_down_c)	
);


//前两位数所用到的寄存器
always @ ( posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		x_odd_out <= 1'b0;
		c <= 1'b0;
	end
	else
	begin
		x_odd_out <= x_odd;
		c <= add_up_c;
	end
end


//对输入、输出、计数器的赋值
always @ (posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		cnt_in <= 8'd0;
		x_even <= 1'b0;
		x_odd <= 1'b0;
	end							//复位清零	
	else if(cnt_in >= 8'd64)
	begin
		cnt_in <= 8'd66;
		x_even <= 1'b0;
		x_odd <= 1'b0;		
	end
	else
	begin
		cnt_in <= cnt_in + 8'd2;
		x_even <= x[cnt_in];
		x_odd <= x[cnt_in_1];								    
	end
end

always @ (negedge clk or negedge rst_n)
begin
	if(!rst_n)
		cnt_out <= 8'd0;		//复位清零
	else if(cnt_out >= 8'd128)
		cnt_out <= 8'd130;
	else
		cnt_out <= cnt_out + 8'd2;							    
end


//31个乘法器单元的例化
multiplier_unit	multiplier_unit0
(
	.clk				(clk),				//时钟输入
	.rst_n				(rst_n),          		//复位信号
	.x_o				(x_odd_out),			//被乘数奇数位
	.x_e				(x_even),			//被乘数偶数位
	.y_o				(y[3]),				//乘数奇数位
	.y_e				(y[2]),				//乘数偶数位
	.add_up_in			(add_down_s),			//上通道加法器输入
	.add_down_in			(add_up_s),			//下通道加法器输入
	.x_o_out			(x_o_out0),             //x奇数输出
	.x_e_out			(x_e_out0),		//x偶数输出
	.add_up_out			(add_up_out0),          //上通道加法器输出
	.add_down_out  			(add_down_out0)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit1
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out0),				//被乘数奇数位
	.x_e				(x_e_out0),					//被乘数偶数位
	.y_o				(y[5]),					//乘数奇数位
	.y_e				(y[4]),					//乘数偶数位
	.add_up_in		(add_down_out0),				//上通道加法器输入
	.add_down_in	(add_up_out0),					//下通道加法器输入
	.x_o_out			(x_o_out1),             //x奇数输出
	.x_e_out			(x_e_out1),					//x偶数输出
	.add_up_out		(add_up_out1),          //上通道加法器输出
	.add_down_out  (add_down_out1)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit2
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out1),				//被乘数奇数位
	.x_e				(x_e_out1),					//被乘数偶数位
	.y_o				(y[7]),					//乘数奇数位
	.y_e				(y[6]),					//乘数偶数位
	.add_up_in		(add_down_out1),				//上通道加法器输入
	.add_down_in	(add_up_out1),					//下通道加法器输入
	.x_o_out			(x_o_out2),             //x奇数输出
	.x_e_out			(x_e_out2),					//x偶数输出
	.add_up_out		(add_up_out2),          //上通道加法器输出
	.add_down_out  (add_down_out2)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit3
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out2),				//被乘数奇数位
	.x_e				(x_e_out2),					//被乘数偶数位
	.y_o				(y[9]),					//乘数奇数位
	.y_e				(y[8]),					//乘数偶数位
	.add_up_in		(add_down_out2),				//上通道加法器输入
	.add_down_in	(add_up_out2),					//下通道加法器输入
	.x_o_out			(x_o_out3),             //x奇数输出
	.x_e_out			(x_e_out3),					//x偶数输出
	.add_up_out		(add_up_out3),          //上通道加法器输出
	.add_down_out  (add_down_out3)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit4
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out3),				//被乘数奇数位
	.x_e				(x_e_out3),					//被乘数偶数位
	.y_o				(y[11]),					//乘数奇数位
	.y_e				(y[10]),					//乘数偶数位
	.add_up_in		(add_down_out3),				//上通道加法器输入
	.add_down_in	(add_up_out3),					//下通道加法器输入
	.x_o_out			(x_o_out4),             //x奇数输出
	.x_e_out			(x_e_out4),					//x偶数输出
	.add_up_out		(add_up_out4),          //上通道加法器输出
	.add_down_out  (add_down_out4)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit5
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out4),				//被乘数奇数位
	.x_e				(x_e_out4),					//被乘数偶数位
	.y_o				(y[13]),					//乘数奇数位
	.y_e				(y[12]),					//乘数偶数位
	.add_up_in		(add_down_out4),				//上通道加法器输入
	.add_down_in	(add_up_out4),					//下通道加法器输入
	.x_o_out			(x_o_out5),             //x奇数输出
	.x_e_out			(x_e_out5),					//x偶数输出
	.add_up_out		(add_up_out5),          //上通道加法器输出
	.add_down_out  (add_down_out5)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit6
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out5),				//被乘数奇数位
	.x_e				(x_e_out5),					//被乘数偶数位
	.y_o				(y[15]),					//乘数奇数位
	.y_e				(y[14]),					//乘数偶数位
	.add_up_in		(add_down_out5),				//上通道加法器输入
	.add_down_in	(add_up_out5),					//下通道加法器输入
	.x_o_out			(x_o_out6),             //x奇数输出
	.x_e_out			(x_e_out6),					//x偶数输出
	.add_up_out		(add_up_out6),          //上通道加法器输出
	.add_down_out  (add_down_out6)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit7
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out6),				//被乘数奇数位
	.x_e				(x_e_out6),					//被乘数偶数位
	.y_o				(y[17]),					//乘数奇数位
	.y_e				(y[16]),					//乘数偶数位
	.add_up_in		(add_down_out6),				//上通道加法器输入
	.add_down_in	(add_up_out6),					//下通道加法器输入
	.x_o_out			(x_o_out7),             //x奇数输出
	.x_e_out			(x_e_out7),					//x偶数输出
	.add_up_out		(add_up_out7),          //上通道加法器输出
	.add_down_out  (add_down_out7)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit8
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out7),				//被乘数奇数位
	.x_e				(x_e_out7),					//被乘数偶数位
	.y_o				(y[19]),					//乘数奇数位
	.y_e				(y[18]),					//乘数偶数位
	.add_up_in		(add_down_out7),				//上通道加法器输入
	.add_down_in	(add_up_out7),					//下通道加法器输入
	.x_o_out			(x_o_out8),             //x奇数输出
	.x_e_out			(x_e_out8),					//x偶数输出
	.add_up_out		(add_up_out8),          //上通道加法器输出
	.add_down_out  (add_down_out8)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit9
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out8),				//被乘数奇数位
	.x_e				(x_e_out8),					//被乘数偶数位
	.y_o				(y[21]),					//乘数奇数位
	.y_e				(y[20]),					//乘数偶数位
	.add_up_in		(add_down_out8),				//上通道加法器输入
	.add_down_in	(add_up_out8),					//下通道加法器输入
	.x_o_out			(x_o_out9),             //x奇数输出
	.x_e_out			(x_e_out9),					//x偶数输出
	.add_up_out		(add_up_out9),          //上通道加法器输出
	.add_down_out  (add_down_out9)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit10
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out9),				//被乘数奇数位
	.x_e				(x_e_out9),					//被乘数偶数位
	.y_o				(y[23]),					//乘数奇数位
	.y_e				(y[22]),					//乘数偶数位
	.add_up_in		(add_down_out9),				//上通道加法器输入
	.add_down_in	(add_up_out9),					//下通道加法器输入
	.x_o_out			(x_o_out10),             //x奇数输出
	.x_e_out			(x_e_out10),					//x偶数输出
	.add_up_out		(add_up_out10),          //上通道加法器输出
	.add_down_out  (add_down_out10)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit11
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out10),				//被乘数奇数位
	.x_e				(x_e_out10),					//被乘数偶数位
	.y_o				(y[25]),					//乘数奇数位
	.y_e				(y[24]),					//乘数偶数位
	.add_up_in		(add_down_out10),				//上通道加法器输入
	.add_down_in	(add_up_out10),					//下通道加法器输入
	.x_o_out			(x_o_out11),             //x奇数输出
	.x_e_out			(x_e_out11),					//x偶数输出
	.add_up_out		(add_up_out11),          //上通道加法器输出
	.add_down_out  (add_down_out11)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit12
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out11),				//被乘数奇数位
	.x_e				(x_e_out11),					//被乘数偶数位
	.y_o				(y[27]),					//乘数奇数位
	.y_e				(y[26]),					//乘数偶数位
	.add_up_in		(add_down_out11),				//上通道加法器输入
	.add_down_in	(add_up_out11),					//下通道加法器输入
	.x_o_out			(x_o_out12),             //x奇数输出
	.x_e_out			(x_e_out12),					//x偶数输出
	.add_up_out		(add_up_out12),          //上通道加法器输出
	.add_down_out  (add_down_out12)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit13
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out12),				//被乘数奇数位
	.x_e				(x_e_out12),					//被乘数偶数位
	.y_o				(y[29]),					//乘数奇数位
	.y_e				(y[28]),					//乘数偶数位
	.add_up_in		(add_down_out12),				//上通道加法器输入
	.add_down_in	(add_up_out12),					//下通道加法器输入
	.x_o_out			(x_o_out13),             //x奇数输出
	.x_e_out			(x_e_out13),					//x偶数输出
	.add_up_out		(add_up_out13),          //上通道加法器输出
	.add_down_out  (add_down_out13)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit14
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out13),				//被乘数奇数位
	.x_e				(x_e_out13),					//被乘数偶数位
	.y_o				(y[31]),					//乘数奇数位
	.y_e				(y[30]),					//乘数偶数位
	.add_up_in		(add_down_out13),				//上通道加法器输入
	.add_down_in	(add_up_out13),					//下通道加法器输入
	.x_o_out			(x_o_out14),             //x奇数输出
	.x_e_out			(x_e_out14),					//x偶数输出
	.add_up_out		(add_up_out14),          //上通道加法器输出
	.add_down_out  (add_down_out14)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit15
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out14),				//被乘数奇数位
	.x_e				(x_e_out14),					//被乘数偶数位
	.y_o				(y[33]),					//乘数奇数位
	.y_e				(y[32]),					//乘数偶数位
	.add_up_in		(add_down_out14),				//上通道加法器输入
	.add_down_in	(add_up_out14),					//下通道加法器输入
	.x_o_out			(x_o_out15),             //x奇数输出
	.x_e_out			(x_e_out15),					//x偶数输出
	.add_up_out		(add_up_out15),          //上通道加法器输出
	.add_down_out  (add_down_out15)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit16
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out15),				//被乘数奇数位
	.x_e				(x_e_out15),					//被乘数偶数位
	.y_o				(y[35]),					//乘数奇数位
	.y_e				(y[34]),					//乘数偶数位
	.add_up_in		(add_down_out15),				//上通道加法器输入
	.add_down_in	(add_up_out15),					//下通道加法器输入
	.x_o_out			(x_o_out16),             //x奇数输出
	.x_e_out			(x_e_out16),					//x偶数输出
	.add_up_out		(add_up_out16),          //上通道加法器输出
	.add_down_out  (add_down_out16)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit17
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out16),				//被乘数奇数位
	.x_e				(x_e_out16),					//被乘数偶数位
	.y_o				(y[37]),					//乘数奇数位
	.y_e				(y[36]),					//乘数偶数位
	.add_up_in		(add_down_out16),				//上通道加法器输入
	.add_down_in	(add_up_out16),					//下通道加法器输入
	.x_o_out			(x_o_out17),             //x奇数输出
	.x_e_out			(x_e_out17),					//x偶数输出
	.add_up_out		(add_up_out17),          //上通道加法器输出
	.add_down_out  (add_down_out17)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit18
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out17),				//被乘数奇数位
	.x_e				(x_e_out17),					//被乘数偶数位
	.y_o				(y[39]),					//乘数奇数位
	.y_e				(y[38]),					//乘数偶数位
	.add_up_in		(add_down_out17),				//上通道加法器输入
	.add_down_in	(add_up_out17),					//下通道加法器输入
	.x_o_out			(x_o_out18),             //x奇数输出
	.x_e_out			(x_e_out18),					//x偶数输出
	.add_up_out		(add_up_out18),          //上通道加法器输出
	.add_down_out  (add_down_out18)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit19
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out18),				//被乘数奇数位
	.x_e				(x_e_out18),					//被乘数偶数位
	.y_o				(y[41]),					//乘数奇数位
	.y_e				(y[40]),					//乘数偶数位
	.add_up_in		(add_down_out18),				//上通道加法器输入
	.add_down_in	(add_up_out18),					//下通道加法器输入
	.x_o_out			(x_o_out19),             //x奇数输出
	.x_e_out			(x_e_out19),					//x偶数输出
	.add_up_out		(add_up_out19),          //上通道加法器输出
	.add_down_out  (add_down_out19)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit20
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out19),				//被乘数奇数位
	.x_e				(x_e_out19),					//被乘数偶数位
	.y_o				(y[43]),					//乘数奇数位
	.y_e				(y[42]),					//乘数偶数位
	.add_up_in		(add_down_out19),				//上通道加法器输入
	.add_down_in	(add_up_out19),					//下通道加法器输入
	.x_o_out			(x_o_out20),             //x奇数输出
	.x_e_out			(x_e_out20),					//x偶数输出
	.add_up_out		(add_up_out20),          //上通道加法器输出
	.add_down_out  (add_down_out20)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit21
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out20),				//被乘数奇数位
	.x_e				(x_e_out20),					//被乘数偶数位
	.y_o				(y[45]),					//乘数奇数位
	.y_e				(y[44]),					//乘数偶数位
	.add_up_in		(add_down_out20),				//上通道加法器输入
	.add_down_in	(add_up_out20),					//下通道加法器输入
	.x_o_out			(x_o_out21),             //x奇数输出
	.x_e_out			(x_e_out21),					//x偶数输出
	.add_up_out		(add_up_out21),          //上通道加法器输出
	.add_down_out  (add_down_out21)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit22
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out21),				//被乘数奇数位
	.x_e				(x_e_out21),					//被乘数偶数位
	.y_o				(y[47]),					//乘数奇数位
	.y_e				(y[46]),					//乘数偶数位
	.add_up_in		(add_down_out21),				//上通道加法器输入
	.add_down_in	(add_up_out21),					//下通道加法器输入
	.x_o_out			(x_o_out22),             //x奇数输出
	.x_e_out			(x_e_out22),					//x偶数输出
	.add_up_out		(add_up_out22),          //上通道加法器输出
	.add_down_out  (add_down_out22)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit23
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out22),				//被乘数奇数位
	.x_e				(x_e_out22),					//被乘数偶数位
	.y_o				(y[49]),					//乘数奇数位
	.y_e				(y[48]),					//乘数偶数位
	.add_up_in		(add_down_out22),				//上通道加法器输入
	.add_down_in	(add_up_out22),					//下通道加法器输入
	.x_o_out			(x_o_out23),             //x奇数输出
	.x_e_out			(x_e_out23),					//x偶数输出
	.add_up_out		(add_up_out23),          //上通道加法器输出
	.add_down_out  (add_down_out23)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit24
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out23),				//被乘数奇数位
	.x_e				(x_e_out23),					//被乘数偶数位
	.y_o				(y[51]),					//乘数奇数位
	.y_e				(y[50]),					//乘数偶数位
	.add_up_in		(add_down_out23),				//上通道加法器输入
	.add_down_in	(add_up_out23),					//下通道加法器输入
	.x_o_out			(x_o_out24),             //x奇数输出
	.x_e_out			(x_e_out24),					//x偶数输出
	.add_up_out		(add_up_out24),          //上通道加法器输出
	.add_down_out  (add_down_out24)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit25
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out24),				//被乘数奇数位
	.x_e				(x_e_out24),					//被乘数偶数位
	.y_o				(y[53]),					//乘数奇数位
	.y_e				(y[52]),					//乘数偶数位
	.add_up_in		(add_down_out24),				//上通道加法器输入
	.add_down_in	(add_up_out24),					//下通道加法器输入
	.x_o_out			(x_o_out25),             //x奇数输出
	.x_e_out			(x_e_out25),					//x偶数输出
	.add_up_out		(add_up_out25),          //上通道加法器输出
	.add_down_out  (add_down_out25)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit26
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out25),				//被乘数奇数位
	.x_e				(x_e_out25),					//被乘数偶数位
	.y_o				(y[55]),					//乘数奇数位
	.y_e				(y[54]),					//乘数偶数位
	.add_up_in		(add_down_out25),				//上通道加法器输入
	.add_down_in	(add_up_out25),					//下通道加法器输入
	.x_o_out			(x_o_out26),             //x奇数输出
	.x_e_out			(x_e_out26),					//x偶数输出
	.add_up_out		(add_up_out26),          //上通道加法器输出
	.add_down_out  (add_down_out26)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit27
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out26),				//被乘数奇数位
	.x_e				(x_e_out26),					//被乘数偶数位
	.y_o				(y[57]),					//乘数奇数位
	.y_e				(y[56]),					//乘数偶数位
	.add_up_in		(add_down_out26),				//上通道加法器输入
	.add_down_in	(add_up_out26),					//下通道加法器输入
	.x_o_out			(x_o_out27),             //x奇数输出
	.x_e_out			(x_e_out27),					//x偶数输出
	.add_up_out		(add_up_out27),          //上通道加法器输出
	.add_down_out  (add_down_out27)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit28
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out27),				//被乘数奇数位
	.x_e				(x_e_out27),					//被乘数偶数位
	.y_o				(y[59]),					//乘数奇数位
	.y_e				(y[58]),					//乘数偶数位
	.add_up_in		(add_down_out27),				//上通道加法器输入
	.add_down_in	(add_up_out27),					//下通道加法器输入
	.x_o_out			(x_o_out28),             //x奇数输出
	.x_e_out			(x_e_out28),					//x偶数输出
	.add_up_out		(add_up_out28),          //上通道加法器输出
	.add_down_out  (add_down_out28)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit29
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out28),				//被乘数奇数位
	.x_e				(x_e_out28),					//被乘数偶数位
	.y_o				(y[61]),					//乘数奇数位
	.y_e				(y[60]),					//乘数偶数位
	.add_up_in		(add_down_out28),				//上通道加法器输入
	.add_down_in	(add_up_out28),					//下通道加法器输入
	.x_o_out			(x_o_out29),             //x奇数输出
	.x_e_out			(x_e_out29),					//x偶数输出
	.add_up_out		(add_up_out29),          //上通道加法器输出
	.add_down_out  (add_down_out29)         //下通道加法器输出	
);

multiplier_unit	multiplier_unit30
(
	.clk				(clk),						//时钟输入
	.rst_n			(rst_n),          		//复位信号
	.x_o				(x_o_out29),				//被乘数奇数位
	.x_e				(x_e_out29),					//被乘数偶数位
	.y_o				(y[63]),					//乘数奇数位
	.y_e				(y[62]),					//乘数偶数位
	.add_up_in		(add_down_out29),				//上通道加法器输入
	.add_down_in	(add_up_out29),					//下通道加法器输入
	.x_o_out			(x_o_out30),             //x奇数输出
	.x_e_out			(x_e_out30),					//x偶数输出
	.add_up_out		(add_up_out30),          //上通道加法器输出
	.add_down_out  (add_down_out30)         //下通道加法器输出	
);

endmodule










	
