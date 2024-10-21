/* module tb_security_features;

    reg clk;
    reg rst_n;
    reg [15:0] addr;
    reg [7:0] data_reg;
    reg we_n;
    reg oe_n;
    reg [7:0] password;
    wire cs_n;
    wire [15:0] sram_addr;
    wire [7:0] sram_data;
    wire sram_we_n;
    wire sram_oe_n;
    wire error_flag;
    wire access_denied;
    wire [7:0] data;

    assign data = oe_n ? 8'bz : data_reg;

    sram_controller uut (
        .clk(clk),
        .rst_n(rst_n),
        .addr(addr),
        .data(data),
        .we_n(we_n),
        .oe_n(oe_n),
        .password(password),
        .cs_n(cs_n),
        .sram_addr(sram_addr),
        .sram_data(sram_data),
        .sram_we_n(sram_we_n),
        .sram_oe_n(sram_oe_n),
        .error_flag(error_flag),
        .access_denied(access_denied)
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        addr = 0;
        data_reg = 0;
        we_n = 1;
        oe_n = 1;
        password = 8'hA5; // Correct password

        // Reset the system
        #10 rst_n = 1;

        // Attempt access with correct password
        #10 addr = 16'h0001;
        data_reg = 8'hAA;
        we_n = 0;
        #10 we_n = 1;

        // Attempt access with incorrect password
        #10 password = 8'hFF;
        addr = 16'h0002;
        data_reg = 8'hBB;
        we_n = 0;
        #10 we_n = 1;

        // Check access denied signal
        #10 if (access_denied) $display("Access denied for incorrect password");

        // End simulation
        #50 $finish;
    end

    always #5 clk = ~clk; // Clock generation
  initial begin
    $dumpvars();
    $dumpfile("dump.vcd");
    #1000 $finish();
  end

endmodule */

/*module tb_power_management;

    reg clk;
    reg rst_n;
    reg [15:0] addr;
    reg [7:0] data_reg;
    reg we_n;
    reg oe_n;
    wire cs_n;
    wire [15:0] sram_addr;
    wire [7:0] sram_data;
    wire sram_we_n;
    wire sram_oe_n;
    wire error_flag;
    wire access_denied;
    wire power_save_mode;
    reg [7:0] password;
    wire [7:0] data;

    assign data = oe_n ? 8'bz : data_reg;

    sram_controller uut (
        .clk(clk),
        .rst_n(rst_n),
        .addr(addr),
        .data(data),
        .we_n(we_n),
        .oe_n(oe_n),
        .password(password),
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
        rst_n = 0;
        addr = 0;
        data_reg = 0;
        we_n = 1;
        oe_n = 1;
        password = 8'hA5; // Correct password

        // Reset the system
        #10 rst_n = 1;

        // Normal operation
        #10 addr = 16'h0001;
        data_reg = 8'hAA;
        we_n = 0;
        #10 we_n = 1;
        #10 oe_n = 0;
        #10 oe_n = 1;

        // Enter power save mode
        #20;
        if (power_save_mode) $display("Entered power save mode");

        // Perform an operation to exit power save mode
        #10 addr = 16'h0002;
        data_reg = 8'hBB;
        we_n = 0;
        #10 we_n = 1;

        // Check if power save mode is exited
        #10 if (!power_save_mode) $display("Exited power save mode");

        // End simulation
        #50 $finish;
    end

    always #5 clk = ~clk; // Clock generation
  initial begin
    $dumpvars();
    $dumpfile("dump.vcd");
    #1000 $finish();
  end

endmodule
*/

/*module tb_basic_read_write;

    reg clk;
    reg rst_n;
    reg [15:0] addr;
    reg [7:0] data_out;
    wire [7:0] data_in;
    reg we_n;
    reg oe_n;
    wire cs_n;
    wire [15:0] sram_addr;
    wire [7:0] sram_data;
    wire sram_we_n;
    wire sram_oe_n;
    wire error_flag;
    wire access_denied;
    reg [7:0] password;

    // Tri-state buffer for bidirectional data bus
    assign data_in = oe_n ? 8'bz : sram_data;
    assign sram_data = we_n ? 8'bz : data_out;

    sram_controller uut (
        .clk(clk),
        .rst_n(rst_n),
        .addr(addr),
        .data(data_in),
        .we_n(we_n),
        .oe_n(oe_n),
        .password(password),
        .cs_n(cs_n),
        .sram_addr(sram_addr),
        .sram_data(sram_data),
        .sram_we_n(sram_we_n),
        .sram_oe_n(sram_oe_n),
        .error_flag(error_flag),
        .access_denied(access_denied)
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        addr = 0;
        data_out = 0;
        we_n = 1;
        oe_n = 1;
        password = 8'hA5; // Correct password

        // Reset the system
        #10 rst_n = 1;

        // Write operation
        #10 addr = 16'h0001;
        data_out = 8'hAA;
        we_n = 0;
        #10 we_n = 1;

        // Read operation
        #10 oe_n = 0;
        #10 oe_n = 1;

        // End simulation
        #50 $finish;
    end

    always #5 clk = ~clk; // Clock generation


initial begin
    $dumpvars();
    $dumpfile("dump.vcd");
    #1000 $finish();
  end
endmodule */

