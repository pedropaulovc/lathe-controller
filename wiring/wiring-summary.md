# Lathe Controller Wiring Summary

## Overview
This document summarizes the complete wiring configuration for the lathe controller system, including Flora tachometer integration with VFD power and control switches.

## Power Distribution
- **Main Power**: VFD powered from 115VAC (L1(L), L2 terminals)
- **Control Power**: VFD internal 24VDC supply (Terminal 3 - 24V)
- **Flora Power**: 24V to 5V step-down converter (LM2596) from VFD supply
- **Display/Sensor Power**: 5V from Flora to TM1637 and IR sensor

## Control Switch Configuration

### 1. Main On/Off Switch (S7 - Terminal 10)
- **Type**: SPST maintained contact
- **Function**: Master enable/disable
- **Wiring**: Terminal 3 (24V) → Switch → Terminal 10 (S7)
- **VFD Parameter**: F15 = 019 (Terminal 10 as digital input S7)

### 2. E-Stop Switch (S4 - Terminal 7) 
- **Type**: NC (Normally Closed) emergency stop
- **Function**: External fault trigger
- **Normal**: Switch closed, 24V flows from Terminal 3 to Terminal 7
- **Emergency**: Switch opens, removes 24V from Terminal 7
- **VFD Parameter**: F14 = 009 (S4 = External fault)

### 3. Run Switch (S1 - Terminal 4)
- **Function**: Forward run command
- **VFD Parameter**: F11 = 001 (S1 = Forward run)

### 4. Forward/Reverse Toggle (S2 - Terminal 5)
- **Type**: SPDT metal toggle switch
- **Function**: Direction control
- **VFD Parameter**: F12 = 002 (S2 = Reverse run)

### 5. Jog Switch (S3 - Terminal 6)
- **Function**: Jog forward
- **VFD Parameter**: F13 = 007 (S3 = Jog forward)

## Safety Features
1. **Dual Stop Protection**: Both E-Stop (emergency) and On/Off (planned shutdown)
2. **NC E-Stop**: Fail-safe design - any wire break stops motor
3. **Master Enable**: On/Off switch must be enabled for any operation
4. **VFD Fault Response**: Immediate motor stop on E-Stop activation

## Flora Tachometer Integration
- **Power**: From VFD 24V supply via step-down converter
- **Signal**: IR sensor on D6, interrupt-based RPM measurement
- **Display**: TM1637 4-digit display on D9/D10
- **Update Rate**: 250ms for stable readings

## Wiring Validation Checklist
- [ ] VFD Terminal 3 (24V) supply connected to step-down converter
- [ ] Step-down converter output (5V) connected to Flora VIN
- [ ] All switch commons connected to VFD Terminal 3 (24V)
- [ ] E-Stop wired as NC configuration to Terminal 7 (S4)
- [ ] On/Off switch wired to Terminal 10 (S7)
- [ ] VFD F-parameters programmed per specification
- [ ] Flora tachometer powered and functional
- [ ] All safety systems tested and operational