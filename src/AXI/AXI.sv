`include "../include/AXI_define.svh"

module AXI(

	input ACLK,
	input ARESETn,

	//SLAVE INTERFACE FOR MASTERS
	
	//WRITE ADDRESS
	input [`AXI_ID_BITS-1:0] AWID_M1,
	input [`AXI_ADDR_BITS-1:0] AWADDR_M1,
	input [`AXI_LEN_BITS-1:0] AWLEN_M1,
	input [`AXI_SIZE_BITS-1:0] AWSIZE_M1,
	input [1:0] AWBURST_M1,
	input AWVALID_M1,
	output logic AWREADY_M1,
	
	//WRITE DATA
	input [`AXI_DATA_BITS-1:0] WDATA_M1,
	input [`AXI_STRB_BITS-1:0] WSTRB_M1,
	input WLAST_M1,
	input WVALID_M1,
	output logic WREADY_M1,
	
	//WRITE RESPONSE
	output logic [`AXI_ID_BITS-1:0] BID_M1,
	output logic [1:0] BRESP_M1,
	output logic BVALID_M1,
	input BREADY_M1,

	//READ ADDRESS0
	input [`AXI_ID_BITS-1:0] ARID_M0,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M0,
	input [`AXI_LEN_BITS-1:0] ARLEN_M0,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M0,
	input [1:0] ARBURST_M0,
	input ARVALID_M0,
	output logic ARREADY_M0,
	
	//READ DATA0
	output logic [`AXI_ID_BITS-1:0] RID_M0,
	output logic [`AXI_DATA_BITS-1:0] RDATA_M0,
	output logic [1:0] RRESP_M0,
	output logic RLAST_M0,
	output logic RVALID_M0,
	input RREADY_M0,
	
	//READ ADDRESS1
	input [`AXI_ID_BITS-1:0] ARID_M1,
	input [`AXI_ADDR_BITS-1:0] ARADDR_M1,
	input [`AXI_LEN_BITS-1:0] ARLEN_M1,
	input [`AXI_SIZE_BITS-1:0] ARSIZE_M1,
	input [1:0] ARBURST_M1,
	input ARVALID_M1,
	output logic ARREADY_M1,
	
	//READ DATA1
	output logic [`AXI_ID_BITS-1:0] RID_M1,
	output logic [`AXI_DATA_BITS-1:0] RDATA_M1,
	output logic [1:0] RRESP_M1,
	output logic RLAST_M1,
	output logic RVALID_M1,
	input RREADY_M1,

	//MASTER INTERFACE FOR SLAVES
	//WRITE ADDRESS0
	output logic [`AXI_IDS_BITS-1:0] AWID_S0,
	output logic [`AXI_ADDR_BITS-1:0] AWADDR_S0,
	output logic [`AXI_LEN_BITS-1:0] AWLEN_S0,
	output logic [`AXI_SIZE_BITS-1:0] AWSIZE_S0,
	output logic [1:0] AWBURST_S0,
	output logic AWVALID_S0,
	input AWREADY_S0,
	
	//WRITE DATA0
	output logic [`AXI_DATA_BITS-1:0] WDATA_S0,
	output logic [`AXI_STRB_BITS-1:0] WSTRB_S0,
	output logic WLAST_S0,
	output logic WVALID_S0,
	input WREADY_S0,
	
	//WRITE RESPONSE0
	input [`AXI_IDS_BITS-1:0] BID_S0,
	input [1:0] BRESP_S0,
	input BVALID_S0,
	output logic BREADY_S0,
	
	//WRITE ADDRESS1
	output logic [`AXI_IDS_BITS-1:0] AWID_S1,
	output logic [`AXI_ADDR_BITS-1:0] AWADDR_S1,
	output logic [`AXI_LEN_BITS-1:0] AWLEN_S1,
	output logic [`AXI_SIZE_BITS-1:0] AWSIZE_S1,
	output logic [1:0] AWBURST_S1,
	output logic AWVALID_S1,
	input AWREADY_S1,
	
	//WRITE DATA1
	output logic [`AXI_DATA_BITS-1:0] WDATA_S1,
	output logic [`AXI_STRB_BITS-1:0] WSTRB_S1,
	output logic WLAST_S1,
	output logic WVALID_S1,
	input WREADY_S1,
	
	//WRITE RESPONSE1
	input [`AXI_IDS_BITS-1:0] BID_S1,
	input [1:0] BRESP_S1,
	input BVALID_S1,
	output logic BREADY_S1,
	
	//READ ADDRESS0
	output logic [`AXI_IDS_BITS-1:0] ARID_S0,
	output logic [`AXI_ADDR_BITS-1:0] ARADDR_S0,
	output logic [`AXI_LEN_BITS-1:0] ARLEN_S0,
	output logic [`AXI_SIZE_BITS-1:0] ARSIZE_S0,
	output logic [1:0] ARBURST_S0,
	output logic ARVALID_S0,
	input ARREADY_S0,
	
	//READ DATA0
	input [`AXI_IDS_BITS-1:0] RID_S0,
	input [`AXI_DATA_BITS-1:0] RDATA_S0,
	input [1:0] RRESP_S0,
	input RLAST_S0,
	input RVALID_S0,
	output logic RREADY_S0,
	
	//READ ADDRESS1
	output logic [`AXI_IDS_BITS-1:0] ARID_S1,
	output logic [`AXI_ADDR_BITS-1:0] ARADDR_S1,
	output logic [`AXI_LEN_BITS-1:0] ARLEN_S1,
	output logic [`AXI_SIZE_BITS-1:0] ARSIZE_S1,
	output logic [1:0] ARBURST_S1,
	output logic ARVALID_S1,
	input ARREADY_S1,
	
	//READ DATA1
	input [`AXI_IDS_BITS-1:0] RID_S1,
	input [`AXI_DATA_BITS-1:0] RDATA_S1,
	input [1:0] RRESP_S1,
	input RLAST_S1,
	input RVALID_S1,
	output logic RREADY_S1
	
);
//---------- you should put your design here ----------//

