`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2022 12:53:43 PM
// Design Name: 
// Module Name: UART_trans
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


module UART_trans(
    input clk,
    input tx_start,
    input [7:0] tx_buf,
    output tx,
    output tx_ready
    );
    parameter baudrate = 9600, cnt_MAX = 100000000/baudrate;
    
    reg running=0;
    reg [15:0] cnt;
    reg [3:0] shift_cnt;
    reg [10:0] tx_shift;
    
    always@(posedge clk) begin
        if (running == 1'b0) begin
            tx_shift <= {2'b11, tx_buf, 1'b0};
            running <= tx_start;
            cnt <= 1'b0;
            shift_cnt <= 1'b0;
        end else if (cnt == cnt_MAX) begin
            tx_shift <= {1'b1, tx_shift[10:1]};
            cnt <= 1'b0;
            shift_cnt <= shift_cnt + 1'b1;
            if (shift_cnt == 4'd11) begin
                running <= 1'b0;
                shift_cnt <= 1'b0;
            end
        end else
            cnt <= cnt + 1'b1;
    end
    
    assign tx = (running == 1'b1)? tx_shift[0] : 1'b1;
    assign tx_ready = ((running == 1'b0 && tx_start == 1'b0))? 1'b1 : 1'b0;
    
endmodule
