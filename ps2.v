`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 02:19:11 PM
// Design Name: 
// Module Name: ps2
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


module ps2(
    input clk,
    input PS2_clk,
    input PS2_data,
    output reg [15:0] key_read=0,
    output reg done
    );
    
    reg [10:0] data_buf;
    wire PS2clk_d, PS2data_d;
    reg [7:0]dataprev = 0;
    reg [3:0]cnt = 0;
    reg flag = 0;
    reg pflag;
    
    debouncer kb_clk(.clk(clk), .sig_in(PS2_clk), .sig_out(PS2clk_d));
    debouncer kb_data(.clk(clk), .sig_in(PS2_data), .sig_out(PS2data_d));
    

    always@(negedge PS2clk_d) begin
            if(cnt <= 4'd9) begin
                data_buf[cnt] <= PS2data_d;
                cnt <= cnt + 1'b1;
                if(cnt == 4'd9)
                    flag <= 1;
            end
            else if (cnt == 4'd10) begin
                data_buf[cnt] <= PS2data_d;
                flag <= 0;
                cnt <= 0;
            end
    end
           
    always@(posedge clk) begin
        if (flag == 1'b1 && pflag == 1'b0) begin
            key_read <= {dataprev, data_buf[8:1]};
            dataprev <= data_buf[8:1];
            done <= 1'b1;
        end else
            done <= 1'b0;
        pflag <= flag;
    end
 
endmodule