//---------- ID ----------//
localparam S0_ID=1'b0;
localparam S1_ID=1'b1;
localparam M0_ID=1'b0;
localparam M1_ID=1'b1;

//---------- state machine ----------//
localparam HANSHAKE_OK = 2'b10;
localparam HANSHAKE_NOT_OK = 2'b11;

//---------------------  AR channel----------------------------//
localparam AR_state = 2'b10;
logic [2:0] Arbitration_AR;//{valid,from master,to slave}
logic [`AXI_IDS_BITS-1:0]  ARID;
logic [`AXI_ADDR_BITS-1:0] ARADDR;
logic [`AXI_LEN_BITS-1:0]  ARLEN;
logic [`AXI_SIZE_BITS-1:0] ARSIZE;
logic [1:0] ARBURST;
logic ARVALID;
logic ARREADY;
logic [2:0]Arbitration_AR_wait; //{valid,from master,to slave}
logic [`AXI_IDS_BITS-1:0]  ARID_wait;
logic [`AXI_ADDR_BITS-1:0] ARADDR_wait;
logic [`AXI_LEN_BITS-1:0]  ARLEN_wait;
logic [`AXI_SIZE_BITS-1:0] ARSIZE_wait;
logic [1:0]ARBURST_wait;
logic ARVALID_wait;
logic ARREADY_wait;
logic [1:0] Current_state_AR;
logic [1:0] Next_state_AR;
logic [1:0] state;
logic [1:0] Next_state;
logic Finish_AR;

//---------------------  R channel----------------------------//
logic [1:0] Current_state_R;
logic [1:0] Next_state_R;
localparam R_state  = 2'b11;
logic [2:0]                Arbitration_R;//{valid,from slave ,to master}
logic [`AXI_ID_BITS-1:0]   RID;
logic [`AXI_DATA_BITS-1:0] RDATA;
logic [1:0]                RRESP;
logic                      RLAST;
logic                      RVALID;
logic                      RREADY;
logic [2:0]Arbitration_R_wait;//{valid,from slave ,to master}
logic [`AXI_ID_BITS-1:0]RID_wait;
logic [`AXI_DATA_BITS-1:0] RDATA_wait;
logic [1:0] RRESP_wait;
logic RLAST_wait;
logic RVALID_wait;
logic RREADY_wait;

