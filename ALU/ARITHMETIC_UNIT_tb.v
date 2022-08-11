`timescale 1 us / 1 ns

module ARITHMETIC_UNIT_tb();
  
  localparam IN1_WIDTH = 16;
  localparam IN2_WIDTH = 16;
  localparam ARITH_OUT_WIDTH = 16;
  
  reg [15:0] in1_tb;
  reg [15:0] in2_tb;
  reg clk_tb;
  reg [1:0] arith_fun_tb;
  reg arith_en_tb;
  wire [15:0] arith_out_tb;
  wire arith_cout_tb, arith_flag_tb;
  
  ARITHMETIC_UNIT # (
  .IN1_WIDTH(IN1_WIDTH),
  .IN2_WIDTH(IN2_WIDTH),
  .ARITH_OUT_WIDTH(ARITH_OUT_WIDTH)
  ) DUT (
  .in1 (in1_tb),
  .in2 (in2_tb),
  .clk (clk_tb),
  .arith_fun (arith_fun_tb),
  .arith_en (arith_en_tb),
  .arith_out (arith_out_tb),
  .arith_cout (arith_cout_tb),
  .arith_flag (arith_flag_tb) 
  );
  
  always #5 clk_tb = ~clk_tb;
  
  initial
    begin
      $dumpfile("ARITHMETIC_UNIT.vcd");
      $dumpvars;
      clk_tb = 1'b0;
      arith_en_tb = 1'b1;
      in1_tb = 16'd17;
      in2_tb = 16'd12;
      arith_fun_tb = 2'b00;      
      #10
      if(arith_out_tb == 16'd29)
        $display("Test case 1 passed");
      else
        $display("Test case 2 failed");
      arith_fun_tb = 2'b01;
      #10
      if(arith_out_tb == 16'd5)
        $display("Test case 2 passed");
      else
        $display("Test case 2 failed");
        
      $finish;
    end
  
endmodule
