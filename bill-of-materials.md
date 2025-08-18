# Lathe Controller Bill of Materials

## Microcontroller & Display
| Component | Qty | Description | Specifications | Est. Cost |
|-----------|-----|-------------|----------------|-----------|
| Adafruit FLORA | 1 | Microcontroller board | ATmega32u4, 3.3V, USB programmable | $15-20 |
| TM1637 4-Digit Display | 1 | LED display module | TM1637 driver, 0.36" digits, red, CLK/DIO | $3-6 |

## Tachometer Components
| Component | Qty | Description | Specifications | Est. Cost |
|-----------|-----|-------------|----------------|-----------|
| IR Sensor Module | 1 | Infrared sensor | 3.3V-5V supply, digital OUT pin | $2-4 |
| Brass Round Stock | 1 | Interrupt wheel material | 1/8" thick, 2-3" diameter, 360 brass | $15-25 |

## Control Components
| Component | Qty | Description | Specifications | Est. Cost |
|-----------|-----|-------------|----------------|-----------|
| Momentary Switch | 1 | Run switch | SPST NO, 5A 115VAC rated | $5-8 |
| Momentary Switch | 1 | Jog switch | SPST NO, 5A 115VAC rated | $5-8 |
| Toggle Switch | 1 | Forward/Reverse switch | SPDT, center off, metal body, 1/2" mount | $8-12 |
| Emergency Stop Switch | 1 | E-stop mushroom button | NC contacts, twist to reset | $15-25 |
| Potentiometer | 1 | Speed control | 10kΩ linear, 1/4" shaft | $3-5 |
| Control Knob | 1 | Speed control knob | 1/4" bore, index marking | $2-4 |

## Wiring & Hardware
| Component | Qty | Description | Specifications | Est. Cost |
|-----------|-----|-------------|----------------|-----------|
| 22 AWG Wire | 10 ft | Hook-up wire | Stranded, multiple colors | $5-8 |
| Terminal Blocks | 6 | Screw terminals | 2-position, 22-16 AWG | $8-12 |
| Heat Shrink Tubing | 1 pack | Wire protection | Assorted sizes | $3-5 |
| M3 Screws | 10 | Case assembly | Various lengths 8-20mm | $2-3 |

## Case Materials
| Component | Qty | Description | Specifications | Est. Cost |
|-----------|-----|-------------|----------------|-----------|
| 3D Printer Filament | 200g | Case material | PLA or PETG, any color | $5-8 |

## Machining (User Supplied)
| Component | Qty | Description | User Specifications |
|-----------|-----|-------------|-------------------|
| HSS Slitting Saw | 1 | Slot cutting tool | 1/8" thick, 3" diameter, 30 teeth |
| Milling Machine | 1 | Machining equipment | For interrupt wheel fabrication |

## Total Estimated Cost: $88-148

## Notes
- VFD provides internal 24VDC and 10VDC supplies - no external power needed
- All switches connect directly to VFD terminals using internal 24V supply
- FLORA powered via USB during programming, can use VFD 24V in final installation
- TM1637 display module is more cost-effective than MAX7219 display ($3-6 vs $8-12)
- IR sensor module includes built-in signal conditioning (no external resistors needed)
- HSS slitting saw creates 60 slots at 6° indexing in brass wheel
- Case design accommodates 5" width with front-mounted controls
- **Arduino Setup**: IR sensor pin must be configured as INPUT mode in firmware