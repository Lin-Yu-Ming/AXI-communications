`timescale 1ns / 1ps


module EX_MEM_Pipe(
            //output
            MemtoReg_out,RegWrite_out,FloatRegWrite_out,MemRead_out,MemWrite_out,
            ALU_out,
            Rd_out,
			Instruction_out,
            Write_enble_bit_out,
            Write_enble_out,
            DM_out,
           // Alu_result_out,
            //input
            MemtoReg_in,RegWrite_in,FloatRegWrite_in,MemRead_in,MemWrite_in,
            ALU_in,
            Rd_in,
			Instruction_in,
            CPU_stall,
            Write_enble_bit_in,
            Write_enble_in,
            DM_in,
            //Alu_result_in,
            clk,rst,
            );

output logic[31:0]ALU_out;
output logic[4:0]Rd_out;
output logic MemRead_out,MemWrite_out;//M     
output logic MemtoReg_out,RegWrite_out,FloatRegWrite_out;//WB     
output logic [31:0]Instruction_out;
output logic [31:0]Write_enble_bit_out;
output logic Write_enble_out;
output logic[31:0]DM_out;
//output logic [31:0] Alu_result_out;

input [31:0]ALU_in;
input [4:0]Rd_in;
input MemRead_in,MemWrite_in;
input MemtoReg_in,RegWrite_in,FloatRegWrite_in;
input [31:0]Instruction_in;
input clk,rst;
input CPU_stall;
input [31:0]Write_enble_bit_in;
input Write_enble_in;
input [31:0]DM_in;
//input [31:0] Alu_result_in;

always@(posedge rst , posedge clk)
begin
    if(rst)
    begin//
        ALU_out<=32'd0;
        Rd_out<=5'd0;
        MemRead_out<=1'd0;
        MemWrite_out<=1'd0;
        MemtoReg_out<=1'd0;
        RegWrite_out<=1'd0;
        FloatRegWrite_out<=1'd0;
        Instruction_out<=32'd0;
        Write_enble_bit_out<=32'd0;
        Write_enble_out<=1'b0;
        DM_out<=32'd0;
        //Alu_result_out<=32'd0;
    end
    else begin
        if (CPU_stall) begin
            ALU_out<=ALU_out;
            Rd_out<=Rd_out;
            MemRead_out<=MemRead_out;
            MemWrite_out<=MemWrite_out;
            MemtoReg_out<=MemtoReg_out;
            RegWrite_out<=RegWrite_out;
            FloatRegWrite_out<=FloatRegWrite_out;
		    Instruction_out<=Instruction_out;
            Write_enble_bit_out<=Write_enble_bit_out;
            Write_enble_out<=Write_enble_out;
            DM_out<=DM_out;
            //Alu_result_out<=Alu_result_out;
        end
        else begin
            ALU_out<=ALU_in;
            Rd_out<=Rd_in;
            MemRead_out<=MemRead_in;
            MemWrite_out<=MemWrite_in;
            MemtoReg_out<=MemtoReg_in;
            RegWrite_out<=RegWrite_in;
            FloatRegWrite_out<=FloatRegWrite_in;
		    Instruction_out<=Instruction_in; 
            Write_enble_bit_out<=Write_enble_bit_in; 
            Write_enble_out<=Write_enble_in; 
            DM_out<=DM_in; 
        end
    end
end
endmodule
