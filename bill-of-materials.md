# Lathe Controller Bill of Materials

## Microcontroller & Display
| Component | Qty | Description | Specifications | Est. Cost |
|-----------|-----|-------------|----------------|-----------|
| Adafruit FLORA | 1 | Microcontroller board | ATmega32u4, 3.3V, USB programmable | $15-20 |
| 4-Digit 7-Segment Display | 1 | LED display with driver | MAX7219 driver, 0.56" digits, red | $8-12 |

## Tachometer Components
| Component | Qty | Description | Specifications | Est. Cost |
|-----------|-----|-------------|----------------|-----------|
| Slotted Optical Switch | 1 | Infrared sensor | TCST2103 or equivalent | $3-5 |
| Brass Round Stock | 1 | Interrupt wheel material | 1/8" thick, 2-3" diameter, 360 brass | $15-25 |
| Resistor | 1 | Current limiting | 330Ω, 1/4W | $0.10 |
| Resistor | 1 | Pull-up resistor | 10kΩ, 1/4W | $0.10 |

## Control Components
| Component | Qty | Description | Specifications | Est. Cost |
|-----------|-----|-------------|----------------|-----------|
| Momentary Switch | 1 | Run switch | SPST NO, 5A 115VAC rated | $5-8 |
| Momentary Switch | 1 | Jog switch | SPST NO, 5A 115VAC rated | $5-8 |
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

## Total Estimated Cost: $90-150

## Notes
- VFD provides internal 24VDC and 10VDC supplies - no external power needed
- All switches connect directly to VFD terminals using internal 24V supply
- FLORA powered via USB during programming, can use VFD 24V in final installation
- HSS slitting saw creates 60 slots at 6° indexing in brass wheel
- Case design accommodates 5" width with front-mounted controls