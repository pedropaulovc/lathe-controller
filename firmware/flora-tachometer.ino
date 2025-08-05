#include <LedControl.h>

const int OPTICAL_SWITCH_PIN = 2;  // Interrupt capable pin
const int CS_PIN = 10;             // MAX7219 Chip Select
const int DIN_PIN = 11;            // MAX7219 Data In
const int CLK_PIN = 13;            // MAX7219 Clock

LedControl lc = LedControl(DIN_PIN, CLK_PIN, CS_PIN, 1);

volatile unsigned long pulseCount = 0;
unsigned long lastDisplayUpdate = 0;
unsigned long lastPulseTime = 0;
unsigned long currentTime = 0;
float currentRPM = 0.0;

const unsigned long DISPLAY_UPDATE_INTERVAL = 250;  // 250ms update rate
const unsigned long TIMEOUT_PERIOD = 2000;         // 2 seconds timeout for zero RPM
const int PULSES_PER_REVOLUTION = 60;               // 60 slots in interrupt wheel

void setup() {
  pinMode(OPTICAL_SWITCH_PIN, INPUT_PULLUP);
  
  lc.shutdown(0, false);       // Wake up MAX7219
  lc.setIntensity(0, 8);       // Set brightness (0-15)
  lc.clearDisplay(0);          // Clear display
  
  attachInterrupt(digitalPinToInterrupt(OPTICAL_SWITCH_PIN), pulseISR, FALLING);
  
  displayRPM(0);
  lastDisplayUpdate = millis();
}

void loop() {
  currentTime = millis();
  
  if (currentTime - lastDisplayUpdate >= DISPLAY_UPDATE_INTERVAL) {
    calculateRPM();
    displayRPM(currentRPM);
    lastDisplayUpdate = currentTime;
  }
}

void pulseISR() {
  pulseCount++;
  lastPulseTime = millis();
}

void calculateRPM() {
  static unsigned long lastCalcTime = 0;
  static unsigned long lastPulseCount = 0;
  
  unsigned long timeDelta = currentTime - lastCalcTime;
  unsigned long pulseDelta = pulseCount - lastPulseCount;
  
  if (timeDelta >= DISPLAY_UPDATE_INTERVAL) {
    if (currentTime - lastPulseTime > TIMEOUT_PERIOD) {
      currentRPM = 0.0;
    } else if (pulseDelta > 0 && timeDelta > 0) {
      float rps = (float)pulseDelta / ((float)timeDelta / 1000.0);
      currentRPM = (rps * 60.0) / PULSES_PER_REVOLUTION;
    }
    
    lastCalcTime = currentTime;
    lastPulseCount = pulseCount;
  }
}

void displayRPM(float rpm) {
  int displayValue = (int)(rpm + 0.5);  // Round to nearest integer
  
  if (displayValue > 9999) {
    displayValue = 9999;  // Limit to 4 digits
  }
  
  lc.clearDisplay(0);
  
  if (displayValue == 0) {
    lc.setDigit(0, 0, 0, false);
    lc.setDigit(0, 1, 0, false);
    lc.setDigit(0, 2, 0, false);
    lc.setDigit(0, 3, 0, false);
  } else {
    int digits[4];
    digits[0] = displayValue % 10;           // Ones
    digits[1] = (displayValue / 10) % 10;    // Tens
    digits[2] = (displayValue / 100) % 10;   // Hundreds
    digits[3] = (displayValue / 1000) % 10;  // Thousands
    
    bool leadingZero = true;
    for (int i = 3; i >= 0; i--) {
      if (digits[i] != 0) {
        leadingZero = false;
      }
      
      if (!leadingZero || i == 0) {
        lc.setDigit(0, i, digits[i], false);
      }
    }
  }
}