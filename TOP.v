`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 03:44:36 PM
// Design Name: 
// Module Name: TOP
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


module TOP(
    input clk,
    input PS2_clk,
    input PS2_data,
    output tx,
    output reg [3:0] an,
    output wire [6:0] seg
    );
    reg clk_50MHz = 0;
    reg gotrans = 0;
    reg received = 0;
    wire ps2_done;
    wire [15:0] key_read;
    reg [15:0] key_received;
    reg [3:0] trans_cnt;
    wire tx_ready;
    wire [7:0] tx_buf;
    wire tx_start;
    reg [7:0] hex2seg;
    
    ps2 keyboard_in(.clk(clk_50MHz), .PS2_clk(PS2_clk), .PS2_data(PS2_data), .done(ps2_done), .key_read(key_read));
    UART_protocol fill(.clk(clk), .key_received(key_received), .gotrans(gotrans), .tx_ready(tx_ready), .trans_cnt(trans_cnt), .tx_buf(tx_buf), .tx_start(tx_start));
    UART_trans txtrans(.clk(clk), .tx_start(tx_start), .tx_buf(tx_buf), .tx(tx), .tx_ready(tx_ready));
    Segdisplay display(.x(hex2seg), .seg(seg));
    
    initial an = 4'b1110;
    initial hex2seg = 8'b0;

    
    always@(posedge clk) begin
        clk_50MHz = ~clk_50MHz;
    end
    
    always@(key_read) begin
        if(key_read[7:0] == 8'hf0) begin
            trans_cnt <= 4'b0;
            received <= 1'b0;
        end else if(key_read[15:8] == 8'hf0) begin
            trans_cnt <= 4'd6;
            received <= 1'b1;
        end else if (key_read[7:0] != key_received[7:0] || key_received[15:8] == 8'hf0) begin
            trans_cnt <= 4'd3;
            received <= 1'b1;
            hex2seg <= key_read[7:0];
        end
    end
            
    always@(posedge clk) begin
        if (ps2_done == 1'b1 && received == 1'b1) begin
            key_received <= key_read;
            gotrans <= 1'b1;
        end else
            gotrans <= 1'b0;
    end
     
endmodule
