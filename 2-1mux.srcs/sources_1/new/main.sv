`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2025 05:21:34 PM
// Design Name: 
// Module Name: main
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


module main(
input logic a,
input logic b,
input logic sel,
output logic Q
    );
    
    always_comb begin
       if (sel == 1'b0) begin
            Q = a;
        end else begin
            Q = b;
       end     
    end
    
endmodule
