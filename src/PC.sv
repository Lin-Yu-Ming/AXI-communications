`timescale 1ns / 1ps


module PC(Current_PC, Next_PC, clk, rst, PC_write,CPU_stall);

output reg [31:0]Current_PC;
input [31:0]Next_PC;
input clk, rst;
input PC_write;//hazard
input CPU_stall;
logic last_rst2;

always @(posedge clk, posedge rst)
begin
    if(rst)begin
        Current_PC<=32'd0;
	    last_rst2<=1'b0;
        end
    else if (~last_rst2)begin
        Current_PC<=Current_PC;
	      last_rst2<=1'b1;
   end

   else begin
        if(PC_write||CPU_stall) //write
           Current_PC<=Current_PC;
        else//(PC_write==1'b0) //stall and keep PC no change 
           Current_PC<=Next_PC;
   end
  end
endmodule
