// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2013 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.

 
// $Id: //acds/rel/13.1/ip/.../avalon-st_timing_adapter.sv.terp#1 $
// $Revision: #1 $
// $Date: 2013/09/27 $
// $Author: dmunday, korthner $

// --------------------------------------------------------------------------------
//| Avalon Streaming Timing Adapter
// --------------------------------------------------------------------------------

`timescale 1ns / 100ps
// ------------------------------------------
// Generation parameters:
//   output_name:        barcodescanner_nios_avalon_st_adapter_timing_adapter_0
//   in_use_ready:       true
//   out_use_ready:      true
//   in_use_valid:       true
//   out_use_valid:      true
//   use_packets:        true
//   use_empty:          1
//   empty_width:        2
//   data_width:         32
//   channel_width:      0
//   error_width:        6
//   in_ready_latency:   2
//   out_ready_latency:  0
//   in_payload_width:   42
//   out_payload_width:  42
//   in_payload_map:     in_data,in_startofpacket,in_endofpacket,in_empty,in_error
//   out_payload_map:    out_data,out_startofpacket,out_endofpacket,out_empty,out_error
// ------------------------------------------



module barcodescanner_nios_avalon_st_adapter_timing_adapter_0
(  
 output reg         in_ready,
 input               in_valid,
 input     [32-1: 0]  in_data,
 input     [6-1: 0] in_error,
 input              in_startofpacket,
 input              in_endofpacket,
 input     [2-1: 0] in_empty,
 // Interface: out
 input               out_ready,
 output reg          out_valid,
 output reg [32-1: 0] out_data,
 output reg [6-1: 0] out_error,
 output reg          out_startofpacket,
 output reg          out_endofpacket,
 output reg [2-1: 0] out_empty,
  // Interface: clk
 input              clk,
 // Interface: reset
 input              reset_n

 /*AUTOARG*/);

   // ---------------------------------------------------------------------
   //| Signal Declarations
   // ---------------------------------------------------------------------
   
   reg  [42-1:0]   in_payload;
   wire [42-1:0]   out_payload;
   wire            in_ready_wire;
   wire            out_valid_wire;
   wire [4:0]      fifo_fill;
   reg [1-1:0]   ready;   

   // ---------------------------------------------------------------------
   //| Payload Mapping
   // ---------------------------------------------------------------------
   always @* begin
     in_payload = {in_data,in_startofpacket,in_endofpacket,in_empty,in_error};
     {out_data,out_startofpacket,out_endofpacket,out_empty,out_error} = out_payload;
   end

   // ---------------------------------------------------------------------
   //| FIFO
   // ---------------------------------------------------------------------                           
   barcodescanner_nios_avalon_st_adapter_timing_adapter_0_fifo barcodescanner_nios_avalon_st_adapter_timing_adapter_0_fifo 
     ( 
       .clk        (clk),
       .reset_n    (reset_n),
       .in_ready   (),
       .in_valid   (in_valid),      
       .in_data    (in_payload),
       .out_ready  (ready[0]),
       .out_valid  (out_valid_wire),      
       .out_data   (out_payload),
       .fill_level (fifo_fill)
       );

   // ---------------------------------------------------------------------
   //| Ready & valid signals.
   // ---------------------------------------------------------------------
   always @* begin
      in_ready = (fifo_fill < 5 );
      out_valid = out_valid_wire;
      ready[0] = out_ready;
   end



endmodule


