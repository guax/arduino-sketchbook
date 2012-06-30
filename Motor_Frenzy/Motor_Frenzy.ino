/*
DO NOT TURN LEFT AND RIGHT ON AT THE SAME TIME OR YOU WILL BURN ALL
THE TRANSISTORS.

With this code from half the pot values you control the right direction power
and the other half the left direction power of a motor.
*/

int pot = 0; // Potentiometer port
int left = 10; // Left signal output
int right = 11; // Right signal output
int led = 2;

// Serial debug flag
boolean debug = false;

const int ledCount = 4;    // the number of LEDs in the bar graph
int ledPins[] = { 3,4,5,6 };   // an array of pin numbers to which LEDs are attached

void setup() {
  pinMode(right,OUTPUT);
  pinMode(left,OUTPUT);
  pinMode(led,OUTPUT);
  // loop over the pin array and set them all to output:
  for (int thisLed = 0; thisLed < ledCount; thisLed++) {
    pinMode(ledPins[thisLed], OUTPUT);
  }
  
  if(debug) {
    Serial.begin(9600);
  }
}

void barPrint(int level) {
  // loop over the LED array:
  for (int thisLed = 0; thisLed < ledCount; thisLed++) {
    // if the array element's index is less than ledLevel,
    // turn the pin for this element on:
    if (thisLed < level) {
      digitalWrite(ledPins[thisLed], HIGH);
    } 
    // turn off all pins higher than the ledLevel:
    else {
      digitalWrite(ledPins[thisLed], LOW);
    }
  }
}

void loop() {
  int potVal = analogRead(pot);
  int ledLevel = 0;

  // Easy to work resolution
  int outputValue = map(potVal, 0, 1023, 0, 60);
  
  // Going left
  if ( outputValue < 25 ) {
    outputValue = (outputValue -25) * -1;
    digitalWrite(led, HIGH);
    analogWrite(right, 0);
    delay(30); // Transistor safety. DO NOT REMOVE
    ledLevel = map(outputValue, 0, 25, 0, ledCount);
    barPrint(ledLevel);
    analogWrite(left, outputValue*10);
  }
  // Going right
  else if ( outputValue > 35 ) {
    digitalWrite(led, HIGH);
    outputValue = outputValue - 35;
    analogWrite(left, 0);
    delay(30); // Transistor safety. DO NOT REMOVE
    ledLevel = map(outputValue, 0, 24, 0, ledCount);
    barPrint(ledLevel);
    analogWrite(right, outputValue*10);
  }
  // Stopped
  else {
    digitalWrite(led, LOW);
    analogWrite(left, 0);
    analogWrite(right, 0);
  }
  
  if(debug) {
    Serial.print("{\"outputValue\":\"");
    Serial.print(outputValue);
    Serial.print("\",\"potValue\":\"");
    Serial.print(potVal);
    Serial.print("\",\"ledLevel\":\"");
    Serial.print(ledLevel);
    Serial.println("\"}");
  }
  
  delay(30);
}

