# FLORA Tachometer Circuit

## Component Connections

### IR Sensor Module
```
IR Sensor Pin    Connection           Notes
-------------    -----------          -----
+5V/VCC         ---- 3.3V/5V (FLORA) Power supply 3.3V-5V
GND             ---- GND (FLORA)      Ground connection
OUT             ---- D2 (FLORA)       Signal output to interrupt pin
```

**Important Arduino Setup Notes:**
- Set the IR sensor input pin as INPUT mode: `pinMode(IR_SENSOR_PIN, INPUT);`
- For Arduino and higher-level controllers, **always** configure I/O pins as input/receive mode
- 51 series MCUs can be used directly without input/output mode configuration

### FLORA Connections
- **D2**: IR sensor signal output (interrupt capable pin, set as INPUT)
- **D3**: TM1637 Clock pin (CLK)
- **D4**: TM1637 Data pin (DIO)
- **3.3V/5V**: Power for IR sensor (supports both voltages)
- **GND**: Common ground

### TM1637 4-Digit Display
```
FLORA Pin    TM1637 Pin     Function
---------    ----------     --------
D3           CLK            Clock signal
D4           DIO            Data I/O
5V/3.3V      VCC            Power (3.3V-5V)
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
- **Input**: 12VDC wall adapter or VFD 24V supply
- **FLORA Power**: USB connector or external 5V supply
- **IR Sensor**: Powered from FLORA 3.3V or 5V pin
- **TM1637 Display**: Powered from FLORA 3.3V or 5V pin

### Circuit Protection
- **Power supply**: 1A fuse on external power input
- **FLORA**: Built-in protection on USB/power pins
- **Components**: TM1637 and IR sensor modules include built-in protection

## Wiring Diagram Notes
1. Keep IR sensor wires short (<6 inches) to minimize noise
2. Use shielded cable if spindle has variable speed drive nearby
3. Mount IR sensor securely - vibration will cause false readings
4. Test gap between wheel and sensor (typically 1-5mm optimal for IR sensors)
5. Brass wheel with slitting saw cuts provides excellent optical contrast
6. **Critical**: Set IR sensor pin as INPUT mode in Arduino setup()

## Calibration
- **Pulses per revolution**: 60 (based on interrupt wheel slots)
- **RPM calculation**: RPM = (pulse_count * 60) / (time_seconds * 60)
- **Update rate**: Display updates every 250ms for stable reading
- **IR Sensor Setup**: Ensure sensor detects slot transitions reliably