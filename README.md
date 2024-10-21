# Enhanced-SRAM-Controller
## Overview
This project features an advanced SRAM controller designed with multiple key functionalities to ensure robust, secure, and efficient memory operations. The controller supports basic read/write operations, error detection and correction (EDAC), power saving, burst mode, security features, clock domain crossing (CDC), and byte-addressable access.

## Features
### Basic Operations
 Read/Write Operations: Supports fundamental read and write actions for SRAM.

### Error Detection and Correction (EDAC)
Parity-Based EDAC: Implements parity bits for detecting and correcting errors in data storage and retrieval.

### Security Features
Access Control: Password-protected access ensures only authorized users can interact with the SRAM.

Data Encryption: XOR-based encryption for data security.

### Power Management
Power Gating: Reduces power consumption by disabling inactive parts of the circuit.

Power Save Mode: Indicates when the controller is in a power-saving state.

### Burst Mode
Burst Access: Allows multiple consecutive memory accesses in a single burst to enhance performance.

Configurable Burst Length: User-defined burst length for flexible memory operations.

### Clock Domain Crossing (CDC)
CDC Synchronizers: Ensures reliable operation across different clock domains, preventing metastability issues.

### Byte-Addressable Access
Byte Enable Signals: Supports access to individual bytes within a word for greater flexibility.

## File Structure
sram_controller.v: Verilog module for the SRAM controller.

tb_combined.v: Testbench combining various scenarios to validate the SRAM controller functionality.

README.md: Project documentation .

## Getting Started
### Prerequisites
Verilog simulator (e.g., ModelSim, Vivado)

Basic understanding of Verilog HDL and digital design

### Running the Simulation
1. Clone the repository:
git clone https://github.com/teekamkhandelwal/SRAM-Controller.git
cd sram-controller
Open your Verilog simulator.

Load sram_controller.v and tb_combined.v in the simulator.

Run the simulation to verify the functionalities.

### Example Usage
The tb_combined.v testbench includes comprehensive tests covering:

Basic read/write operations.

Error detection and correction.

Security features.

Power-saving mode.

Burst read/write operations.

Clock domain crossing.

## Contributions
Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments


