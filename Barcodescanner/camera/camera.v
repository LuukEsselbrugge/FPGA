
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module camera(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK_50,

	//////////// KEY //////////
	input 		     [0:0]		KEY,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,

	//////////// GPIO, GPIO connect to D8M-GPIO //////////
	inout 		          		CAMERA_I2C_SCL,
	inout 		          		CAMERA_I2C_SDA,
	output		          		CAMERA_PWDN_n,
	output		          		MIPI_CS_n,
	inout 		          		MIPI_I2C_SCL,
	inout 		          		MIPI_I2C_SDA,
	output		          		MIPI_MCLK,
	input 		          		MIPI_PIXEL_CLK,
	input 		     [9:0]		MIPI_PIXEL_D,
	input 		          		MIPI_PIXEL_HS,
	input 		          		MIPI_PIXEL_VS,
	output		          		MIPI_REFCLK,
	output		          		MIPI_RESET_n,
	output			[15:0]			H_Cont,
	output			[15:0]				V_Cont
);

//=============================================================================
// REG/WIRE declarations
//=============================================================================
  wire        AUTO_FOC ;
  wire        READ_Request ;
  wire 	[7:0]VGA_B_A;
  wire 	[7:0]VGA_G_A;
  wire 	[7:0]VGA_R_A;
 wire        VGA_CLK_25M ;
  wire        RESET_N  ; 
  wire  [7:0]sCCD_R;
  wire  [7:0]sCCD_G;
  wire  [7:0]sCCD_B; 
  //wire [15:0] H_Cont ; 
  //wire [15:0] V_Cont ; 
  wire        I2C_RELEASE ;  
  wire        CAMERA_I2C_SCL_MIPI ; 
  wire        CAMERA_I2C_SCL_AF ;
  wire        CAMERA_MIPI_RELAESE ;
  wire        MIPI_BRIDGE_RELEASE ;
  wire        D8M_CK_HZ  ; 
  wire        D8M_CK_HZ2 ; 
  wire        D8M_CK_HZ3 ; 
  wire        RESET_KEY ; 
  wire   [9:0]MIPI_PIXEL_D_ ;
  wire        MIPI_PIXEL_VS_; 
  wire        MIPI_PIXEL_HS_;  
  
wire        LUT_MIPI_PIXEL_HS;
wire        LUT_MIPI_PIXEL_VS;
wire [9:0]  LUT_MIPI_PIXEL_D  ;
wire        MIPI_PIXEL_CLK_; 
//=======================================================
// Structural coding
//=======================================================

//--INPU MIPI-PIXEL-CLOCK DELAY
CLOCK_DELAY  del1(  .iCLK (MIPI_PIXEL_CLK),  .oCLK (MIPI_PIXEL_CLK_ ) );

//--D8M INPUT Gamma Correction              
 D8M_LUT  g_lut(
	.enable           (0) , // SW[0]            ),
	.PIXEL_CLK        (MIPI_PIXEL_CLK_   ),
	.MIPI_PIXEL_HS    (MIPI_PIXEL_HS    ),
	.MIPI_PIXEL_VS    (MIPI_PIXEL_VS    ),
	.MIPI_PIXEL_D     (MIPI_PIXEL_D     ),
	.NEW_MIPI_PIXEL_HS(LUT_MIPI_PIXEL_HS),
	.NEW_MIPI_PIXEL_VS(LUT_MIPI_PIXEL_VS),
	.NEW_MIPI_PIXEL_D (LUT_MIPI_PIXEL_D )
);




assign UART_RTS =0; 
assign UART_TXD =0; 
assign RESET_KEY   = KEY[0]; 

//----- RESET RELAY  --		
RESET_DELAY			u2	(	
							.iRST  ( RESET_KEY ),
                     .iCLK  ( CLOCK2_50 ),				
						   .oREADY( RESET_N)  
							
						);

assign MIPI_RESET_n   = RESET_N;
assign CAMERA_PWDN_n  = RESET_KEY; 
assign MIPI_CS_n      = 0; 

//------ CAMERA I2C COM BUS --------------------
assign I2C_RELEASE    = CAMERA_MIPI_RELAESE & MIPI_BRIDGE_RELEASE; 
assign CAMERA_I2C_SCL = ( I2C_RELEASE  )? CAMERA_I2C_SCL_AF  : CAMERA_I2C_SCL_MIPI ;   
 
//------ MIPI BRIDGE  I2C SETTING--------------- 
MIPI_BRIDGE_CAMERA_Config    cfin(
   .RESET_N           ( RESET_N  ), 
   .CLK_50            ( CLOCK2_50), 
   .MIPI_I2C_SCL      ( MIPI_I2C_SCL ), 
   .MIPI_I2C_SDA      ( MIPI_I2C_SDA ), 
   .MIPI_I2C_RELEASE  ( MIPI_BRIDGE_RELEASE ),  
   .CAMERA_I2C_SCL    ( CAMERA_I2C_SCL_MIPI ),
   .CAMERA_I2C_SDA    ( CAMERA_I2C_SDA ),
   .CAMERA_I2C_RELAESE( CAMERA_MIPI_RELAESE )
);
 
