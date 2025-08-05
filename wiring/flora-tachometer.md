# FLORA Tachometer Circuit

## Component Connections

### Slotted Optical Switch (e.g., TCST2103)
```
Pin 1 (Anode)    ---- 3.3V (FLORA)
Pin 2 (Cathode)  ---- 330Ω resistor ---- GND
Pin 3 (Collector)---- 10kΩ pullup ---- 3.3V
Pin 4 (Emitter)  ---- GND
```

### FLORA Connections
- **D2**: Optical switch signal (interrupt capable pin)
- **3.3V**: Power for optical switch
- **GND**: Common ground

### 7-Segment Display (4-digit with MAX7219 driver)
```
FLORA Pin    MAX7219 Pin    Function
---------    -----------    --------
D10          CS             Chip Select
D11          DIN            Data In  
D13          CLK            Clock
3.3V         VCC            Power
GND          GND            Ground
```

### Interrupt Wheel Specifications
- **Material**: 1/8" thick 360 brass (free-machining)
- **Diameter**: 2-3 inches (mount on spindle)
- **Slots**: 60 evenly spaced slots (6° indexing)
- **Slot width**: 1/8" (matches HSS slitting saw)
- **Manufacturing**: HSS slitting saw (1/8" × 3" × 30T)
- **Machining**: 500-800 RPM, light feed, index 6° between cuts
- **Mounting**: Central bore with keyway or set screw holes

### Power Supply
- **Input**: 12VDC wall adapter
- **Regulation**: 7805 linear regulator (12V → 5V)
- **FLORA Power**: USB connector or 3.3V pin (internal regulator)

### Circuit Protection
- **Optical switch**: 330Ω current limiting resistor
- **Power supply**: 1A fuse on 12V input
- **FLORA**: Built-in protection on USB/power pins

## Wiring Diagram Notes
1. Keep optical switch wires short (<6 inches) to minimize noise
2. Use shielded cable if spindle has variable speed drive nearby
3. Mount optical switch securely - vibration will cause false readings
4. Test gap between wheel and switch (typically 1-3mm optimal)
5. Brass wheel with slitting saw cuts provides excellent optical contrast

## Calibration
- **Pulses per revolution**: 60 (based on interrupt wheel slots)
- **RPM calculation**: RPM = (pulse_count * 60) / (time_seconds * 60)
- **Update rate**: Display updates every 250ms for stable reading