/**
 * Troll Circuit is just a servo simple application to make a troll face go up and down. 
 *
 * Based on Sweep by BARRAGAN <http://barraganstudio.com> 
 */


#include <Servo.h> 
 
Servo myservo;

int toggle_btn = 7;
int tune_up_btn = 6;
int tune_down_btn = 5;

int up_position = 70;
int down_position = 180;
boolean up = false;
 
void setup() { 
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
  pinMode(toggle_btn, INPUT);
  pinMode(13, OUTPUT); // Buit In LED to point up or down
  myservo.write(down_position);
}

void toggle() {
  if(up) {
    myservo.write(down_position);
    digitalWrite(13, LOW);
  }
  else {
    myservo.write(up_position);
    digitalWrite(13, HIGH);
  }
  
  up = !up;
}

// This will be implemented in the future
void tuneUp() {
}

// This will be implemented in the future
void tuneDown() {
}

int last_toggle_btn_state = LOW;
 
void loop() {
  int toggle_btn_state = digitalRead(toggle_btn);
  
  // State changed
  if(toggle_btn_state != last_toggle_btn_state) {
    if (toggle_btn_state == HIGH) {
      toggle();
      delay(150); // To keep consistency and avoid button wild behavior
    }
  }
  
  last_toggle_btn_state = toggle_btn_state;
  delay(15);
}

