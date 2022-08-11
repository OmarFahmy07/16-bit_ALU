`timescale 1 us / 1 ns

module LOGIC_UNIT_tb();
  
  localparam IN1_WIDTH = 16;
  localparam IN2_WIDTH = 16;
  localparam LOGIC_OUT_WIDTH = 16;
  
  reg [15:0] in1_tb;
  reg [15:0] in2_tb;
  reg clk_tb;
  reg [1:0] logic_fun_tb;
  reg logic_en_tb;
  wire [15:0] logic_out_tb;
  wire logic_flag_tb;
  
  LOGIC_UNIT # (
  .IN1_WIDTH(IN1_WIDTH),
  .IN2_WIDTH(IN2_WIDTH),
  .LOGIC_OUT_WIDTH(LOGIC_OUT_WIDTH)
  ) DUT (
  .in1 (in1_tb),
  .in2 (in2_tb),
  .clk (clk_tb),
  .logic_fun (logic_fun_tb),
  .logic_en (logic_en_tb),
  .logic_out (logic_out_tb),
  .logic_flag (logic_flag_tb) 
  );
  
  always #5 clk_tb = ~clk_tb;
  
  initial
    begin
      $dumpfile("LOGIC_UNIT.vcd");
      $dumpvars;
      clk_tb = 1'b0;
      logic_en_tb = 1'b1;
      in1_tb = 16'b1011;
      in2_tb = 16'b1001;
      logic_fun_tb = 2'b00;      
      #10
      if(logic_out_tb == 16'b1001)
        $display("Test case 1 passed");
      else
        $display("Test case 2 failed");
      logic_fun_tb = 2'b01;
      #10
      if(logic_out_tb == 16'b1011)
        $display("Test case 2 passed");
      else
        $display("Test case 2 failed");
        
      $finish;
    end
  
endmodule