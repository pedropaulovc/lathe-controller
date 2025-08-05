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
- **Terminal 3 (DI2)**: Reverse Run (not used in this application)
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
24V+ ----[Jog Switch]-------- Terminal 4 (DI3)
24V+ ----[E-Stop NC]--------- Terminal 6 (DI4)
```

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
- P4-03 = 7 (DI3 = Jog forward)
- P4-04 = 9 (DI4 = External fault)