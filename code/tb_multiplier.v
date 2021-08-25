
//乘法器testbench
`timescale 1ns/1ns
module  tb_multiplier;
  
    reg             sys_clk     ;
    reg             sys_rst_n   ;
    reg     [63:0]     x        ;
    reg     [63:0]     y        ;
    reg                clk_en   ;       
    wire    [127:0]    p        ;
 
initial
    begin
        sys_clk = 1'b0;
        sys_rst_n   = 1'b1;
        clk_en    = 1'b0;
        #100
        clk_en  = 1'b1;
        #100
        sys_rst_n   = 1'b0;
        #100
        sys_rst_n   = 1'b1;               
    end
    
always #10 sys_clk = ~sys_clk;

initial 
    begin
			x = 64'd8563214857120369541;
			y = 64'd6579858412322574896;
    end

multiplier    multiplier_inst
(  
	.clk_in    (sys_clk   )    ,						//时钟输入
	.rst_n     (sys_rst_n )    ,          		             //复位信号
	.x         (     x    )    ,							//被乘数
	.y         (     y    )    ,							//乘数
	.clk_en    (  clk_en  )    ,
	.p	       	(     p    )	                            //乘积  
);                    

endmodule