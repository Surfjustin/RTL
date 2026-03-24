
`timescale 1ns/1ps

module tb_top;


  reg clk;
  reg rst;
  reg en;
  reg [7:0] data;


  wire output_en;
  wire [7:0] out_z;


  top uut (
    .clk(clk),
    .rst(rst),
    .en(en),
    .data(data),
    .output_en(output_en),
    .out_z(out_z)
  );


  always #5 clk = ~clk;


  integer fp;


  initial begin

    fp = $fopen("output1_log.csv", "w");
    $fdisplay(fp, "Time,Reset,Enable,Data,OutputEn,OutZ");


    clk = 0;
    rst = 1;
    en  = 0;
    data = 8'd0;

    $display("=== START TEST ===");


    #25;
    rst = 0;
    en  = 1;


    repeat (101) begin
      data = $random % 256;
      #1;
      $fdisplay(fp, "%0t,%0b,%0b,%0d,%0b,%0d", $time, rst, en, data, output_en, out_z);
      #9;
    end

    en = 0;

    #10;
    $fclose(fp); 
    $display("=== Output written to output_log.csv ===");
    $stop;
  end

endmodule
