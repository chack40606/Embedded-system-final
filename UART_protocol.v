`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2022 05:39:31 PM
// Design Name: 
// Module Name: UART_protocol
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


module UART_protocol(
    input clk,
    input [15:0] key_received,
    input gotrans,
    input tx_ready,
    input [3:0] trans_cnt,
    output reg [7:0] tx_buf,
    output reg tx_start
    );
    reg [3:0] cnt;
    reg [31:0] bin2acii;
    reg loading = 0;
    initial begin
        tx_buf <= 8'b0;
        tx_start <= 1'b0;
    end
   
   always@(key_received) begin
            if(key_received[3:0] <= 9)
                bin2acii[7:0] = 8'd48 + key_received[3:0];
            else
                bin2acii[7:0] = 8'd55 + key_received[3:0];
            if(key_received[7:4] <= 9)
                bin2acii[15:8] = 8'd48 + key_received[7:4];
            else
                bin2acii[15:8] = 8'd55 + key_received[7:4];
            if(key_received[11:8] <= 9)
                bin2acii[23:16] = 8'd48 + key_received[11:8];
            else
                bin2acii[23:16] = 8'd55 + key_received[11:8];
            if(key_received[15:12] <= 9)
                bin2acii[31:24] = 8'd48 + key_received[15:12];
            else
                bin2acii[31:24] = 8'd55 + key_received[15:12];
    end
    
    
    always@(posedge clk) begin
        if (tx_ready == 1'b1) begin
            if(loading == 1'b1) begin
                if(cnt == 1'b0) begin
                    loading <= 0;
                    cnt <= trans_cnt;
                end else begin
                    cnt <= cnt - 1'b1;
                    tx_start <= 1'b1;
                    loading <= 1'b1;
                end
            end else begin
                if (trans_cnt != 0) begin
                    cnt <= trans_cnt;
                    loading <= gotrans;
                    tx_start <= gotrans;
                end
            end
        end else
            tx_start <= 1'b0;      
    end
    
    always@(cnt)
        case(cnt)
            0:tx_buf <= 8'd13;
            1:tx_buf <= 8'd10;
            2:tx_buf <= bin2acii[7:0];
            3:tx_buf <= bin2acii[15:8];
            4:tx_buf <= 8'd32;
            5:tx_buf <= bin2acii[23:16];
            6:tx_buf <= bin2acii[31:24];
            default: tx_buf <= 8'd0;
        endcase
endmodule
