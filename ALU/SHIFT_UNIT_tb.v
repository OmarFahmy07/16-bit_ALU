`timescale 1 us / 1 ns

module SHIFT_UNIT_tb();
  
  localparam IN1_WIDTH = 16;
  localparam IN2_WIDTH = 16;
  localparam SHIFT_OUT_WIDTH = 16;
  
  reg [15:0] in1_tb;
  reg [15:0] in2_tb;
  reg clk_tb;
  reg [1:0] shift_fun_tb;
  reg shift_en_tb;
  wire [15:0] shift_out_tb;
  wire shift_flag_tb;
  
  SHIFT_UNIT # (
  .IN1_WIDTH(IN1_WIDTH),
  .IN2_WIDTH(IN2_WIDTH),
  .SHIFT_OUT_WIDTH(SHIFT_OUT_WIDTH)
  ) DUT (
  .in1 (in1_tb),
  .in2 (in2_tb),
  .clk (clk_tb),
  .shift_fun (shift_fun_tb),
  .shift_en (shift_en_tb),
  .shift_out (shift_out_tb),
  .shift_flag (shift_flag_tb) 
  );
  
  always #5 clk_tb = ~clk_tb;
  
  initial
    begin
      $dumpfile("SHIFT_UNIT.vcd");
      $dumpvars;
      clk_tb = 1'b0;
      shift_en_tb = 1'b1;
      in1_tb = 16'd38;
      in2_tb = 16'd20;
      shift_fun_tb = 2'b00;      
      #10
      if(shift_out_tb == 16'd19)
        $display("Test case 1 passed");
      else
        $display("Test case 2 failed");
      shift_fun_tb = 2'b01;
      #10
      if(shift_out_tb == 16'd76)
        $display("Test case 2 passed");
      else
        $display("Test case 2 failed");
        
      $finish;
    end
  
endmodule

