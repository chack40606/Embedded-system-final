`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 02:55:56 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input sig_in,
    output reg sig_out
    );
    reg [7:0] cnt;
    reg sig_past = 0;
    
    always@(posedge clk) begin
        if (sig_in == sig_past) begin
            if(cnt == 8'd255)
                sig_out <= sig_in;
            else
                cnt <= cnt + 1'b1;
        end
        else begin
            cnt <= 0;
            sig_past <= sig_in;
        end
        end
            
            
endmodule
