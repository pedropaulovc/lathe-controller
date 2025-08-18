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

### 1. Main On/Off Switch - **MASTER ENABLE**
- **Type**: SPST maintained contact switch
- **Function**: **Master enable for motor operation**
- **Wiring**: Terminal 3 (24V) → On/Off Switch → 24V_SWITCHED (feeds Forward/Reverse switch)
- **Signal Logic**: Switch closed = 24V available to direction switch
- **Operation**: **Must be ON for motor to run, OFF stops motor regardless of direction switch**
- **Safety**: Complete motor disable when OFF

### 2. Forward/Reverse Toggle Switch - **DIRECTION CONTROL**
- **Type**: SPDT (Single Pole, Double Throw) toggle switch
- **Function**: Direction selection
- **Input**: 24V_SWITCHED (from On/Off switch)
- **Forward Position**: 24V_SWITCHED → Terminal 4 (S1) → Forward rotation
- **Reverse Position**: 24V_SWITCHED → Terminal 5 (S2) → Reverse rotation
- **VFD Parameters**: F11 = 000 (S1 = Forward run), F12 = 001 (S2 = Reverse run)
- **Operation**: Only works when On/Off switch is ON

### 3. E-Stop Switch (S4 - Terminal 7) 
- **Type**: NC (Normally Closed) emergency stop
- **Function**: External Emergency Stop trigger
- **Normal**: Switch closed, 24V on Terminal 7 → Signal HIGH = Normal operation
- **Emergency**: Switch opens, 0V on Terminal 7 → Signal LOW = Emergency stop
- **VFD Parameter**: F14 = 006 (S4 = External Emergency Stop)
- **Response**: Immediate stop using C12 deceleration time, displays "E.S"

## Safety Features
1. **Emergency Stop**: NC E-Stop provides immediate motor shutdown
2. **NC E-Stop**: Fail-safe design - any wire break stops motor  
3. **Direct Control**: On/Off switch provides direct motor start/stop
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
- [ ] **On/Off switch wired as master enable (feeds 24V to direction switch)**
- [ ] **SPDT Forward/Reverse toggle switch:**
  - [ ] Forward position → Terminal 4 (S1)
  - [ ] Reverse position → Terminal 5 (S2)

### VFD Programming:
- [ ] VFD F-parameters programmed per specification
- [ ] F11 = 000 (S1 = Forward run)
- [ ] F12 = 001 (S2 = Reverse run) 
- [ ] F14 = 006 (S4 = External Emergency Stop)
- [ ] Control mode parameters set (F04, F05, F06)

### System Verification:
- [ ] Flora tachometer powered and functional
- [ ] All safety systems tested and operational
- [ ] Signal logic verified (24V = HIGH = Active for PNP mode)