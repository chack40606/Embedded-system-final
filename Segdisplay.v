`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 01:03:13 PM
// Design Name: 
// Module Name: Segdisplay
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


module Segdisplay(
    input [7:0] x,
    output reg [6:0] seg
    );
    initial 
        seg <= 7'b0000001;
        
    always @(x)
    begin
        case (x) //case statement
            28 : seg = 7'b0001000; // A
            50 : seg = 7'b1100000; // b
            33 : seg = 7'b0110001; // C
            35 : seg = 7'b1000010; // d
            36 : seg = 7'b0110000; // E
            43 : seg = 7'b0111000; // F
            52 : seg = 7'b0000100; // g
            51 : seg = 7'b1001000; // H
            67 : seg = 7'b1111001; // I
            59 : seg = 7'b1000011; // J
            66 : seg = 7'b1111110; // K
            75 : seg = 7'b1110001; // L
            58 : seg = 7'b1111110; // M
            49 : seg = 7'b1101010; // n
            68 : seg = 7'b1100010; // o
            77 : seg = 7'b0011000; // P
            21 : seg = 7'b0001100; // q
            45 : seg = 7'b1111010; // r
            27 : seg = 7'b0100100; // S
            44 : seg = 7'b1110000; // t
            60 : seg = 7'b1000001; // U
            42 : seg = 7'b1100011; // v
            29 : seg = 7'b1111110; // w
            34 : seg = 7'b1111110; // x
            53 : seg = 7'b1000100; // y
            26 : seg = 7'b1111110; // z
            69 : seg = 7'b0000001; // 0
            22 : seg = 7'b1001111; // 1
            30 : seg = 7'b0010010; // 2
            38 : seg = 7'b0000110; // 3
            37 : seg = 7'b1001100; // 4
            46 : seg = 7'b0100100; // 5
            54 : seg = 7'b0100000; // 6
            61 : seg = 7'b0001111; // 7
            62 : seg = 7'b0000000; // 8
            70 : seg = 7'b0000100; // 9
            default : seg = 7'b1111110; 
        endcase
    end
endmodule
