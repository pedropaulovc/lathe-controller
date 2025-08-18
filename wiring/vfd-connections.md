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
- **Terminal 4 (S1)**: Forward Run (connect Run switch here)
- **Terminal 5 (S2)**: Reverse Run (connect Forward/Reverse toggle switch here)
- **Terminal 6 (S3)**: Jog Forward (connect Jog switch here)
- **Terminal 7 (S4)**: External Fault/E-Stop (connect E-Stop NC contacts - normally closed)
- **Terminal 10 (AIN/S7)**: Main On/Off Switch (when used as digital input S7)

### Digital Input Wiring
All digital inputs (S1-S4, S7) are isolated and can accept:
- 24VDC (using Terminal 3 supply when SW1 set to PNP mode)
- NPN or PNP logic (controlled by SW1 setting)
- Dry contacts (switches)

### Switch Connections
```
Terminal 3 (24V) ----[On/Off Switch]----- Terminal 10 (S7)    (Main power enable)
Terminal 3 (24V) ----[Run Switch]-------- Terminal 4 (S1)     (Forward run)
Terminal 3 (24V) ----[Fwd/Rev Toggle]---- Terminal 5 (S2)     (Reverse run)
Terminal 3 (24V) ----[Jog Switch]-------- Terminal 6 (S3)     (Jog forward)
Terminal 3 (24V) ----[E-Stop NC]--------- Terminal 7 (S4)     (External fault - NC)
```

### E-Stop Switch Configuration
The E-Stop uses a **normally closed (NC)** switch configuration:
- **Normal Operation**: E-Stop switch is closed, 24V flows from Terminal 3 to Terminal 7 (S4)
- **Emergency Stop**: E-Stop switch opens, removing 24V from Terminal 7 (S4)
- **VFD Response**: Loss of signal on S4 triggers external fault, immediately stops motor
- **Reset**: E-Stop must be reset (closed) before VFD can restart

### Main On/Off Switch Configuration
The main on/off switch provides master enable/disable control:
- **Switch Type**: SPST (Single Pole, Single Throw) momentary or maintained contact
- **ON Position**: Switch closed, 24V flows from Terminal 3 to Terminal 10 (S7), enables VFD operation
- **OFF Position**: Switch open, removes 24V from Terminal 10 (S7), disables VFD
- **Function**: Master enable - all other controls require this switch to be ON
- **Safety**: Provides additional safety layer beyond E-Stop for planned shutdowns

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
- F15 = 017 or 018 (Terminal 10 as analog input AIN)
- F11 = 001 (S1 = Forward run)
- F12 = 002 (S2 = Reverse run) 
- F13 = 007 (S3 = Jog forward)
- F14 = 009 (S4 = External fault)
- When Terminal 10 used as S7: F15 = 019, then set function for S7

### Safety Notes for Reverse Operation
- **WARNING**: Ensure the lathe chuck and workpiece are suitable for reverse rotation
- **Tooling**: Verify cutting tools are appropriate for reverse operation
- **Chuck Type**: Threaded chucks may loosen in reverse - use locking mechanisms
- **Always**: Test reverse operation at low speed first