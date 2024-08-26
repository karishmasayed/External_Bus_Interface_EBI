# EBI_top Module README

## Overview
The `EBI_top` module is a top-level Verilog design that interfaces with an External Bus Interface (EBI) for communication between a memory block and external devices. The module is designed to handle data reads and writes, using a combination of internal signals and FPGA components.

## Module Interface

### Inputs:
- **address [7:0]**: 8-bit input address for memory access.
- **data [7:0]**: 8-bit bidirectional data bus for reading and writing data.
- **WR**: Write enable signal. Active low.
- **RD**: Read enable signal. Active low.
- **CLK_in**: Input clock signal for memory operations.
- **CS**: Chip Select signal to enable memory access.
- **CLK_50Mhz**: 50 MHz input clock signal for general operations.

### Output:
- **led**: Output signal to control an LED, used as a status indicator.

## Internal Signals:

- **d_read [7:0]**: 8-bit internal signal for data read from memory.
- **d_WRite [7:0]**: 8-bit internal signal for data to be written to memory.
- **led_i [26:0]**: Internal register for controlling the LED blinking.
- **clk_out**: Internal clock signal generated by the clock wizard.
- **wr_en**: Write enable signal generated from the inverse of `WR` and `RD`.

## Description:

1. **Clock and LED Control**:
    - The 50 MHz clock input (`CLK_50Mhz`) is used to increment the `led_i` register.
    - The most significant bit of `led_i` is used to toggle the `led` output, creating a blinking LED effect.

2. **Data Bus Handling**:
    - The bidirectional `data` bus is managed using **IOBUF** instances.
    - The `IOBUF` allows bidirectional data transfer on each bit of the `data` bus. When `RD` is low, the buffer outputs data from the memory to the external device. When `RD` is high, it isolates the data bus.
  
3. **Memory Access**:
    - The `blk_mem_gen_0` instance is used to interface with the memory block.
    - The memory operates with the input clock (`CLK_in`) and is enabled by the chip select signal (`CS`).
    - Data is written to memory when `wr_en` is active (i.e., when `WR` is low and `RD` is high).
    - Data is read from memory and stored in `d_read` when `RD` is low.

4. **Clock Wizard**:
    - The `clk_wiz_0` instance generates a derived clock (`clk_out`) from the input 50 MHz clock signal (`CLK_50Mhz`).

5. **Integrated Logic Analyzer (ILA)**:
    - The ILA instance (`ila_0`) is used for debugging. It captures various signals such as `address`, `d_WRite`, `d_read`, `WR`, `RD`, `CLK_in`, and `CS` for analysis.

## Dependencies:
- **blk_mem_gen_0**: Memory block generator module.
- **IOBUF**: Xilinx IOBUF for bidirectional data bus control.
- **ila_0**: Integrated Logic Analyzer for signal debugging.
- **clk_wiz_0**: Clock wizard for clock generation.

## How It Works:

1. **Write Operation**:
   - When `WR` is low and `RD` is high, the write enable (`wr_en`) signal becomes active.
   - Data from the external device is written into memory via the `d_WRite` signal.

2. **Read Operation**:
   - When `RD` is low, the IOBUF buffers output the data from memory to the external device.
   - The memory data is stored in `d_read` and sent to the data bus through the `IOBUF` instances.

## Additional Comments:
- This module assumes that the memory block (`blk_mem_gen_0`) is properly configured for the address width and data width used.
- The clock wizard configuration should match the required clock frequency for the application.
- The ILA probe signals provide insights into the internal workings during simulation or in-system debugging.

This design is suitable for FPGA-based applications that require interaction with external devices through an EBI. It is flexible and can be adapted for various FPGA platforms with minimal modifications.
