`timescale 1 us / 1 ns

module decoder_2x4_tb();
  
  reg [1:0] in_tb;
  
  wire out0_tb, out1_tb, out2_tb, out3_tb;
  
  wire [3:0] out_tb;
  
  assign out_tb = {out3_tb, out2_tb, out1_tb, out0_tb};
  
  decoder_2x4  DUT (
  .in(in_tb),
  .out0(out0_tb),
  .out1(out1_tb),
  .out2(out2_tb),
  .out3(out3_tb)
  );
  
  initial
    begin
      $dumpfile("LOGIC_UNIT.vcd");
      $dumpvars;
      in_tb = 2'b00;
      #10
      if(out_tb == 16'b0001)
        $display("Test case 1 passed");
      else
        $display("Test case 2 failed");
      in_tb = 2'b01;
      #10
      if(out_tb == 16'b0010)
        $display("Test case 2 passed");
      else
        $display("Test case 2 failed");
        
      $finish;
    end
  
endmodule

