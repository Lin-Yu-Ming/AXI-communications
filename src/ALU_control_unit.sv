`timescale 1ns / 1ps


module ALU_control_unit(ALU_operation, ALUOp,instruction);


localparam ANDop = 6'b00_0000;
localparam ORop = 6'b00_0001;
localparam ADDop = 6'b00_0010;
localparam SUBop = 6'b00_0110;
localparam XORop = 6'b00_0111 ;
localparam AlgoShiftRightUnsignedop = 6'b00_1001;
localparam AlgoShiftRightSignedop = 6'b00_1010;
localparam LogicShiftLeftop = 6'b00_1011;
localparam LogicShiftRightUnsignedop = 6'b00_1100;
localparam LogicShiftRightSignedop = 6'b00_1101;

localparam MULop = 6'b01_0000;
localparam MULHop = 6'b01_0001;
localparam MULHSUop = 6'b01_0010;
localparam MULHUop = 6'b01_0011;

localparam FADDop = 6'b11_0000;//fadd
localparam FSUBop = 6'b11_0001;//fsub

output logic [5:0]ALU_operation;
input [31:0] instruction;
input [1:0]ALUOp;



  always_comb begin
      case(instruction[6:0])
	      7'b0110011:begin
		      case(instruction[14:12])
			      3'b000:begin
				      if(!instruction[30]&&!instruction[25])ALU_operation=ADDop;//add
					  else if(instruction[30]&&!instruction[25])ALU_operation=SUBop;//sub
					  else ALU_operation= MULop;//mul
					  
				  end	
				  3'b001:begin
				      if(!instruction[25])ALU_operation=LogicShiftLeftop; //sll
					  else ALU_operation= MULHop; //mulh 
				  end
				  3'b010:begin
				      if(!instruction[25])ALU_operation=AlgoShiftRightSignedop; //slt
					  else ALU_operation= MULHSUop; //mulhsu	
				  end
				  3'b011:begin 
				      if(!instruction[25])ALU_operation=AlgoShiftRightUnsignedop;  //sltu
					  else ALU_operation= MULHUop;//mulhu
				  end
				  3'b100:ALU_operation= XORop; //xor

				  3'b101:begin
				      if(!instruction[30])ALU_operation= LogicShiftRightUnsignedop; //srl unsigned
					  else ALU_operation= LogicShiftRightSignedop;//sra
				  end
				  3'b110:ALU_operation= ORop;//or

				  3'b111:ALU_operation= ANDop;//and

			  endcase	
		  end

		  7'b0000011:ALU_operation=ADDop;

		  7'b0010011:begin
		      case (instruction[14:12])
			      3'b000:ALU_operation=ADDop; 
				  3'b010:ALU_operation=AlgoShiftRightSignedop; //slti
				  3'b011:ALU_operation=AlgoShiftRightUnsignedop;  //sltiu
				  3'b100:ALU_operation= XORop; //xori
				  3'b110:ALU_operation= ORop;//ori
				  3'b111:ALU_operation= ANDop;//andi
				  3'b001:ALU_operation=LogicShiftLeftop;//slli
				  3'b101:begin
				      if(!instruction[30])ALU_operation= LogicShiftRightUnsignedop; //srli unsigned
					  else ALU_operation= LogicShiftRightSignedop;//srai signed  
				  end
			  endcase
		  end

		  7'b1100111:ALU_operation=ADDop;

		  7'b0100011:ALU_operation=ADDop;

		  7'b1100011:ALU_operation=ADDop;

		  7'b0010111:ALU_operation=ADDop;

		  7'b0110111:ALU_operation=ADDop;

		  7'b1101111:ALU_operation=ADDop;

		  7'b0000111:ALU_operation=ADDop;

		  7'b0100111:ALU_operation=ADDop;
		  
		  7'b1110011:ALU_operation=ADDop;

		  7'b1010011:begin
		      if(!instruction[27])ALU_operation=FADDop; //FADD
			  else ALU_operation=FSUBop;
		  end

          default:ALU_operation=6'b11_1111;
	  endcase
  end

endmodule
