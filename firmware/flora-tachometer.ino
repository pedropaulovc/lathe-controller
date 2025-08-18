#include <TM1637Display.h>

const int IR_SENSOR_PIN = 6;       // IR sensor output pin (set as INPUT)
const int TM1637_CLK_PIN = 9;      // TM1637 Clock pin
const int TM1637_DIO_PIN = 10;     // TM1637 Data pin
const int ONBOARD_LED_PIN = 13;    // Onboard LED pin (standard Arduino pin)

TM1637Display display(TM1637_CLK_PIN, TM1637_DIO_PIN);

volatile unsigned long pulseCount = 0;
bool lastSensorState = HIGH;  // Track sensor state for edge detection
unsigned long lastDisplayUpdate = 0;
unsigned long lastPulseTime = 0;
unsigned long currentTime = 0;
float currentRPM = 0.0;

const unsigned long DISPLAY_UPDATE_INTERVAL = 250;  // 250ms update rate
const unsigned long TIMEOUT_PERIOD = 2000;         // 2 seconds timeout for zero RPM
const int PULSES_PER_REVOLUTION = 60;               // 60 slots in interrupt wheel

void setup() {
  pinMode(IR_SENSOR_PIN, INPUT);     // Set IR sensor pin as input (required for Arduino)
  pinMode(ONBOARD_LED_PIN, OUTPUT);  // Set onboard LED pin as output
  digitalWrite(ONBOARD_LED_PIN, LOW); // Start with LED off
  
  display.setBrightness(0x0a);       // Set brightness (0x00-0x0f)
  display.clear();                   // Clear display
  
  // Initialize sensor state
  lastSensorState = digitalRead(IR_SENSOR_PIN);
  
  displayRPM(0);
  lastDisplayUpdate = millis();
}

void loop() {
  currentTime = millis();
  
  // Poll sensor for edge detection (replaces interrupt)
  checkSensor();
  
  if (currentTime - lastDisplayUpdate >= DISPLAY_UPDATE_INTERVAL) {
    calculateRPM();
    displayRPM(currentRPM);
    lastDisplayUpdate = currentTime;
  }
  
  // Handle LED when sensor is active
  manageLED();
}

void checkSensor() {
  bool currentSensorState = digitalRead(IR_SENSOR_PIN);
  
  // Detect falling edge (HIGH to LOW transition)
  if (lastSensorState == HIGH && currentSensorState == LOW) {
    pulseCount++;
    lastPulseTime = millis();
  }
  
  lastSensorState = currentSensorState;
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
  
  display.showNumberDec(displayValue, false);  // Show number without leading zeros
}

void manageLED() {
  // Check if we're receiving pulses (sensor is active)
  bool sensorActive = (currentTime - lastPulseTime < TIMEOUT_PERIOD);
  
  if (sensorActive) {
    // Keep LED solid on when sensor is detecting
    digitalWrite(ONBOARD_LED_PIN, HIGH);
  } else {
    // Turn off LED when no sensor activity
    digitalWrite(ONBOARD_LED_PIN, LOW);
  }
}