`timescale 1ns / 1ps

`include "../include/AXI_define.svh"
`include "CPU.sv"

module CPU_wrapper(
	input ACLK,
	input ARESETn,

    //-------IM1-------
    //READ ADDRESS0
	output logic [`AXI_ID_BITS-1:0] ARID_M0,
	output logic [`AXI_ADDR_BITS-1:0] ARADDR_M0,
	output logic [`AXI_LEN_BITS-1:0] ARLEN_M0,
	output logic [`AXI_SIZE_BITS-1:0] ARSIZE_M0,
	output logic [1:0] ARBURST_M0,
	output logic ARVALID_M0,
	input  ARREADY_M0,
	
	//READ DATA0
	input  [`AXI_ID_BITS-1:0] RID_M0,
	input  [`AXI_DATA_BITS-1:0] RDATA_M0,
	input  [1:0] RRESP_M0,
	input  RLAST_M0,
	input  RVALID_M0,
	output logic RREADY_M0,


	//-------DM1-------
	//WRITE ADDRESS1
	output logic [`AXI_ID_BITS-1:0] AWID_M1,
	output logic [`AXI_ADDR_BITS-1:0] AWADDR_M1,
	output logic [`AXI_LEN_BITS-1:0] AWLEN_M1,
	output logic [`AXI_SIZE_BITS-1:0] AWSIZE_M1,
	output logic [1:0] AWBURST_M1,
	output logic AWVALID_M1,
	input  AWREADY_M1,
	
	//WRITE DATA1
	output logic [`AXI_DATA_BITS-1:0] WDATA_M1,
	output logic [`AXI_STRB_BITS-1:0] WSTRB_M1,
	output logic WLAST_M1,
	output logic WVALID_M1,
	input  WREADY_M1,
	
	//WRITE RESPONSE1
	input  [`AXI_ID_BITS-1:0] BID_M1,
	input  [1:0] BRESP_M1,
	input  BVALID_M1,
	output logic BREADY_M1,

      //READ ADDRESS1
	output logic [`AXI_ID_BITS-1:0] ARID_M1,
	output logic [`AXI_ADDR_BITS-1:0] ARADDR_M1,
	output logic [`AXI_LEN_BITS-1:0] ARLEN_M1,
	output logic [`AXI_SIZE_BITS-1:0] ARSIZE_M1,
	output logic [1:0] ARBURST_M1,
	output logic ARVALID_M1,
	input  ARREADY_M1,
	
	//READ DATA1
	input  [`AXI_ID_BITS-1:0] RID_M1,
	input  [`AXI_DATA_BITS-1:0] RDATA_M1,
	input  [1:0] RRESP_M1,
	input  RLAST_M1,
	input  RVALID_M1,
	output logic RREADY_M1
);


//IM
logic [31:0] IM_A;
logic [31:0] IM_DO;
//logic        IM_OE;
//DM
logic        DM_read_en;
logic DM_write_en;
logic [3:0] DM_WEN_BIT;
logic [31:0] Write_enble_bit;
logic [31:0] DM_A;
logic [31:0] DM_in;
logic [31:0] DM_out;

//CPU
logic CPU_stall;

CPU cpu(
      .clk(ACLK), .rst(~ARESETn),//input
      //IM
      .IM_A(IM_A),//output
      .instruction(IM_DO),//input
      //DM
      .DataMemory_write_enable(DM_write_en),//output
      .DataMemory_write_bit(Write_enble_bit),//output
      .Data_address(DM_A),//output
      .DataMemory_in(DM_in),//output
      .DataMemory_out(DM_out),//input
      .DataMemory_read_enable (DM_read_en),//output
	  .CPU_stall (CPU_stall)//input
      );	  


//AXI WSTB
always_comb begin
    case (Write_enble_bit)
		32'hffffff00:DM_WEN_BIT=4'b1110;
        32'hffff00ff:DM_WEN_BIT=4'b1101;
		32'hff00ffff:DM_WEN_BIT=4'b1011;
        32'h00ffffff:DM_WEN_BIT=4'b0111;
		32'hffff0000:DM_WEN_BIT=4'b1100;
        32'h0000ffff:DM_WEN_BIT=4'b0011;
        32'h00000000:DM_WEN_BIT=4'd0;
        32'h11111111:DM_WEN_BIT=4'b1111;
		default:DM_WEN_BIT=4'b1111; 
	endcase
end	

//M0 State machine
logic [2:0] State_M0;
logic [2:0] NextState_M0;
logic [31:0] store_RDATA_M0;