//-- Video PLL --- 
pll_test  ref(
	   .inclk0    ( CLOCK2_50 ),
	   .areset       ( 1'b0 ),
	   .c0  ( MIPI_REFCLK ),    //20Mhz
	   .c1  ( VGA_CLK_25M )     //25Mhz
);



//--- D8M RAWDATA to RGB ---
D8M_SET   ccd (
	.RESET_SYS_N  ( RESET_N ),
   .CLOCK_50     ( CLOCK2_50      ),
	.CCD_DATA     ( LUT_MIPI_PIXEL_D [9:0]) ,
	.CCD_FVAL     ( LUT_MIPI_PIXEL_VS ), //60HZ
	.CCD_LVAL	  ( LUT_MIPI_PIXEL_HS ), // 
	.CCD_PIXCLK   ( MIPI_PIXEL_CLK_), //25MHZ
	.READ_EN      (READ_Request) , 	
   .VGA_CLK      ( VGA_CLK),
   .VGA_HS       ( VGA_HS ),
   .VGA_VS       ( VGA_VS ),	
	.X_Cont       ( H_Cont),  
   .Y_Cont       ( V_Cont),   
   .sCCD_R       ( sCCD_R ),
   .sCCD_G       ( sCCD_G ),
   .sCCD_B       ( sCCD_B )
);


//--- By Trigged VGA Controller --  


VGA_Controller_trig	u1	(	
	  .iCLK       ( MIPI_PIXEL_CLK_ ), 
     .H_Cont(H_Cont),  
     .V_Cont(V_Cont),  
	  .READ_Request(READ_Request)	 , 	  
     .iRed       ( sCCD_R[7:0]   ),
	  .iGreen     ( sCCD_G[7:0]   ),
	  .iBlue      ( sCCD_B[7:0]   ),
	  	
		
	  .oVGA_R     ( VGA_R ),
	  .oVGA_G     ( VGA_G ),
	  .oVGA_B     ( VGA_B ),
     .oVGA_H_SYNC( VGA_HS ),
     .oVGA_V_SYNC( VGA_VS ),	  
	  .oVGA_SYNC  ( VGA_SYNC_N  ),
	  .oVGA_BLANK ( VGA_BLANK_N ),
	  .oVGA_CLOCK ( VGA_CLK     ),
	  .iRST_N     ( RESET_N )	,	

);
//
////------AOTO FOCUS ENABLE  --
//AUTO_FOCUS_ON  adj( 
//                      .CLK_50      ( CLOCK2_50 ), 
//                      .I2C_RELEASE ( I2C_RELEASE ), 
//                      .AUTO_FOC    ( AUTO_FOC )
//               ) ;
////------Auto focus ------- 
//FOCUS_ADJ adl(
//     .CLK_50        ( CLOCK2_50   ), 
//     .RESET_N       ( I2C_RELEASE ), 
//     .RESET_SUB_N   ( I2C_RELEASE ), 
//     .AUTO_FOC      ( KEY[3] & AUTO_FOC ),   
//     .SW_FUC_LINE   ( SW[3] ),   
//     .SW_FUC_ALL_CEN( SW[3] ),
//     .VIDEO_HS      ( VGA_HS),
//     .VIDEO_VS      ( VGA_VS),
//     .VIDEO_CLK     ( VGA_CLK),
//     .VIDEO_DE      (READ_Request) ,
//     .iR            ( VGA_R_A), 
//     .iG            ( VGA_G_A), 
//     .iB            ( VGA_B_A), 
//     
//     .oR            ( VGA_R), 
//     .oG            ( VGA_G), 
//     .oB            ( VGA_B), 
//     
//     .READY         (  READY),
//     .SCL           ( CAMERA_I2C_SCL_AF ), 
//     .SDA           ( CAMERA_I2C_SDA    )
//);							
//
//
//
//
////--Frame Counter -- 
// FpsMonitor uFps2(
//	  .clk50    ( CLOCK2_50 ),
//	  .vs       ( VGA_VS    ),//LUT_MIPI_PIXEL_VS ), //60HZ
//	  .fps      (  ),
//	  .hex_fps_h( HEX1 ),
//	  .hex_fps_l( HEX0 )
//);
//
//
////----7-SEG OFF----
//assign  HEX2 = 7'h7F;
//assign  HEX3 = 7'h7F;
//assign  HEX4 = 7'h7F;
//assign  HEX5 = 7'h7F;
//assign  HEX6 = 7'h7F;
//assign  HEX7 = 7'h7F;
//
//--FREQUNCY TEST--
CLOCKMEM  ck1 ( .CLK(VGA_CLK_25M    ),.CLK_FREQ  (25000000  ),.CK_1HZ (D8M_CK_HZ   ));
CLOCKMEM  ck2 ( .CLK(MIPI_REFCLK    ),.CLK_FREQ  (20000000  ),.CK_1HZ (D8M_CK_HZ2  ));
CLOCKMEM  ck3 ( .CLK(MIPI_PIXEL_CLK_),.CLK_FREQ  (25000000 ),.CK_1HZ (D8M_CK_HZ3   ));

//--LED STATUS-----
//assign LEDR[9:0] = { D8M_CK_HZ ,D8M_CK_HZ2,D8M_CK_HZ3 ,5'h0,CAMERA_MIPI_RELAESE ,MIPI_BRIDGE_RELEASE } ; 
endmodule