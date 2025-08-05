# VFD Direct Connections Guide

## Teco EV Micro Drive Terminal Connections

### Power Connections
- **L1, L2**: 115VAC input from main power
- **U, V, W**: 3-phase output to motor
- **Ground**: Connect to electrical ground

### Control Circuit Power
- **24V+, 24V-**: Internal 24VDC supply for control circuits (use for switches)

### Analog Speed Control
- **Terminal 2 (AI1+)**: Speed control input (0-10VDC)
- **Terminal 5 (AGND)**: Analog ground reference
- **Connection**: 10kΩ potentiometer with 0-10V scaling circuit

### Digital Input Functions
- **Terminal 1 (DI1)**: Forward Run (connect Run switch here)
- **Terminal 3 (DI2)**: Reverse Run (connect Forward/Reverse toggle switch here)
- **Terminal 4 (DI3)**: Jog Forward (connect Jog switch here)
- **Terminal 6 (DI4)**: External Fault/E-Stop (connect E-Stop NC contacts)
- **Terminal 7 (DI5)**: Multi-step speed 1 (optional)
- **Terminal 8 (DI6)**: Multi-step speed 2 (optional)
- **Terminal 9 (DI7)**: Coast stop (optional)

### Digital Input Wiring
All digital inputs are isolated and can accept:
- 24VDC (using internal 24V supply)
- NPN or PNP logic
- Dry contacts (switches)

### Switch Connections
```
24V+ ----[Run Switch]-------- Terminal 1 (DI1)
24V+ ----[Fwd/Rev Toggle]---- Terminal 3 (DI2)
24V+ ----[Jog Switch]-------- Terminal 4 (DI3)
24V+ ----[E-Stop NC]--------- Terminal 6 (DI4)
```

### Forward/Reverse Toggle Switch Wiring
The forward/reverse control uses a SPDT (single pole, double throw) metal toggle switch:
- **Center Position**: Motor stops (neutral)
- **Forward Position**: Normal forward rotation (switch open, DI2 not activated)
- **Reverse Position**: Reverse rotation (switch closed, 24V+ connected to Terminal 3)

### Speed Potentiometer Circuit
```
+12V ----[10kΩ Pot]---- 0V
         |
         +---- Op-Amp Buffer ---- Terminal 2 (AI1+)
                                  Terminal 5 (AGND)
```

### VFD Programming Parameters
Set these parameters for proper operation:
- P0-02 = 1 (External speed command via AI1)
- P0-03 = 0 (External run command via DI1)
- P1-00 = 60 (Maximum frequency 60Hz for 1800 RPM motor)
- P1-01 = 0 (Minimum frequency)
- P4-01 = 1 (DI1 = Forward run)
- P4-02 = 2 (DI2 = Reverse run)
- P4-03 = 7 (DI3 = Jog forward)
- P4-04 = 9 (DI4 = External fault)

### Safety Notes for Reverse Operation
- **WARNING**: Ensure the lathe chuck and workpiece are suitable for reverse rotation
- **Tooling**: Verify cutting tools are appropriate for reverse operation
- **Chuck Type**: Threaded chucks may loosen in reverse - use locking mechanisms
- **Always**: Test reverse operation at low speed first