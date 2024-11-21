`timescale 1ns / 1ps


module IF_ID_Pipe(
			//output
			PC_out,Instruction_out,
			cycle_out,instr_out,
			//input
            PC_in,Instruction_in,
			cycle_in,instr_in,
			IFID_write,
			IF_flush,
			CPU_stall,
			clk,rst);

output reg [31:0]PC_out,Instruction_out;
output reg [63:0]cycle_out,instr_out;
input [31:0]PC_in,Instruction_in;
input reg [63:0]cycle_in,instr_in;

input rst,clk;
input IFID_write;
input IF_flush;
input CPU_stall;
always@(posedge rst or posedge clk)
begin
    if(rst) begin
		PC_out<=32'b0;
		Instruction_out<=32'b0;
		cycle_out<=64'b0;
		instr_out<=64'b0;
	end
	else begin 
		if (CPU_stall) begin
			PC_out<=PC_out;
	    	Instruction_out<=Instruction_out;
			cycle_out<=cycle_out;
			instr_out<=instr_out;	
		end
		else begin
		    if(!IFID_write) begin
			    if(!IF_flush)begin
			        PC_out<=PC_in;
	    		    Instruction_out<=Instruction_in;
				    cycle_out<=cycle_in;
				    instr_out<=instr_in;
				end
                else begin
				    PC_out<=32'd0;
	    		    Instruction_out<=32'd0;
				    cycle_out<=64'd0;
				    instr_out<=64'd0;    
                end				
			end
			else begin
			    PC_out<=PC_out;
	    	    Instruction_out<=Instruction_out;
			    cycle_out<=cycle_out;
			    instr_out<=instr_out;
			end
		end  
	end
end
endmodule
