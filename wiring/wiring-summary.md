# Lathe Controller Wiring Summary

## Overview
This document summarizes the complete wiring configuration for the lathe controller system, including Flora tachometer integration with VFD power and control switches.

## Power Distribution
- **Main Power**: VFD powered from 115VAC (L1(L), L2 terminals)
- **Control Power**: VFD internal 24VDC supply (Terminal 3 - 24V)
- **Flora Power**: 24V to 5V step-down converter (LM2596) from VFD supply
- **Display/Sensor Power**: 5V from Flora to TM1637 and IR sensor

## Control Switch Configuration

**Hardware Setup**: VFD switch **SW1 = PNP** (Source Mode) for all digital inputs

### 1. Main On/Off Switch (S7 - Terminal 10)
- **Type**: SPST maintained contact
- **Function**: Master enable/disable
- **Wiring**: Terminal 3 (24V) → Switch → Terminal 10 (S7)
- **Signal Logic**: Switch closed = 24V = Signal HIGH = Enabled
- **VFD Parameter**: F15 = 019 (Terminal 10 as digital input S7)

### 2. E-Stop Switch (S4 - Terminal 7) 
- **Type**: NC (Normally Closed) emergency stop
- **Function**: External Emergency Stop trigger
- **Normal**: Switch closed, 24V on Terminal 7 → Signal HIGH = Normal operation
- **Emergency**: Switch opens, 0V on Terminal 7 → Signal LOW = Emergency stop
- **VFD Parameter**: F14 = 009 (S4 = External Emergency Stop)
- **Response**: Immediate stop using C12 deceleration time, displays "E.S"

### 3. Run Switch (S1 - Terminal 4)
- **Function**: Forward run command
- **Signal Logic**: Switch closed = 24V = Signal HIGH = Run enabled
- **VFD Parameter**: F11 = 001 (S1 = Forward run)

### 4. Forward/Reverse Toggle (S2 - Terminal 5)
- **Type**: SPDT metal toggle switch
- **Function**: Direction control
- **Signal Logic**: Switch closed = 24V = Signal HIGH = Reverse mode
- **VFD Parameter**: F12 = 002 (S2 = Reverse run)

### 5. Jog Switch (S3 - Terminal 6)
- **Function**: Jog forward
- **Signal Logic**: Switch closed = 24V = Signal HIGH = Jog active
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

### Hardware Configuration:
- [ ] VFD hardware switch **SW1 = PNP** (Digital Signal Selection)
- [ ] VFD hardware switch **SW2 = V** (Analog Control Selection)

### Power Connections:
- [ ] VFD Terminal 3 (24V) supply connected to step-down converter
- [ ] Step-down converter output (5V) connected to Flora VIN
- [ ] All switch commons connected to VFD Terminal 3 (24V)

### Digital Input Wiring:
- [ ] E-Stop wired as NC configuration to Terminal 7 (S4)
- [ ] On/Off switch wired to Terminal 10 (S7)  
- [ ] Run switch wired to Terminal 4 (S1)
- [ ] Forward/Reverse toggle wired to Terminal 5 (S2)
- [ ] Jog switch wired to Terminal 6 (S3)

### VFD Programming:
- [ ] VFD F-parameters programmed per specification
- [ ] Digital input functions configured (F11-F15)
- [ ] Control mode parameters set (F04, F05, F06)

### System Verification:
- [ ] Flora tachometer powered and functional
- [ ] All safety systems tested and operational
- [ ] Signal logic verified (24V = HIGH = Active for PNP mode)