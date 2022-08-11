`timescale 1 us / 1 ns

module CMP_UNIT_tb();
  
  localparam IN1_WIDTH = 16;
  localparam IN2_WIDTH = 16;
  localparam CMP_OUT_WIDTH = 16;
  
  reg [15:0] in1_tb;
  reg [15:0] in2_tb;
  reg clk_tb;
  reg [1:0] cmp_fun_tb;
  reg cmp_en_tb;
  wire [15:0] cmp_out_tb;
  wire cmp_flag_tb;
  
  CMP_UNIT # (
  .IN1_WIDTH(IN1_WIDTH),
  .IN2_WIDTH(IN2_WIDTH),
  .CMP_OUT_WIDTH(CMP_OUT_WIDTH)
  ) DUT (
  .in1 (in1_tb),
  .in2 (in2_tb),
  .clk (clk_tb),
  .cmp_fun (cmp_fun_tb),
  .cmp_en (cmp_en_tb),
  .cmp_out (cmp_out_tb),
  .cmp_flag (cmp_flag_tb) 
  );
  
  always #5 clk_tb = ~clk_tb;
  
  initial
    begin
      $dumpfile("LOGIC_UNIT.vcd");
      $dumpvars;
      clk_tb = 1'b0;
      cmp_en_tb = 1'b1;
      in1_tb = 16'd15;
      in2_tb = 16'd15;
      cmp_fun_tb = 2'b01;      
      #10
      if(cmp_out_tb == 16'b1)
        $display("Test case 1 passed");
      else
        $display("Test case 2 failed");
      cmp_fun_tb = 2'b10;
      in1_tb = 16'd17;
      #10
      if(cmp_out_tb == 16'd2)
        $display("Test case 2 passed");
      else
        $display("Test case 2 failed");
      $finish;
    end
  
endmodule

