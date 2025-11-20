`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2025 05:42:03 PM
// Design Name: 
// Module Name: tb_main
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



module tb_main; // Testbench modules usually have no inputs/outputs

    // 1. Signal Declaration
    // We use 'logic' for everything in SystemVerilog testbenches.
    // Signals going INTO the DUT are initial values (reg behavior).
    // Signals coming OUT of the DUT are wires.
    logic a;
    logic b;
    logic sel;
    logic Q;

    // 2. Instantiate the Device Under Test (DUT)
    // We connect our local signals (a, b...) to the module's ports (.a, .b...)
    main uut (
        .a(a), 
        .b(b), 
        .sel(sel), 
        .Q(Q)
    );

    // 3. Monitoring
    // This block runs in the background and prints to the Console 
    // whenever any of the signals inside the list change.
    initial begin
        $monitor("Time: %0t | Sel: %b | A: %b | B: %b | Output Q: %b", 
                 $time, sel, a, b, Q);
    end

    // 4. Stimulus Generation
    initial begin
        // Initialize inputs to known state
        a = 0; b = 0; sel = 0;
        #10; // Wait 10 nanoseconds

        // ----------------------------------------
        // SCENARIO 1: Verify 'Sel = 0' (Pass A)
        // ----------------------------------------
        $display("--- Testing Select = 0 (Passing A) ---");
        
        // Case 1.1: Sel=0, A=0 (B is don't care, but we set it to 1 to be sure A is passed)
        sel = 0; a = 0; b = 1; 
        #10; // Wait for logic to settle
        if (Q !== 0) $error("Failed: Sel=0, A=0, but Q=%b", Q);

        // Case 1.2: Sel=0, A=1
        sel = 0; a = 1; b = 0;
        #10;
        if (Q !== 1) $error("Failed: Sel=0, A=1, but Q=%b", Q);

        // ----------------------------------------
        // SCENARIO 2: Verify 'Sel = 1' (Pass B)
        // ----------------------------------------
        $display("--- Testing Select = 1 (Passing B) ---");

        // Case 2.1: Sel=1, B=0 (A is don't care)
        sel = 1; a = 1; b = 0;
        #10;
        if (Q !== 0) $error("Failed: Sel=1, B=0, but Q=%b", Q);

        // Case 2.2: Sel=1, B=1
        sel = 1; a = 0; b = 1;
        #10;
        if (Q !== 1) $error("Failed: Sel=1, B=1, but Q=%b", Q);

        // ----------------------------------------
        // SCENARIO 3: Dynamic Switching
        // ----------------------------------------
        $display("--- Testing Dynamic Switching ---");
        // Keep A=1 and B=0, and toggle Sel to see Q flip
        a = 1; b = 0;
        
        sel = 0; #10; // Q should be 1 (A)
        sel = 1; #10; // Q should be 0 (B)
        sel = 0; #10; // Q should be 1 (A)

        // End simulation
        $display("Test Complete.");
        $finish;
    end

endmodule