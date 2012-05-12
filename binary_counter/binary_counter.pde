int leds[] = {3,5,6,9,10};
int resolution = 5; // size of the leds array
int potentiometer = 0; // Pot that control the speed of the counter
int potValue=250;

int on = 1;
boolean animate = true;
boolean foward = true;

int sensorValue;
int lastSensorValue = 0;
boolean visible = true;

// My clever function to write binary to port range
void printBinary(int number) {
  int mask;
  int power;
  
  for( int i = 0; i < resolution; i++) {
    mask = B1 << i;
    if(true && (mask & number)) {
      power = HIGH;
    }
    else {
      power = LOW;
    }
    digitalWrite(leds[i], power);
  }
  
}

void setup()  { 
  for(int i = 0; i < resolution; i++) {
      pinMode(leds[i], OUTPUT);
  }
  pinMode(13, OUTPUT); // State the visibility of the display
  digitalWrite(13, HIGH);
  
  // Display on/off button
  pinMode(2, INPUT);
}

void loop() {
  // Funky boot animation :)
  if(animate) {
    printBinary(on);
    
    if(foward) {
      on = on * 2;
    }
    else {
      on = on / 2;
    }

    
    if( on >= pow(2, resolution) ) {
      foward = false;
      on = resolution;
    }
    else if(on == 0) {
      animate = false;
    }
    
    delay(100);
  }
  else {
    sensorValue = digitalRead(2);
    if(sensorValue == HIGH && sensorValue != lastSensorValue) {
      lastSensorValue = HIGH;
      
      if(visible) {
        printBinary(0);
        digitalWrite(13, LOW);
      }
      else {
        digitalWrite(13, HIGH);
      }
      
      
      
      visible = !visible;
    }
    else if(sensorValue == LOW && sensorValue != lastSensorValue) {
      lastSensorValue = LOW;
    }
  
    if(visible) {
      printBinary(on);
    }
    
    on = on + 1;
    if(on == pow(2, resolution)) {
      on = 0;
    }
    
    potValue = analogRead(potentiometer);
    delay(potValue);
  }
}
