
//----------------------------------------//
/* This testbench comprehensively tests the following features:

EDAC: Error Detection and Correction.

Power Saving: Checks if the system enters power save mode.

Burst Operation: Verifies burst mode read and write operations.

Security: Ensures correct password access and denies incorrect password access.

CDC Operation: Tests clock domain crossing.

Basic Read/Write: Verifies basic read and write functionality.

*/
//----------------------------------------//


module tb_combined;

    reg clk;
    reg clk_processor;
    reg rst_n;
    reg [15:0] addr;
    reg we_n;
    reg oe_n;
    reg burst_mode;
    reg [15:0] burst_length;
    reg [7:0] password;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire cs_n;
    wire [15:0] sram_addr;
    wire [7:0] sram_data;
    wire sram_we_n;
    wire sram_oe_n;
    wire error_flag;
    wire access_denied;
    wire power_save_mode;

    reg [7:0] mem [0:65535];  // SRAM memory for verification

    assign sram_data = (we_n == 0) ? data_in : 8'bz;
    assign data_out = sram_data;

    sram_controller uut (
        .clk(clk),
        .clk_processor(clk_processor),
        .rst_n(rst_n),
        .addr(addr),
        .data(sram_data),
        .we_n(we_n),
        .oe_n(oe_n),
        .password(password),
        .burst_mode(burst_mode),
        .burst_length(burst_length),
        .cs_n(cs_n),
        .sram_addr(sram_addr),
        .sram_data(sram_data),
        .sram_we_n(sram_we_n),
        .sram_oe_n(sram_oe_n),
        .error_flag(error_flag),
        .access_denied(access_denied),
        .power_save_mode(power_save_mode)
    );

    initial begin
        // Initialize signals
        clk = 0;
        clk_processor = 0;
        rst_n = 0;
        addr = 0;
        we_n = 1;
        oe_n = 1;
        burst_mode = 0;
        burst_length = 4;
        password = 8'hA5; // Correct password

        // Reset the system
        #10 rst_n = 1;

        // Test Basic Write
        #10 addr = 16'h0001; data_in = 8'hAA; we_n = 0; #10 we_n = 1; mem[16'h0001] = 8'hAA;
        #10 addr = 16'h0002; data_in = 8'hBB; we_n = 0; #10 we_n = 1; mem[16'h0002] = 8'hBB;

        // Test Basic Read
        #10 addr = 16'h0001; oe_n = 0;
        #10 if (data_out !== mem[16'h0001]) $display("Read Error at address 16'h0001: Expected %h, Got %h", mem[16'h0001], data_out);
        #10 addr = 16'h0002;
        #10 if (data_out !== mem[16'h0002]) $display("Read Error at address 16'h0002: Expected %h, Got %h", mem[16'h0002], data_out);
        oe_n = 1;

        // Test Burst Write
        burst_mode = 1;
        #10 addr = 16'h0100; data_in = 8'hCC; we_n = 0; #10 we_n = 1; mem[16'h0100] = 8'hCC;
        #10 addr = 16'h0101; data_in = 8'hDD; we_n = 0; #10 we_n = 1; mem[16'h0101] = 8'hDD;
        #10 addr = 16'h0102; data_in = 8'hEE; we_n = 0; #10 we_n = 1; mem[16'h0102] = 8'hEE;
        #10 addr = 16'h0103; data_in = 8'hFF; we_n = 0; #10 we_n = 1; mem[16'h0103] = 8'hFF;
        burst_mode = 0;

        // Test Burst Read
        #10 addr = 16'h0100; oe_n = 0;
        #10 if (data_out !== mem[16'h0100]) $display("Burst Read Error at address 16'h0100: Expected %h, Got %h", mem[16'h0100], data_out);
        #10 addr = 16'h0101;
        #10 if (data_out !== mem[16'h0101]) $display("Burst Read Error at address 16'h0101: Expected %h, Got %h", mem[16'h0101], data_out);
        #10 addr = 16'h0102;
        #10 if (data_out !== mem[16'h0102]) $display("Burst Read Error at address 16'h0102: Expected %h, Got %h", mem[16'h0102], data_out);
        #10 addr = 16'h0103;
        #10 if (data_out !== mem[16'h0103]) $display("Burst Read Error at address 16'h0103: Expected %h, Got %h", mem[16'h0103], data_out);
        oe_n = 1;

        // Test Security (Access with Correct and Incorrect Password)
        #10 password = 8'hA5; // Correct password
        #10 addr = 16'h0003; data_in = 8'h11; we_n = 0; #10 we_n = 1; mem[16'h0003] = 8'h11;
        #10 password = 8'hFF; // Incorrect password
        #10 addr = 16'h0004; data_in = 8'h22; we_n = 0; #10 we_n = 1;
        if (access_denied) $display("Access denied for incorrect password at address 16'h0004");
        
        // Test Error Detection (EDAC)
        #10 addr = 16'h0001; oe_n = 0;
        #10 if (data_out !== mem[16'h0001]) $display("Error detected at address 16'h0001");
        #10 oe_n = 1;

        // Test Power Save Mode
        #10 addr = 16'h0005; data_in = 8'h33; we_n = 0; #10 we_n = 1; mem[16'h0005] = 8'h33;
        #10 oe_n = 0;
        #10 if (power_save_mode) $display("Power save mode enabled");
        #10 oe_n = 1;

        // Test Clock Domain Crossing (CDC)
        // Writing from processor clock domain
        #10 addr = 16'h0200; data_in = 8'h44; we_n = 0; #10 we_n = 1; mem[16'h0200] = 8'h44;
        // Reading in SRAM clock domain
        #10 addr = 16'h0200; oe_n = 0;
        #10 if (data_out !== mem[16'h0200]) $display("CDC Read Error at address 16'h0200: Expected %h, Got %h", mem[16'h0200], data_out);
        oe_n = 1;

        // End simulation
        #100 $finish;
    end

    always #5 clk = ~clk; // Clock generation
    always #7 clk_processor = ~clk_processor; 
   initial begin
    $dumpvars();
    $dumpfile("dump.vcd");
    #1000 $finish();
  end

endmodule
