# RISC-V Processor Implementation

A 32-bit RISC-V processor core implementation in Verilog, featuring a single-cycle architecture that supports basic RISC-V instructions including arithmetic operations, memory access, and branching.

## Architecture Overview

This implementation follows the RISC-V RV32I base instruction set architecture and consists of the following main components:

### Datapath Components
- **Program Counter (PC)**: Manages instruction fetch address
- **Instruction Memory**: Stores program instructions (32-bit wide)
- **Register File**: 32 general-purpose registers (x0-x31), each 32 bits wide
- **Arithmetic Logic Unit (ALU)**: Performs arithmetic and logical operations
- **Data Memory**: Handles load/store operations (32-bit wide)
- **Sign Extender**: Extends immediate values to 32 bits
- **Multiplexers**: Route data between different components

### Control Unit
- **Main Decoder**: Decodes instruction opcodes and generates control signals
- **ALU Decoder**: Determines ALU operation based on instruction type and function fields

### Supported Instructions
- **R-type**: `add`, `sub`, `slt`, `and`, `or`
- **I-type**: `lw` (load word)
- **S-type**: `sw` (store word)
- **B-type**: `beq` (branch if equal)

## File Descriptions

| File | Description |
|------|-------------|
| `top.v` | Top-level module connecting all processor components |
| `pc.v` | Program counter with synchronous reset |
| `pc_adder.v` | PC incrementer (adds 4 to current PC) |
| `instr_mem.v` | Instruction memory module (ROM implementation) |
| `register_file.v` | 32x32-bit register file with read/write ports |
| `sign_extend.v` | Immediate value sign extension logic |
| `control_unit.v` | Main control unit combining decoder modules |
| `main_decoder.v` | Opcode decoder generating control signals |
| `alu_decoder.v` | ALU control signal generation |
| `alu.v` | 32-bit ALU with flags (Zero, Overflow, Negative, Carry) |
| `data_mem.v` | Data memory module (RAM implementation) |
| `mux.v` | 2:1 multiplexer for data routing |

## Interface

### Top Module Ports
- `input clk`: System clock
- `input rst`: Synchronous reset (active high)

### Memory Interfaces
- **Instruction Memory**: Address input from PC, 32-bit instruction output
- **Data Memory**: 32-bit address/data with write enable control

## Simulation

### Prerequisites
- Verilog simulator (ModelSim, Vivado Simulator, Icarus Verilog, etc.)
- Testbench file for stimulus generation

### Creating a Testbench

Create a testbench file (e.g., `testbench.v`) with the following structure:

```verilog
`timescale 1ns / 1ps

module testbench;
    reg clk, rst;

    // Instantiate the top module
    top dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period (100MHz)
    end

    // Test stimulus
    initial begin
        // Initialize memories with test program
        // (Add your instruction and data memory initialization here)

        // Reset sequence
        rst = 1;
        #10;
        rst = 0;

        // Run simulation
        #1000; // Adjust simulation time as needed

        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t PC=%h", $time, dut.pc_top);
    end
endmodule
```

### Running Simulation

#### Using ModelSim:
```bash
vlog *.v
vsim testbench
run -all
```

#### Using Icarus Verilog:
```bash
iverilog -o simulation *.v
vvp simulation
```

#### Using Vivado:
```bash
xvlog *.v
xelab testbench -debug typical
xsim testbench -gui
```

### Memory Initialization

For meaningful simulation, initialize the instruction memory with a RISC-V program. The instruction memory expects 32-bit instructions at word-aligned addresses.

Example initialization in testbench:
```verilog
initial begin
    // Load instructions into instruction memory
    dut.instr_mem_inst.memory[0] = 32'h00000000; // nop
    dut.instr_mem_inst.memory[1] = 32'h00500093; // addi x1, x0, 5
    // Add more instructions...
end
```

## Synthesis and Implementation

This design is synthesizable and can be implemented on FPGA devices such as:
- Xilinx Artix-7, Kintex-7, Virtex-7 series
- Intel/Altera Cyclone V, Arria V series
- Lattice ECP5, iCE40 series

### Synthesis Considerations
- Target frequency: 100MHz+ on modern FPGAs
- Resource utilization: ~500-1000 LUTs depending on optimizations
- Memory blocks: Uses distributed RAM for small implementations

