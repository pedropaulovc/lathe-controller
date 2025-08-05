# Lathe Controller Assembly Guide

## Required Tools
- 3D printer (for case)
- Milling machine (for interrupt wheel)
- HSS slitting saw (1/8" × 3" × 30T)
- Soldering iron and solder
- Wire strippers
- Small screwdrivers
- Indexing head or rotary table

## Step 1: Interrupt Wheel Fabrication

### Material Preparation
1. Start with 1/8" thick 360 brass round stock (2-3" diameter)
2. Face both sides smooth in lathe
3. Create central mounting bore to fit spindle
4. Add keyway or set screw holes for secure mounting

### Slot Cutting with HSS Slitting Saw
1. Mount brass wheel in milling machine with indexing head
2. Install 1/8" thick HSS slitting saw (30 teeth)
3. Set spindle speed: 500-800 RPM
4. Cut 60 slots total at 6° indexing intervals
5. **Critical**: Use light feed rate to prevent saw binding
6. **Important**: Each slot should be clean through-cut for optical switch
7. Deburr all slots after cutting

## Step 2: 3D Print Case
1. Print `controller-case.scad` using recommended settings:
   - Layer height: 0.2mm
   - Infill: 20%
   - No supports needed
2. Test fit all components before assembly
3. Clean support material and smooth mounting surfaces

## Step 3: Electronics Assembly

### FLORA Preparation
1. Install Arduino IDE and LedControl library
2. Upload `flora-tachometer.ino` firmware to FLORA
3. Test display functionality before final assembly

### Component Wiring
Follow wiring diagrams in `/wiring/` directory:

#### Tachometer Circuit (FLORA)
```
TCST2103 Pin 1 (Anode) ---- FLORA 3.3V
TCST2103 Pin 2 (Cathode) -- 330Ω resistor -- FLORA GND
TCST2103 Pin 3 (Collector) - 10kΩ pullup -- FLORA 3.3V
TCST2103 Pin 4 (Emitter) -- FLORA GND
TCST2103 Signal Output --- FLORA D2

MAX7219 CS ---- FLORA D10
MAX7219 DIN --- FLORA D11  
MAX7219 CLK --- FLORA D13
MAX7219 VCC --- FLORA 3.3V
MAX7219 GND --- FLORA GND
```

#### VFD Control Circuit (Direct Connections)
```
24V+ ----[Run Switch]-------- VFD Terminal 1 (DI1)
24V+ ----[Fwd/Rev Toggle]---- VFD Terminal 3 (DI2)
24V+ ----[Jog Switch]-------- VFD Terminal 4 (DI3)  
24V+ ----[E-Stop NC]--------- VFD Terminal 6 (DI4)

Speed Pot:
VFD 10V+ ----[10kΩ Pot]---- VFD AGND
             |
             +-------------- VFD Terminal 2 (AI1+)
```

#### Forward/Reverse Toggle Switch Wiring
The SPDT center-off toggle switch controls motor direction:
- **Center Position**: No connection (motor stops)
- **Forward Position**: Switch open (normal forward operation)
- **Reverse Position**: Switch closed (connects 24V+ to Terminal 3)

## Step 4: Case Assembly

### Install Components
1. Mount FLORA to internal posts using M3 screws
2. Install 7-segment display in front panel cutout
3. Install switches and potentiometer in front panel
4. Secure optical switch near interrupt wheel mounting location

### Wiring in Case
1. Route power wires through bottom cable entry
2. Connect all ground wires to common point
3. Use terminal blocks for VFD connections
4. Apply heat shrink to all wire joints
5. Secure wire bundles to prevent movement

## Step 5: VFD Programming

Set these parameters using VFD keypad:
- P0-02 = 1 (External speed command via AI1)
- P0-03 = 0 (External run command via DI1)  
- P1-00 = 60 (Maximum frequency 60Hz)
- P1-01 = 0 (Minimum frequency)
- P4-01 = 1 (DI1 = Forward run)
- P4-02 = 2 (DI2 = Reverse run)
- P4-03 = 7 (DI3 = Jog forward)
- P4-04 = 9 (DI4 = External fault)

## Step 6: Installation and Testing

### Mounting Controller
1. Mount case to lathe using side mounting tabs
2. Position for easy access to front controls
3. Ensure emergency stop is easily accessible
4. Mount interrupt wheel on spindle with proper gap (1-3mm)

### Initial Testing
1. **Power Test**: Verify VFD powers up normally
2. **Switch Test**: Test run, jog, and e-stop functions
3. **Speed Test**: Verify potentiometer controls motor speed smoothly
4. **Tachometer Test**: 
   - Manually rotate spindle to verify pulse detection
   - Check RPM accuracy at known speeds
   - Verify display updates every 250ms

### Calibration
1. Use external tachometer to verify RPM accuracy
2. Adjust `PULSES_PER_REVOLUTION` in firmware if needed
3. Fine-tune optical switch gap for reliable operation

## Safety Reminders
- **ALWAYS** test emergency stop before operation
- Verify all electrical connections are secure
- Ensure interrupt wheel is properly balanced
- Check that optical switch cannot contact rotating parts
- Confirm motor direction matches lathe requirements

### Reverse Operation Safety
- **Test reverse at low speed first** - Start with minimal RPM
- **Check chuck type** - Threaded chucks may loosen in reverse
- **Verify tooling** - Ensure cutting tools are suitable for reverse
- **Clear workspace** - Remove any items that could be affected by reverse rotation
- **Always use center position** to stop motor before changing direction

## Troubleshooting
- **No RPM display**: Check optical switch gap and wiring
- **Erratic readings**: Reduce electrical noise, check shielding
- **Motor won't start**: Verify VFD parameters and switch connections
- **Incorrect speed**: Check potentiometer wiring and VFD settings