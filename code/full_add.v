
//全加器模块
module full_add
(
	input     cin,				// 进位输入
	input	  a,				//加数1
	input 	  b,				//加数2
	output 	  sum,				//和
	output	  cout				// 进位输出
);


assign     sum = a ^ b ^ cin;
assign     cout = a & b | (a ^ b) & cin;

endmodule
