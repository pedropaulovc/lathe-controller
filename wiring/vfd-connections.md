# VFD Direct Connections Guide

## Teco EV Micro Drive Terminal Connections

### Power Connections
- **L1(L), L2, L3(N)**: Main power input terminals (115VAC single-phase uses L1-L2)
- **T1, T2, T3**: 3-phase output to motor
- **PE**: Earth ground (both input and output sides)

### Control Circuit Power
- **Terminal 3 (24V)**: 24VDC @ 20mA Max supply for control circuits

### Analog Speed Control
- **Terminal 10 (AIN/S7)**: Speed control input (0-10VDC analog mode)
- **Terminal 8 or 11 (COM)**: Common reference for analog input
- **Connection**: 10kΩ potentiometer with 0-10V scaling circuit

### Digital Input Functions
- **Terminal 4 (S1)**: Forward Run (connect On/Off switch here for main run control)
- **Terminal 5 (S2)**: Reverse Run (connect Forward/Reverse toggle switch here)
- **Terminal 7 (S4)**: External Fault/E-Stop (connect E-Stop NC contacts - normally closed)

### Digital Input Wiring
All digital inputs (S1-S4, S7) are isolated and support two signal modes controlled by **hardware switch SW1**:

#### SW1 Setting (Digital Signal Selection):
- **SW1 = PNP (Source Mode)**: Active HIGH logic
  - Terminal 3 (24V) provides common for inputs S1-S4
  - Signal ON = 24V present, Signal OFF = 0V
  - Wiring: `24V+ → [Switch] → S1-S4 input`
  
- **SW1 = NPN (Sink Mode)**: Active LOW logic  
  - Terminal 8 (COM) provides common for inputs S1-S4
  - Signal ON = 0V (to COM), Signal OFF = floating/24V
  - Wiring: `S1-S4 input → [Switch] → COM (0V)`

#### Recommended Configuration:
- **Use SW1 = PNP mode** for simpler wiring with switches
- All control switches connect between Terminal 3 (24V) and input terminals

### Switch Connections (SW1 = PNP Mode)
```
Terminal 3 (24V) ----[On/Off Switch]----- Terminal 4 (S1)     (Main run control)
Terminal 3 (24V) ----[Fwd/Rev Toggle]---- Terminal 5 (S2)     (Reverse run)
Terminal 3 (24V) ----[E-Stop NC]--------- Terminal 7 (S4)     (External fault - NC)
```

**IMPORTANT**: Set VFD hardware switch **SW1 = PNP** for the above wiring configuration.

### E-Stop Switch Configuration
The E-Stop uses a **normally closed (NC)** switch configuration with **SW1 = PNP mode**:

#### Signal Logic (with SW1 = PNP):
- **Normal Operation**: E-stop switch closed → 24V on Terminal 7 (S4) → **Signal HIGH = Normal**
- **Emergency Stop**: E-stop switch opens → 0V on Terminal 7 (S4) → **Signal LOW = Emergency**

#### VFD Response:
- **Signal Loss**: When S4 configured as F14=009 (External Emergency Stop), loss of 24V signal triggers immediate motor stop
- **Deceleration**: Uses C12 (2nd deceleration time) regardless of F09 setting  
- **Display**: Shows "E.S" flashing
- **Reset**: E-Stop must be reset (closed) AND run command cycled before VFD can restart

### Main On/Off Switch Configuration
The main on/off switch provides direct run/stop control:
- **Switch Type**: SPST (Single Pole, Single Throw) maintained contact switch
- **ON Position**: Switch closed, 24V flows from Terminal 3 to Terminal 4 (S1), **starts motor**
- **OFF Position**: Switch open, removes 24V from Terminal 4 (S1), **stops motor**
- **Function**: Direct motor start/stop control
- **Operation**: Motor runs when switch is ON, stops when switch is OFF

### Forward/Reverse Toggle Switch Wiring
The forward/reverse control uses a SPDT (single pole, double throw) metal toggle switch:
- **Center Position**: Motor stops (neutral)
- **Forward Position**: Normal forward rotation (switch open, S2 not activated)
- **Reverse Position**: Reverse rotation (switch closed, 24V connected to Terminal 5 (S2))

### Speed Potentiometer Circuit
```
Terminal 9 (10V) ----[10kΩ Pot]---- Terminal 8 (COM)
                      |
                      +-------------- Terminal 10 (AIN/S7)
```

### VFD Programming Parameters
Set these parameters for proper operation:

#### Hardware Configuration:
- **SW1 = PNP** (Digital Signal Selection - Source Mode)
- **SW2 = V** (Analog Control Selection - 0-10V mode for speed potentiometer)

#### Software Parameters:
- F15 = 017 or 018 (Terminal 10 as analog input AIN for speed control)
- F11 = 000 (S1 = Forward run - main on/off switch)
- F12 = 001 (S2 = Reverse run - direction control)
- F14 = 006 (S4 = External Emergency Stop)

#### Control Mode Parameters:
- F04 = 001 (External terminal control via TM2)
- F05 = 002 (Frequency controlled by Terminal 10 analog input)
- F06 = 000 or 001 (External control operation mode)

### Safety Notes for Reverse Operation
- **WARNING**: Ensure the lathe chuck and workpiece are suitable for reverse rotation
- **Tooling**: Verify cutting tools are appropriate for reverse operation
- **Chuck Type**: Threaded chucks may loosen in reverse - use locking mechanisms
- **Always**: Test reverse operation at low speed first