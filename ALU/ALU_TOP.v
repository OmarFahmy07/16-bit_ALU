module ALU_TOP #(
  parameter DATA_WIDTH = 8
  ) (
  input wire [DATA_WIDTH - 1 : 0] A,
  input wire [DATA_WIDTH - 1 : 0] B,
  input wire [3:0] ALU_FUN,
  input wire CLK,
  output wire [DATA_WIDTH - 1 : 0] Arith_OUT,
  output wire Carry_OUT,
  output wire Arith_Flag,  
  output wire [DATA_WIDTH - 1 : 0] Logic_OUT,
  output wire Logic_Flag,
  output wire [DATA_WIDTH - 1 : 0] Shift_OUT,
  output wire Shift_Flag,
  output wire [DATA_WIDTH - 1 : 0] CMP_OUT,
  output wire CMP_Flag
  );
  
  wire Arith_Enable, Logic_Enable, Shift_Enable, CMP_Enable;
  
  ARITHMETIC_UNIT # (
  .DATA_WIDTH(DATA_WIDTH)
  ) U_arith(
  .in1(A),
  .in2(B),
  .clk(CLK),
  .arith_fun( ALU_FUN[1:0] ),
  .arith_en(Arith_Enable),
  .arith_out(Arith_OUT),
  .arith_cout(Carry_OUT),
  .arith_flag(Arith_Flag)
  );
  
  LOGIC_UNIT # (
  .DATA_WIDTH(DATA_WIDTH)
  ) U_logic(
  .in1(A),
  .in2(B),
  .clk(CLK),
  .logic_fun( ALU_FUN[1:0] ),
  .logic_en(Logic_Enable),
  .logic_out(Logic_OUT),
  .logic_flag(Logic_Flag)
  );
  
  SHIFT_UNIT # (
  .DATA_WIDTH(DATA_WIDTH)
  ) U_shift(
  .in1(A),
  .in2(B),
  .clk(CLK),
  .shift_fun( ALU_FUN[1:0] ),
  .shift_en(Shift_Enable),
  .shift_out(Shift_OUT),
  .shift_flag(Shift_Flag)
  );
  
  CMP_UNIT # (
  .DATA_WIDTH(DATA_WIDTH)
  ) U_cmp(
  .in1(A),
  .in2(B),
  .clk(CLK),
  .cmp_fun( ALU_FUN[1:0] ),
  .cmp_en(CMP_Enable),
  .cmp_out(CMP_OUT),
  .cmp_flag(CMP_Flag)
  );
  
  decoder_2x4 U_decoder(
  .in( ALU_FUN[3:2] ),
  .out0(Arith_Enable),
  .out1(Logic_Enable),
  .out2(CMP_Enable),
  .out3(Shift_Enable)
  );
  
  
endmodule