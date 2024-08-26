`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2024 10:55:22 AM
// Design Name: 
// Module Name: EBI_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module EBI_top(
input [7:0]address,
inout [7:0]data,
input WR,
input RD,
input CLK_in,
input CS,
input CLK_50Mhz,
output led
    );
    

   wire [7:0]d_read;
   wire [7:0]d_WRite;
   reg [26:0]led_i=0;
   wire clk_out;

wire wr_en;

assign wr_en = ~WR & RD;

  
  always @(posedge CLK_50Mhz)
  begin
       led_i<=led_i+1;
  end
  
  assign led=led_i[26]; 
  
      
IOBUF i1 (
   .O(d_WRite[0]),   // 1-bit output: Buffer output
   .I(d_read[0]),   // 1-bit input: Buffer input
   .IO(data[0]), // 1-bit inout: Buffer inout (connect directly to top-level port)
   .T(RD)    // 1-bit input: 3-state enable input
);

IOBUF i2 (
   .O(d_WRite[1]),   // 1-bit output: Buffer output
   .I(d_read[1]),   // 1-bit input: Buffer input
   .IO(data[1]), // 1-bit inout: Buffer inout (connect directly to top-level port)
   .T(RD)    // 1-bit input: 3-state enable input
);

IOBUF i3 (
   .O(d_WRite[2]),   // 1-bit output: Buffer output
   .I(d_read[2]),   // 1-bit input: Buffer input
   .IO(data[2]), // 1-bit inout: Buffer inout (connect directly to top-level port)
   .T(RD)    // 1-bit input: 3-state enable input
);

IOBUF i4 (
   .O(d_WRite[3]),   // 1-bit output: Buffer output
   .I(d_read[3]),   // 1-bit input: Buffer input
   .IO(data[3]), // 1-bit inout: Buffer inout (connect directly to top-level port)
   .T(RD)    // 1-bit input: 3-state enable input
);

IOBUF i5 (
   .O(d_WRite[4]),   // 1-bit output: Buffer output
   .I(d_read[4]),   // 1-bit input: Buffer input
   .IO(data[4]), // 1-bit inout: Buffer inout (connect directly to top-level port)
   .T(RD)    // 1-bit input: 3-state enable input
);

IOBUF i6 (
   .O(d_WRite[5]),   // 1-bit output: Buffer output
   .I(d_read[5]),   // 1-bit input: Buffer input
   .IO(data[5]), // 1-bit inout: Buffer inout (connect directly to top-level port)
   .T(RD)    // 1-bit input: 3-state enable input
);

IOBUF i7 (
   .O(d_WRite[6]),   // 1-bit output: Buffer output
   .I(d_read[6]),   // 1-bit input: Buffer input
   .IO(data[6]), // 1-bit inout: Buffer inout (connect directly to top-level port)
   .T(RD)    // 1-bit input: 3-state enable input
);

IOBUF i8 (
   .O(d_WRite[7]),   // 1-bit output: Buffer output
   .I(d_read[7]),   // 1-bit input: Buffer input
   .IO(data[7]), // 1-bit inout: Buffer inout (connect directly to top-level port)
   .T(RD)    // 1-bit input: 3-state enable input
);


    
  blk_mem_gen_0 b1
   (
    .CLKa(CLK_in),
    .ena(~CS),
    .wea(wr_en),
    .addra(address),
    .dina(d_WRite),
    .douta(d_read)
  );

ila_0 ila_inst(
.clk(CLK_50Mhz),
.probe0(address),
.probe1(d_WRite),
.probe2(d_read),
.probe3(WR),
.probe4(RD),
.probe5(CLK_in),
.probe6(CS)
);

 clk_wiz_0 CLOCK
  (
  // Clock out ports  
  .clk_out1(clk_out),
 // Clock in ports
  .clk_in1(CLK_50Mhz)
  );
         
endmodule
