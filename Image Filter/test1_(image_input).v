`timescale 1ns/1ps

module tb1_top;


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


  reg [7:0] data_mem [0:1023];
  integer i, num_data;


  integer fp_read, fp_write;

  initial begin
    clk = 0;
    rst = 1;
    en  = 0;
    data = 8'd0;
    i = 0;


    fp_read = $fopen("input_data.csv", "r");
    if (fp_read == 0) begin
      $display("ERROR: Cannot open input_data.csv");
      $finish;
    end


    num_data = 0;
    while (!$feof(fp_read)) begin
      $fscanf(fp_read, "%d\n", data_mem[num_data]);
      num_data = num_data + 1;
    end
    $fclose(fp_read);
    $display("Read %0d entries from input_data.csv", num_data);


    fp_write = $fopen("output1_log.csv", "w");
    $fdisplay(fp_write, "Time,Reset,Enable,Data,OutputEn,OutZ");


    #25;
    rst = 0;
    en  = 1;


    for (i = 0; i < num_data; i = i + 1) begin
      data = data_mem[i];
      #1;
      $fdisplay(fp_write, "%0t,%0b,%0b,%0d,%0b,%0d", $time, rst, en, data, output_en, out_z);
      #9;
    end


    en = 0;


    for (i = 0; i < 5; i = i + 1) begin
      #1;
      $fdisplay(fp_write, "%0t,%0b,%0b,%0d,%0b,%0d", $time, rst, en, data, output_en, out_z);
      #9;
    end

    $fclose(fp_write);
    $display("=== Output written to output1_log.csv ===");
    $stop;
  end

endmodule