//M1 State machine
logic [2:0] State_M1;
logic [2:0] NextState_M1;
logic [31:0] store_RDATA_M1;

logic M0_flag;
logic M1_flag;


always_comb begin
    //CPU stall
    if((State_M0==`IDLE)&&(State_M1==`IDLE)
	   &&!M0_flag&&!M1_flag)CPU_stall=1'b0;
	else CPU_stall=1'b1;
	//IM
	ARLEN_M0 = `AXI_LEN_ONE;
    ARSIZE_M0 = `AXI_SIZE_WORD;
	ARBURST_M0 = `AXI_BURST_INC;
	//DM
	ARLEN_M1 = `AXI_LEN_ONE;
	ARSIZE_M1 = `AXI_SIZE_WORD;
	ARBURST_M1 = `AXI_BURST_INC;
	AWLEN_M1 = `AXI_LEN_ONE;
	AWSIZE_M1 = `AXI_SIZE_WORD;
	AWBURST_M1 = `AXI_BURST_INC;	
end

/*----------------------M0-------------------------*/
/*-------------------------------------------------*/
//M0 State machine
always_ff @( posedge ACLK  or negedge ARESETn ) begin 
  if (!ARESETn) State_M0<=`INITIAL;
  else State_M0<=NextState_M0;
end

//Decide NextState M0 
always_comb begin 
  	unique case (State_M0)
	  `INITIAL:NextState_M0=`IDLE;
	  `IDLE:NextState_M0=(!M0_flag&&!M1_flag)?`READ_ADDRESS:`IDLE;
	  `READ_ADDRESS:NextState_M0=(ARVALID_M0&&ARREADY_M0)?`READ_DATA:`READ_ADDRESS;
	  `READ_DATA:NextState_M0=(RVALID_M0 && RREADY_M0 && RLAST_M0)?`IDLE:`READ_DATA;
	  default:NextState_M0=`INITIAL;
  endcase	
end

always_ff @( posedge ACLK or negedge ARESETn ) begin //Store instruction and read Data
	if (!ARESETn)store_RDATA_M0 <= 32'd0;
	else begin
		unique case (State_M0)
			`INITIAL:store_RDATA_M0<=store_RDATA_M0;
			`IDLE:store_RDATA_M0<=store_RDATA_M0;
		    `READ_ADDRESS:store_RDATA_M0<=32'd0;
            `READ_DATA:store_RDATA_M0<=RDATA_M0;
		    default:store_RDATA_M0<=store_RDATA_M0;
		endcase
	end
end

always_comb begin
	unique case (State_M0)
	  `INITIAL: begin
		//READ ADDRESS1
		ARVALID_M0=1'b0;
		ARID_M0=4'd0;//from slave 0 read instruction
		ARADDR_M0=32'd0;
		//READ DATA1
		RREADY_M0=1'b0;
		IM_DO=32'd0;
		//IM_DO=RDATA_M0;	
		M0_flag = 1'b0;
	  end
       
	  `IDLE:begin
	  //READ ADDRESS1
		ARVALID_M0=1'b0;
		ARID_M0=4'd0;//from slave 0 read instruction
		ARADDR_M0=IM_A;
		//READ DATA1
		RREADY_M0=1'b0;
		IM_DO=store_RDATA_M0;
		//IM_DO=RDATA_M0;	
		M0_flag = 1'b0;
	  end
	  `READ_ADDRESS: begin
		//***READ ADDRESS1
		ARID_M0=4'd0; //ID=0000(S0)
		ARADDR_M0=IM_A;   
		ARVALID_M0=1'b1;
		//READ DATA1
		RREADY_M0=1'b0;
		IM_DO=store_RDATA_M0;
		//IM_DO=32'd0;
		M0_flag=1'b1;

	  end
	  
	  `READ_DATA : begin
		//READ ADDRESS1
		ARID_M0=4'd0;
		ARADDR_M0=32'd0;
		ARVALID_M0=1'b0;
		//***READ DATA1
		RREADY_M0=1'b1;
		//IM_DO=RDATA_M0;
		IM_DO=store_RDATA_M0;
		M0_flag=1'b0;
	  end

	  default: begin
		//READ ADDRESS1
		ARID_M0=4'd0;
		ARADDR_M0=32'd0;
		ARVALID_M0=1'b0;
		//READ DATA1
		RREADY_M0=1'b0;
		IM_DO=32'd0;
		M0_flag=1'b0;
	  end
	endcase
end