//--------------------- AW channel----------------------------//
logic [1:0] Current_state_W;
logic [1:0] Next_state_W;
logic Flag_AW;
logic Flag_W;
localparam WorAW_State = 2'b10;
localparam B_State     = 2'b11;
logic [2:0]Arbitration_AW;//{valid,frrom,to}
logic [`AXI_IDS_BITS-1:0]  AWID;
logic [`AXI_ADDR_BITS-1:0] AWADDR;
logic [`AXI_LEN_BITS-1:0]  AWLEN;
logic [`AXI_SIZE_BITS-1:0] AWSIZE;
logic [1:0]                AWBURST;
logic                      AWVALID;
logic                      AWREADY;

//---------------------  W channel----------------------------//
logic [2:0]Arbitration_W;//{valid,from master ,to slave}
logic [`AXI_DATA_BITS-1:0] WDATA;
logic [`AXI_STRB_BITS-1:0] WSTRB;
logic                      WLAST;
logic                      WVALID;
logic                      WREADY;

//---------------------  B channel ----------------------------//
logic [2:0]Arbitration_B;//{valid,from slave ,to master}
logic [`AXI_ID_BITS-1:0] BID;
logic [1:0] BRESP;
logic        BVALID;
logic        BREADY;



//--------------------- AR R state machine----------------------------//
always_ff @(posedge ACLK or negedge ARESETn) begin
	if(!ARESETn)state<=AR_state;	
	else state<=Next_state;	
end

always_comb begin
	if(state==AR_state)Next_state=((!ARVALID_wait&&ARVALID&&ARREADY)||(ARVALID_wait&&ARREADY))?
		                               R_state:AR_state;			
	else Next_state=((!RVALID_wait&&RVALID&&RREADY&&RLAST)||(RVALID_wait&&RREADY&&RLAST))?
		             AR_state:R_state;
end

//--------------------- AR channel----------------------------//
always_ff @(posedge ACLK or negedge ARESETn) begin : decide_State_AR
	if(!ARESETn)Current_state_AR<=HANSHAKE_OK;
	else Current_state_AR<= Next_state_AR;		
end

always_comb begin : decide_NextState_AR
	case (Current_state_AR)
		HANSHAKE_OK:Next_state_AR=(ARVALID&&!ARREADY)?HANSHAKE_NOT_OK:HANSHAKE_OK;
		HANSHAKE_NOT_OK:Next_state_AR=(ARVALID_wait && ARREADY)?HANSHAKE_OK:HANSHAKE_NOT_OK;
		default:Next_state_AR=HANSHAKE_OK;	
	endcase
end

assign Arbitration_AR=(ARVALID_M0&&state==AR_state)?{1'b1,M0_ID,ARADDR_M0[16]}:
                              (ARVALID_M1&&state==AR_state)?{1'b1,M1_ID,ARADDR_M1[16]}:3'b000;


//Decoder AR M
always_comb begin
	if ({Arbitration_AR[2],Arbitration_AR[1]}==2'b10)begin
	    ARID={ARID_M0,2'b00,Arbitration_AR[1:0]};
		ARADDR=ARADDR_M0;
		ARLEN=ARLEN_M0;
		ARSIZE=ARSIZE_M0;
		ARBURST=ARBURST_M0;
		ARVALID=ARVALID_M0;
	end
	else if({Arbitration_AR[2],Arbitration_AR[1]}==2'b11) begin
	    ARID={ARID_M1,2'b00,Arbitration_AR[1:0]};
		ARADDR=ARADDR_M1;
		ARLEN=ARLEN_M1;
		ARSIZE=ARSIZE_M1;
		ARBURST=ARBURST_M1;
		ARVALID=ARVALID_M1;
	end
	else begin
	    ARID=8'd0;
		ARADDR=32'd0;
		ARLEN=4'd0;
		ARSIZE=3'd0;
		ARBURST=2'd0;
		ARVALID=1'b0;
	end
end

//Decoder AR S
always_comb begin 
	if(Current_state_AR==HANSHAKE_OK) begin
		if ({Arbitration_AR[2],Arbitration_AR[0]}==2'b10)ARREADY=ARREADY_S0;
		else if ({Arbitration_AR[2],Arbitration_AR[0]}==2'b11)ARREADY=ARREADY_S1;
		else ARREADY=1'b0;
	end
	else begin
		if ({Arbitration_AR_wait[2],Arbitration_AR_wait[0]}==2'b10)ARREADY=ARREADY_S0;
		else if ({Arbitration_AR_wait[2],Arbitration_AR_wait[0]}==2'b11)ARREADY=ARREADY_S1;
		else ARREADY=1'b0;
	end
end

always_comb begin 
	if(Current_state_AR==HANSHAKE_OK) begin //Current_state_AR == HANSHAKE_OK
		//M0
		ARREADY_M0=(Arbitration_AR[2]&&Arbitration_AR[1]==M0_ID)?ARREADY:1'b0;
		//M1
		ARREADY_M1=(Arbitration_AR[2]&&Arbitration_AR[1]==M1_ID)?ARREADY:1'b0;
		//S0
		ARID_S0=ARID;
		ARADDR_S0=ARADDR;
		ARLEN_S0=ARLEN;
		ARSIZE_S0=ARSIZE; 
		ARBURST_S0=ARBURST;
		ARVALID_S0=(Arbitration_AR[2]&&Arbitration_AR[0]==S0_ID)?ARVALID:1'b0;
		//S1
		ARID_S1=ARID;
		ARADDR_S1=ARADDR;
		ARLEN_S1=ARLEN;
		ARSIZE_S1=ARSIZE; 
		ARBURST_S1=ARBURST;
		ARVALID_S1=(Arbitration_AR[2]&&Arbitration_AR[0]==S1_ID)?ARVALID:1'b0;
	end
	else begin                   //Current_state_AR == s2_Wait ready
		//M0
		ARREADY_M0=(Arbitration_AR_wait[2]&&Arbitration_AR_wait[1]==M0_ID)?ARREADY:1'b0;
		//M1
		ARREADY_M1=(Arbitration_AR_wait[2]&&Arbitration_AR_wait[1]==M1_ID)?ARREADY:1'b0;
		//S0
		ARID_S0=ARID_wait;
		ARADDR_S0=ARADDR_wait;
		ARLEN_S0=ARLEN_wait;
		ARSIZE_S0=ARSIZE_wait; 
		ARBURST_S0=ARBURST_wait;
		ARVALID_S0=(Arbitration_AR_wait[2]&&Arbitration_AR_wait[0]==S0_ID)?ARVALID_wait:1'b0 ;
		//S1
		ARID_S1=ARID_wait;
		ARADDR_S1=ARADDR_wait;
		ARLEN_S1=ARLEN_wait;
		ARSIZE_S1=ARSIZE_wait; 
		ARBURST_S1=ARBURST_wait;
		ARVALID_S1=(Arbitration_AR_wait[2]&&Arbitration_AR_wait[0]==S1_ID)?ARVALID_wait:1'b0 ;
	end
end

//wait for ready AR
always_ff @(posedge ACLK or negedge ARESETn) begin 
	if(!ARESETn) begin
		Arbitration_AR_wait<=3'd0;
		ARID_wait<=8'd0;
		ARADDR_wait<=32'd0;
		ARLEN_wait<=4'd0;
		ARSIZE_wait<=3'd0;
		ARBURST_wait<=2'd0;
		ARVALID_wait<=1'b0;

	end
	else begin
		if(Current_state_AR == HANSHAKE_OK) begin
			Arbitration_AR_wait<=Arbitration_AR;
			ARID_wait<=ARID;
			ARADDR_wait<=ARADDR;
			ARLEN_wait<=ARLEN;
			ARSIZE_wait<=ARSIZE;
			ARBURST_wait<=ARBURST;
			ARVALID_wait<=ARVALID;

		end
		else begin
			Arbitration_AR_wait<=Arbitration_AR_wait;
			ARID_wait<=ARID_wait;
			ARADDR_wait<=ARADDR_wait;
			ARLEN_wait<=ARLEN_wait;
			ARSIZE_wait<=ARSIZE_wait;
			ARBURST_wait<=ARBURST_wait;
			ARVALID_wait<=ARVALID_wait;

		end	
	end	
end


//---------------------  R channel----------------------------//
always_ff @(posedge ACLK or negedge ARESETn) begin : decide_State_R
	if(!ARESETn)Current_state_R<=HANSHAKE_OK;
	else Current_state_R<=Next_state_R;	
end

//Decide NextState_R   
always_comb begin
	case (Current_state_R)
		HANSHAKE_OK:Next_state_R=(RVALID&&!RREADY)?HANSHAKE_NOT_OK:HANSHAKE_OK;
		HANSHAKE_NOT_OK:Next_state_R=(RVALID_wait&&RREADY)?HANSHAKE_OK:HANSHAKE_NOT_OK; //S2 wait for ready after valid
		default:Next_state_R=HANSHAKE_OK;	
	endcase
end


assign Arbitration_R=(RVALID_S0&&state==R_state)?{1'b1,S0_ID,RID_S0[1]}:
                             (RVALID_S1&&state==R_state)?{1'b1,S1_ID,RID_S1[1]}:3'b000;

//Decoder R1
always_comb begin
    if({Arbitration_R[2],Arbitration_R[1]}==2'b10)begin
	    RID=RID_S0[7:4];
		RDATA=RDATA_S0;
		RRESP=RRESP_S0;
		RLAST=RLAST_S0;
		RVALID=RVALID_S0;
	end
	else if({Arbitration_R[2],Arbitration_R[1]}==2'b11)begin
	    RID=RID_S1[7:4];
		RDATA=RDATA_S1;
		RRESP=RRESP_S1;
		RLAST=RLAST_S1;
		RVALID=RVALID_S1;
	end 
	else begin
	    RID=4'd0;
		RDATA=32'd0;
		RRESP=2'd0;
		RLAST=1'b0;
		RVALID=1'b0;
	end
end

//Decoder R2
always_comb begin 
	if(Current_state_R==HANSHAKE_OK) begin
	    if ({Arbitration_R[2],Arbitration_R[0]}==2'b10)RREADY=RREADY_M0;
		else if ({Arbitration_R[2],Arbitration_R[0]}==2'b11)RREADY=RREADY_M1;
		else RREADY=1'b0;
	end
	else begin
	    if ({Arbitration_R_wait[2],Arbitration_R_wait[0]}==2'b10)RREADY=RREADY_M0;
		else if ({Arbitration_R_wait[2],Arbitration_R_wait[0]}==2'b11)RREADY=RREADY_M1;
		else RREADY=1'b0;
	end	
end

//Output logic R
always_comb begin 
	if(Current_state_R==HANSHAKE_OK) begin //Current_state_AR == HANSHAKE_OK
		//S0
		RREADY_S0=(Arbitration_R[2]&&Arbitration_R[1]==S0_ID)?RREADY:1'b0;

		//S1
		RREADY_S1=(Arbitration_R[2]&&Arbitration_R[1]==S1_ID)?RREADY:1'b0;

		//M0
		RID_M0=RID;
		RDATA_M0=RDATA;
		RRESP_M0=RRESP;
		RLAST_M0=RLAST; 
		RVALID_M0=(Arbitration_R[2]&&Arbitration_R[0]==M0_ID)?RVALID:1'b0 ;

		//M1
		RID_M1=RID;
		RDATA_M1=RDATA;
		RRESP_M1=RRESP;
		RLAST_M1=RLAST; 
		RVALID_M1=(Arbitration_R[2]&&Arbitration_R[0]==M1_ID)?RVALID:1'b0;
	end
	else begin                   //Current_state_AR == s2_Wait ready
		//S0
		RREADY_S0=(Arbitration_R_wait[2]&&Arbitration_R_wait[1]==S0_ID)?RREADY:1'b0;

		//S1
		RREADY_S1=(Arbitration_R_wait[2]&&Arbitration_R_wait[1]==S1_ID)?RREADY:1'b0;

		//M0
		RID_M0=RID_wait;
		RDATA_M0=RDATA_wait;
		RRESP_M0=RRESP_wait;
		RLAST_M0=RLAST_wait; 
		RVALID_M0=(Arbitration_R_wait[2]&&Arbitration_R_wait[0]==M0_ID)?RVALID_wait:1'b0;

		//M1
		RID_M1=RID_wait;
		RDATA_M1=RDATA_wait;
		RRESP_M1=RRESP_wait;
		RLAST_M1=RLAST_wait; 
		RVALID_M1=(Arbitration_R_wait[2]&&Arbitration_R_wait[0]==M1_ID)?RVALID_wait:1'b0;
	end
end

//wait for ready R
always_ff @(posedge ACLK or negedge ARESETn) begin 
	if(!ARESETn) begin
		Arbitration_R_wait<=3'd0;
		RID_wait<=4'd0;
		RDATA_wait<=32'd0;
		RRESP_wait<=2'd0;
		RLAST_wait<=1'd0; 
		RVALID_wait<=1'b0;
	end
	else begin
		if(Current_state_R == HANSHAKE_OK) begin
			Arbitration_R_wait<=Arbitration_R;
			RID_wait<=RID;
			RDATA_wait<=RDATA;
			RRESP_wait<=RRESP;
			RLAST_wait<=RLAST; 
			RVALID_wait<=RVALID;
		end
		else begin
			Arbitration_R_wait<=Arbitration_R_wait;
			RID_wait<=RID_wait;
			RDATA_wait<=RDATA_wait;
			RRESP_wait<=RRESP_wait;
			RLAST_wait<=RLAST_wait; 
			RVALID_wait<=RVALID_wait;
		end	
	end	
end


//--------------------- AW channel----------------------------//
always_ff @(posedge ACLK or negedge ARESETn) begin
	if(!ARESETn)Current_state_W<=WorAW_State;	
	else Current_state_W<=Next_state_W;		
end

always_ff @(posedge ACLK or negedge ARESETn) begin
	if(!ARESETn) begin
		Flag_AW<=1'b0;
		Flag_W<=1'b0;
	end
	else begin
		if(Current_state_W==WorAW_State) begin
			Flag_AW<=(AWREADY&AWVALID)?1'b1:Flag_AW;
			Flag_W<=(WREADY&WVALID&WLAST)?1'b1:Flag_W;
		end
		else begin
			Flag_AW<=1'b0;
			Flag_W<=1'b0;
		end
	end
end


always_comb begin
	if(Current_state_W==WorAW_State)
		if((Flag_AW&&Flag_W))Next_state_W=B_State;
		else if(Flag_AW&&WREADY&&WVALID&&WLAST)Next_state_W=B_State;
		else if(AWREADY&&AWVALID&&Flag_W)Next_state_W=B_State; 
		else if(WLAST&&WREADY&&WVALID&&AWREADY&&AWVALID)Next_state_W=B_State;	
		else Next_state_W=WorAW_State;	 	
	else
	    Next_state_W=(BREADY&&BVALID)?WorAW_State:B_State;
end



//Decide write M to S
logic [2:0]  write_from_master_to_slave;
always_ff @(posedge ACLK or negedge ARESETn) begin 
	if(!ARESETn)write_from_master_to_slave <= 3'b000;	
	else write_from_master_to_slave<=(AWVALID && !write_from_master_to_slave[2])?{1'b1,1'b1,AWADDR[16]}:
		                            (BREADY && BVALID)?3'b000:write_from_master_to_slave;		
end 


assign Arbitration_AW=(AWVALID_M1)?{1'b1,S1_ID,AWADDR_M1[16]}:3'b000;  //[16]=0

//Decoder AW1
always_comb begin
    if({Arbitration_AW[2],Arbitration_AW[1]}==2'b11)begin
	    AWID={4'b0000,AWID_M1};
		AWADDR=AWADDR_M1;
		AWLEN=AWLEN_M1;
		AWSIZE=AWSIZE_M1;
		AWBURST=AWBURST_M1;
		AWVALID=AWVALID_M1;
	end
	else begin
	    AWID=8'd0;
		AWADDR=32'd0;
		AWLEN=4'd0;
		AWSIZE=3'd0;
		AWBURST=2'd0;
		AWVALID=1'b0;
	end
end

// Decoder AW2
assign AWREADY=({Arbitration_AW[2],Arbitration_AW[0]}==2'b10)?AWREADY_S0:
               ({Arbitration_AW[2],Arbitration_AW[0]}==2'b11)?AWREADY_S1:1'b0;




//M1
assign  AWREADY_M1 = (Arbitration_AW[2]&&Arbitration_AW[1]==M1_ID)? AWREADY : 1'b0;

//S0
assign  AWID_S0    = AWID;
assign  AWADDR_S0  = AWADDR;
assign  AWLEN_S0   = AWLEN;
assign  AWSIZE_S0  = AWSIZE;
assign  AWBURST_S0 = AWBURST;
assign  AWVALID_S0 = (Arbitration_AW[2]&&Arbitration_AW[0]==S0_ID)? AWVALID : 1'b0 ;

//S1
assign  AWID_S1    = AWID;
assign  AWADDR_S1  = AWADDR;
assign  AWLEN_S1   = AWLEN;
assign  AWSIZE_S1  = AWSIZE; 
assign  AWBURST_S1 = AWBURST;
assign  AWVALID_S1 = (Arbitration_AW[2]&&Arbitration_AW[0]==S1_ID)? AWVALID : 1'b0 ;


//---------------------  W channel----------------------------//
//Arbitration W decide
always_comb begin 
	if(WVALID_M1&&Current_state_W==WorAW_State)
        Arbitration_W=(AWVALID)?{1'b1,M1_ID,AWADDR[16]}:(write_from_master_to_slave[2])?
                             {1'b1,M1_ID,write_from_master_to_slave[0]}:{1'b0,M1_ID,AWADDR[16]};
	else Arbitration_W = 3'b000;	
end
                                    
//Decoder_W1
always_comb begin 
    if({Arbitration_W[2],Arbitration_W[1]}==2'b11)begin
	    WDATA=WDATA_M1;
		WSTRB=WSTRB_M1;
		WLAST=WLAST_M1;
		WVALID=WVALID_M1; 
	end
	else begin
	    WDATA=32'd0;
		WSTRB=4'd0;
		WLAST=1'd0;
		WVALID=1'd0;
	end
end

//Decoder W2
assign WREADY=({Arbitration_W[2],Arbitration_W[0]}==2'b10)?WREADY_S0:
              ({Arbitration_W[2],Arbitration_W[0]}==2'b11)?WREADY_S1:1'b0;

//M1
assign WREADY_M1=(Arbitration_W[2]&&Arbitration_W[1]==M1_ID)?WREADY:1'b0;

//S0 and S1
always_comb begin
	if(Arbitration_W[2]&&Arbitration_W[0]==M1_ID)begin//S1
	    WDATA_S1=WDATA;
	    WSTRB_S1=WSTRB;
	    WLAST_S1=WLAST;
	    WVALID_S1=WVALID;
	end
    else begin//S0
        WDATA_S1=WDATA;
        WSTRB_S1=WSTRB;
        WLAST_S1=WLAST;
        WVALID_S1=1'b0;
    end	
	if(Arbitration_W[2]&&Arbitration_W[0]==M0_ID)begin
	    WDATA_S0=WDATA;
	    WSTRB_S0=WSTRB;
	    WLAST_S0=WLAST;
	    WVALID_S0=WVALID;
	end
	else begin
	    WDATA_S0=WDATA;
	    WSTRB_S0=WSTRB;
	    WLAST_S0=WLAST;
	    WVALID_S0=1'b0;
	end
end

//---------------------  B channel ----------------------------//
assign Arbitration_B=(BVALID_S0&&write_from_master_to_slave[0]==1'b0&&Current_state_W==B_State)?
                             {1'b1,S0_ID,write_from_master_to_slave[1]}:
							 (BVALID_S1&&write_from_master_to_slave[0]==1'b1&&Current_state_W==B_State)?
							 {1'b1,S1_ID,write_from_master_to_slave[1]}:3'b000;

//decoder_B1							 
always_comb begin
    if({Arbitration_B[2],Arbitration_B[1]}==2'b10)begin
	    BID=BID_S0[3:0];
		BRESP=BRESP_S0;
		BVALID=BVALID_S0;
    end	
	else if ({Arbitration_B[2],Arbitration_B[1]}==2'b11)begin
	    BID=BID_S1[3:0];
		BRESP=BRESP_S1;
		BVALID=BVALID_S1;
	end
	else begin
	    BID=4'd0;
		BRESP=2'd0;
		BVALID=1'b0;
	end
end

//decoder_B2
assign BREADY=({Arbitration_B[2], Arbitration_B[0]}==2'b11)?BREADY_M1:1'b0; 


//S0
assign  BREADY_S0=(Arbitration_B[2]&&Arbitration_B[1]==S0_ID)? BREADY : 1'b0;

//S1
assign  BREADY_S1=(Arbitration_B[2]&&Arbitration_B[1]==S1_ID)? BREADY : 1'b0;

//M1
assign  BID_M1=BID;
assign  BRESP_M1=BRESP;         
assign  BVALID_M1=(Arbitration_B[2]&&Arbitration_B[0]==M1_ID)? BVALID : 1'b0 ;


endmodule