/*module tb_edac;

    reg clk;
    reg rst_n;
    reg [15:0] addr;
    reg we_n;
    reg oe_n;
    wire cs_n;
    wire [15:0] sram_addr;
    wire [7:0] sram_data;
    wire sram_we_n;
    wire sram_oe_n;
    wire error_flag;
    wire access_denied;
    reg [7:0] password;
    reg [7:0] data_in;
    wire [7:0] data_out;

    assign sram_data = (oe_n == 0) ? 8'bz : data_in;
    assign data_out = sram_data;

    sram_controller uut (
        .clk(clk),
        .rst_n(rst_n),
        .addr(addr),
        .data(sram_data),
        .we_n(we_n),
        .oe_n(oe_n),
        .password(password),
        .cs_n(cs_n),
        .sram_addr(sram_addr),
        .sram_data(sram_data),
        .sram_we_n(sram_we_n),
        .sram_oe_n(sram_oe_n),
        .error_flag(error_flag),
        .access_denied(access_denied)
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        addr = 0;
        we_n = 1;
        oe_n = 1;
        password = 8'hA5; // Correct password

        // Reset the system
        #10 rst_n = 1;

        // Write operation with error detection
        #10 addr = 16'h0001;
        data_in = 8'hAA;
        we_n = 0;
        #10 we_n = 1;

        // Introduce an error in the data
        #10 data_in = 8'hBB;
        oe_n = 0;
        #10 oe_n = 1;

        // Verify error detection
        #10 if (error_flag) $display("Error detected!");

        // End simulation
        #50 $finish;
    end

    always #5 clk = ~clk; // Clock generation
  initial begin
    $dumpvars();
    $dumpfile("dump.vcd");
    #1000 $finish();
  end

endmodule*/



/*module tb_burst_mode;

    reg clk;
    reg rst_n;
    reg [15:0] addr;
    reg [7:0] data_reg;
    reg we_n;
    reg oe_n;
    reg burst_mode;
    reg [15:0] burst_length;
    wire cs_n;
    wire [15:0] sram_addr;
    wire [7:0] sram_data;
    wire sram_we_n;
    wire sram_oe_n;
    wire error_flag;
    wire access_denied;
    reg [7:0] password;
    reg [7:0] data_in;
    wire [7:0] data_out;

    reg [7:0] mem [0:65535];  // SRAM memory for verification

    assign sram_data = (we_n == 0) ? data_in : 8'bz;
    assign data_out = sram_data;

    sram_controller uut (
        .clk(clk),
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
        .access_denied(access_denied)
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        addr = 0;
        data_reg = 0;
        we_n = 1;
        oe_n = 1;
        password = 8'hA5; // Correct password
        burst_mode = 1;
        burst_length = 4;

        // Reset the system
        #10 rst_n = 1;

        // Burst write operation
        #10 addr = 16'h0001; data_in = 8'hAA; we_n = 0; #10 we_n = 1; mem[16'h0001] = 8'hAA;
        #10 addr = 16'h0002; data_in = 8'hBB; we_n = 0; #10 we_n = 1; mem[16'h0002] = 8'hBB;
        #10 addr = 16'h0003; data_in = 8'hCC; we_n = 0; #10 we_n = 1; mem[16'h0003] = 8'hCC;
        #10 addr = 16'h0004; data_in = 8'hDD; we_n = 0; #10 we_n = 1; mem[16'h0004] = 8'hDD;

        // Burst read operation
        #10 addr = 16'h0001; oe_n = 0;
        #10 if (data_out !== mem[16'h0001]) $display("Read Error at address 16'h0001: Expected %h, Got %h", mem[16'h0001], data_out);
        #10 addr = 16'h0002;
        #10 if (data_out !== mem[16'h0002]) $display("Read Error at address 16'h0002: Expected %h, Got %h", mem[16'h0002], data_out);
        #10 addr = 16'h0003;
        #10 if (data_out !== mem[16'h0003]) $display("Read Error at address 16'h0003: Expected %h, Got %h", mem[16'h0003], data_out);
        #10 addr = 16'h0004;
        #10 if (data_out !== mem[16'h0004]) $display("Read Error at address 16'h0004: Expected %h, Got %h", mem[16'h0004], data_out);
        oe_n = 1;

        // End simulation
        #50 $finish;
    end

    always #5 clk = ~clk; 
initial begin
    $dumpvars();
    $dumpfile("dump.vcd");
    #1000 $finish();
  end

endmodule*/
