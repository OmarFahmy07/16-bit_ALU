`timescale 1 us / 1 ns

module ALU_TOP_tb();
  
  localparam DATA_WIDTH = 16;
  
  reg [DATA_WIDTH - 1 : 0] A_tb;
  reg [DATA_WIDTH - 1 : 0] B_tb;
  reg [3:0] ALU_FUN_tb;
  reg CLK_tb;
  wire [DATA_WIDTH - 1 : 0] Arith_OUT_tb;
  wire Carry_OUT_tb;
  wire Arith_Flag_tb;
  wire [DATA_WIDTH - 1 : 0] Logic_OUT_tb;
  wire Logic_Flag_tb;
  wire [DATA_WIDTH - 1 : 0] Shift_OUT_tb;
  wire Shift_Flag_tb;
  wire [DATA_WIDTH - 1 : 0] CMP_OUT_tb;
  wire CMP_Flag_tb;
  
  wire [3:0] flags_tb;
  
  assign flags_tb = {Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, Shift_Flag_tb};
  
  ALU_TOP # (
    .DATA_WIDTH(DATA_WIDTH)
  ) DUT (
    .A(A_tb),
    .B(B_tb),
    .ALU_FUN(ALU_FUN_tb),
    .CLK(CLK_tb),
    .Arith_OUT(Arith_OUT_tb),
    .Carry_OUT(Carry_OUT_tb),
    .Arith_Flag(Arith_Flag_tb),
    .Logic_OUT(Logic_OUT_tb),
    .Logic_Flag(Logic_Flag_tb),
    .Shift_OUT(Shift_OUT_tb),
    .Shift_Flag(Shift_Flag_tb),
    .CMP_OUT(CMP_OUT_tb),
    .CMP_Flag(CMP_Flag_tb)
  );
  
  initial
    begin
      $dumpfile("ALU_TOP.vcd");
      $dumpvars;
      CLK_tb = 1'b0;
      A_tb = 'b11011001; // A = 217
      B_tb = 'b01101101; // B = 109
      ALU_FUN_tb = 4'b0; // Addition
      
      // Testing Addition
      #10
      if( {Carry_OUT_tb, Arith_OUT_tb}  == 'd326 && flags_tb == 4'b1000 )
          $display("Test case 1 passed");
        else
          $display("Test case 1 failed");
      A_tb = 'h8FFF; //A = 36863
      B_tb = 'h8FBA; //B = 36794
      
      // Testing addition with carry
      #10
      if( {Carry_OUT_tb, Arith_OUT_tb} == 'd73657 && flags_tb == 4'b1000 )
        $display("Test case 2 passed");
      else
        $display("Test case 2 failed");
      ALU_FUN_tb = 4'b0001;
      
      // Testing subtraction
      #10
      if( {Carry_OUT_tb, Arith_OUT_tb} == 'd69 && flags_tb == 4'b1000 )
        $display("Test case 3 passed");
      else
        $display("Test case 3 failed");
      ALU_FUN_tb = 4'b0010;
      
      // Testing multiplication with truncation
      #10
      if( {Carry_OUT_tb, Arith_OUT_tb} == 'd4166 && flags_tb == 4'b1000 )
        $display("Test case 4 passed");
      else
        $display("Test case 4 failed");
      ALU_FUN_tb = 4'b0011;
      A_tb = 'd36;
      B_tb = 'd6;
      
      // Testing division
      #10
      if( {Carry_OUT_tb, Arith_OUT_tb} == 'd6 && flags_tb == 4'b1000 )
        $display("Test case 5 passed");
      else
        $display("Test case 5 failed");
      ALU_FUN_tb = 4'b0100;
      A_tb = 'b10110110;
      B_tb = 'b01101100;
      
      // Testing ANDing
      #10
      if( Logic_OUT_tb == 'b00100100 && flags_tb == 4'b0100 )
        $display("Test case 6 passed");
      else
        $display("Test case 6 failed");
      ALU_FUN_tb = 4'b0101;
      
      // Testing ORing
      #10
      if( Logic_OUT_tb == 'b11111110 && flags_tb == 4'b0100 )
        $display("Test case 7 passed");
      else
        $display("Test case 7 failed");
      ALU_FUN_tb = 4'b0110;
      
      // Testing NAND
      #10
      if( Logic_OUT_tb == 'hFFDB && flags_tb == 4'b0100 )
        $display("Test case 8 passed");
      else
        $display("Test case 8 failed");
      ALU_FUN_tb = 4'b0111;
      
      // Testing NOR
      #10
      if( Logic_OUT_tb == 'hFF01 && flags_tb == 4'b0100 )
        $display("Test case 9 passed");
      else
        $display("Test case 9 failed");
      ALU_FUN_tb = 4'b1000;
      
      // Testing NOP
      #10
      if( CMP_OUT_tb == 'b0 && flags_tb == 4'b0010 )
        $display("Test case 10 passed");
      else
        $display("Test case 10 failed");
      ALU_FUN_tb = 4'b1001;
      A_tb = 'd4;
      B_tb = 'd4;
      
      // Testing equality
      #10
      if( CMP_OUT_tb == 'd1 && flags_tb == 4'b0010 )
        $display("Test case 11 passed");
      else
        $display("Test case 11 failed");
      ALU_FUN_tb = 4'b1010;
      A_tb = 'd5;
      B_tb = 'd2;
     
      // Testing greater than operation
      #10
      if( CMP_OUT_tb == 'd2 && flags_tb == 4'b0010 )
        $display("Test case 12 passed");
      else
        $display("Test case 12 failed");
      ALU_FUN_tb = 4'b1011;
      B_tb = 'd7;
      
      // Testing smaller than operation
      #10
      if( CMP_OUT_tb == 'd3 && flags_tb == 4'b0010 )
        $display("Test case 13 passed");
      else
        $display("Test case 13 failed");
      ALU_FUN_tb = 4'b1100;
      A_tb = 'b110010;
      B_tb = 'b110010;
      
      // Testing shift right for operand A
      #10
      if( Shift_OUT_tb == 'b11001 && flags_tb == 4'b0001 )
        $display("Test case 14 passed");
      else
        $display("Test case 14 failed");
      ALU_FUN_tb = 4'b1101;
      
      // Testing shift left for operand A
      #10
      if( Shift_OUT_tb == 'b1100100 && flags_tb == 4'b0001 )
        $display("Test case 15 passed");
      else
        $display("Test case 15 failed");
      ALU_FUN_tb = 4'b1110;     
      
      // Testing shift right for operand B
      #10
      if( Shift_OUT_tb == 'b11001 && flags_tb == 4'b0001 )
        $display("Test case 16 passed");
      else
        $display("Test case 16 failed");
      ALU_FUN_tb = 4'b1111;
      
      // Testing shift left for operand B
      #10
      if( Shift_OUT_tb == 'b1100100 && flags_tb == 4'b0001 )
        $display("Test case 17 passed");
      else
        $display("Test case 17 failed");      
        
      $finish;     
      
    end
  
  always
    begin
      if(CLK_tb == 1'b0)
        #4 CLK_tb = 1'b1;
      else
        #6 CLK_tb = 1'b0;
    end 
    
endmodule