/*---------------------M1--------------------------*/
/*-------------------------------------------------*/
//M1 State machine
always_ff @( posedge ACLK  or negedge ARESETn ) begin // M1 State Change
  if (!ARESETn)State_M1<=`INITIAL;
  else State_M1<=NextState_M1; 
end

always_comb begin : Decide_NextState_M1 //DM
    unique case (State_M1)
      `INITIAL:NextState_M1=`IDLE;
	  `IDLE:NextState_M1=(DM_WEN_BIT!=4'b1111&&CPU_stall&&!DM_write_en)?`WRITE_ADDRESS:(DM_read_en&&CPU_stall)?
	                     `READ_ADDRESS:`IDLE;
      `READ_ADDRESS:NextState_M1=(ARVALID_M1&&ARREADY_M1)?`READ_DATA:`READ_ADDRESS;
      `READ_DATA:NextState_M1=(RVALID_M1&&RREADY_M1&&RLAST_M1)?`IDLE:`READ_DATA;
      `WRITE_ADDRESS:NextState_M1=(AWVALID_M1 && AWREADY_M1)?`WRITE_DATA:`WRITE_ADDRESS;
	  
      `WRITE_DATA:NextState_M1=(WVALID_M1&&WREADY_M1&&WLAST_M1)?`WRITE_RESPONSE:`WRITE_DATA;//(WLAST_M1)
      `WRITE_RESPONSE:NextState_M1=(BVALID_M1 && BREADY_M1)?`IDLE:`WRITE_WAIT;
	  `WRITE_WAIT:NextState_M1=`WRITE_RESPONSE;
    endcase   
end

always_ff @( posedge ACLK or negedge ARESETn ) begin //Store instruction and read Data
	if (!ARESETn)store_RDATA_M1 <= 32'd0;
	else begin
		unique case (State_M1)
		    `INITIAL:store_RDATA_M1<=32'd0;
			`IDLE:store_RDATA_M1<=store_RDATA_M1;
		    `READ_ADDRESS:store_RDATA_M1<=32'd0;
            `READ_DATA:store_RDATA_M1<= RDATA_M1;
		default:store_RDATA_M1<=store_RDATA_M1;
		endcase
	end
end

always_comb begin 
    unique case (State_M1)
      `INITIAL:begin
		//READ ADDRESS1
		ARVALID_M1=1'd0;//DM_read_en;
		
		//ARID_M1=(DM_read_en)?{3'b000,DM_A[16]} : 4'd0;
		ARID_M1= 4'd1; //0
		ARADDR_M1= 32'b0;
		//READ DATA1
		RREADY_M1=1'd0;
		//WRITE ADDRESS
		AWVALID_M1=1'b0;//(DM_WEN_BIT != 4'b1111);
		AWID_M1=4'd0;
		AWADDR_M1=32'd0;
		//WRITE DATA
		WDATA_M1=32'd0;
		WSTRB_M1=4'd0;
		WLAST_M1=1'b0;
		WVALID_M1=1'b0;//**
		//WRITE RESPONSE
		BREADY_M1=1'b0;
		DM_out=32'd0;
		//DM_out=32'd0;
		M1_flag=1'b0;
      end
      `IDLE:begin
	  //READ ADDRESS1
		ARVALID_M1=1'd0;//DM_read_en;
		
		//ARID_M1=(DM_read_en)?{3'b000,DM_A[16]} : 4'd0;
		ARID_M1= 4'd1; //0
		ARADDR_M1=(DM_read_en)?DM_A : 32'b0;
		//READ DATA1
		RREADY_M1=1'd0;
		//WRITE ADDRESS
		AWVALID_M1=1'b0;//(DM_WEN_BIT != 4'b1111);
		AWID_M1=(DM_WEN_BIT!=4'b1111&&!DM_write_en)?{3'b000,DM_A[16]}:4'd0;
		AWADDR_M1=(DM_WEN_BIT!=4'b1111&&!DM_write_en)?DM_A:32'd0;
		//WRITE DATA
		WDATA_M1=32'd0;
		WSTRB_M1=4'd0;
		WLAST_M1=1'b0;
		WVALID_M1=1'b0;//**
		//WRITE RESPONSE
		BREADY_M1=1'b0;
		DM_out=store_RDATA_M1;
		//DM_out=32'd0;
		M1_flag=1'b0;
	  end
      `READ_ADDRESS:begin
		//***READ ADDRESS1***
		
		//ARID_M1={3'b000,DM_A[16]};  //0000->from IM 0001->fromDM
		
		ARID_M1= 4'd1;
		
		ARADDR_M1=DM_A;
		ARVALID_M1=1'd1;
		//READ DATA1
		RREADY_M1=1'd0;
		//WRITE ADDRESS
		AWVALID_M1=1'd0;
		AWID_M1=4'd0;
		AWADDR_M1=32'd0;
		//WRITE DATA
		WDATA_M1=32'd0;
		WSTRB_M1=4'd0;
		WLAST_M1=1'b0;
		WVALID_M1=1'b0;
		//WRITE RESPONSE
		BREADY_M1=1'b0;
		
		DM_out=store_RDATA_M1;
        //DM_out=32'd0;
		M1_flag=(!M0_flag)?1'b1:1'b0;
      end

      `READ_DATA:begin
		//READ ADDRESS1
		ARID_M1=4'd1;
		
		ARADDR_M1=32'd0;
		ARVALID_M1=1'd0;
		//***READ DATA1***
		RREADY_M1=1'd1;
		//WRITE ADDRESS
		AWVALID_M1=1'd0;
		AWID_M1=4'd0;
		AWADDR_M1=32'd0;
		//WRITE DATA
		WDATA_M1=32'd0;
		WSTRB_M1=4'd0;
		WLAST_M1=1'b0;
		WVALID_M1=1'b0;
		//WRITE RESPONSE
		BREADY_M1=1'b0;
		
		DM_out=RDATA_M1;
		M1_flag=(!M0_flag)?1'b1:1'b0;
      end

      `WRITE_ADDRESS:begin
		//READ ADDRESS1
		ARID_M1=4'd1;
		
		ARADDR_M1=32'd0;
		ARVALID_M1=1'd0;
		//READ DATA1
		RREADY_M1=1'd0;
		//***WRITE ADDRESS***
		AWVALID_M1=1'd1;
		AWID_M1={3'b000,DM_A[16]};  //0000->from IM 0001->fromDM
		AWADDR_M1=DM_A;
		//WRITE DATA
		WDATA_M1=32'd0;
		WSTRB_M1=4'd0;
		WLAST_M1=1'b0;
		WVALID_M1=1'b0;
		//WRITE RESPONSE
		BREADY_M1=1'b0;
		
		DM_out=store_RDATA_M1;
		//DM_out=32'd0;
		M1_flag=(!M0_flag)?1'b1:1'b0;
      end

      `WRITE_DATA:begin
		//READ ADDRESS1
		ARID_M1=4'd1;
		
		ARADDR_M1=32'd0;
		ARVALID_M1=1'd0;
		//READ DATA1
		RREADY_M1=1'd0;
		//WRITE ADDRESS
		AWVALID_M1=1'd0;
		AWID_M1=4'd0;
		AWADDR_M1=32'd0;
		//***WRITE DATA***
		WDATA_M1=DM_in;
		WSTRB_M1=DM_WEN_BIT;
		WLAST_M1=1'b1;
		WVALID_M1=1'b1;
		//WRITE RESPONSE
		BREADY_M1=1'b0;
		
		DM_out=store_RDATA_M1;
		//DM_out=32'd0;
		M1_flag=(!M0_flag)?1'b1:1'b0;
      end

      `WRITE_RESPONSE:begin
		//READ ADDRESS1
		ARID_M1=4'd1;
		
		ARADDR_M1=32'd0;
		ARVALID_M1=1'd0;
		//READ DATA1
		RREADY_M1=1'd0;
		//WRITE ADDRESS
		AWVALID_M1=1'd0;
		AWID_M1=4'd0;
		AWADDR_M1=32'd0;
		//WRITE DATA
		WDATA_M1=32'd0;
		WSTRB_M1=4'd0;
		WLAST_M1=1'b0;
		WVALID_M1=1'b0;
		//***WRITE RESPONSE***
		BREADY_M1=1'b1;
		
		DM_out=store_RDATA_M1;
		//DM_out=32'd0;
		M1_flag=(!M0_flag)?1'b1:1'b0;
      end

      default:begin
		//READ ADDRESS1
		ARID_M1=4'd1;
		
		ARADDR_M1=32'd0;
		ARVALID_M1=1'd0;
		//READ DATA1
		RREADY_M1=1'd0;
		//WRITE ADDRESS
		AWVALID_M1=1'd0;
		AWID_M1=4'd0;
		AWADDR_M1=32'd0;
		//WRITE DATA
		WDATA_M1=32'd0;
		WSTRB_M1=4'd0;
		WLAST_M1=1'b0;
		WVALID_M1=1'b0;
		//WRITE RESPONSE
		BREADY_M1=1'b0;	
		DM_out=32'd0;	
		M1_flag=1'b0;
      end
    endcase   
end
endmodule
