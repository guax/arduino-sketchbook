int led = 13;
int u = 100;
int s = u;
int l = u*3;

int letters[][4] = {
  {s,l,0,0},
  {l,s,s,s},
  {l,s,l,s},
  {l,s,s,0},
  {s,0,0,0},
  {s,s,l,s},
  {l,l,s,0},
  {s,s,s,s},
  {s,s,0,0},
  {s,l,l,l},
  {l,s,l,0},
  {s,l,s,s},
  {l,l,0,0},
  {l,s,0,0},
  {l,l,l,0},
  {s,l,l,s},
  {l,l,s,l},
  {s,l,s,0},
  {s,s,s,0},
  {l,0,0,0},
  {s,s,l,0},
  {s,s,s,l},
  {s,l,l,0},
  {l,s,s,l},
  {l,s,l,l},
  {l,l,s,s}
};

void setup() {                
  pinMode(led, OUTPUT);
  digitalWrite(led, LOW);
  delay(2000);
}

void writeLetter(int *letter) {
    for(int i = 0; i < 4; i++) {
      if(letter[i] > 0) {
        digitalWrite(led, HIGH);
        delay(letter[i]);
        digitalWrite(led, LOW);
        delay(u);
      }
      else {
        i = 5;
      }
    }
}

void writeMorse(String raw_string) {
    String string = raw_string.toLowerCase();
    for(int i = 0; i < string.length(); i++) {
        Serial.println(int(string.charAt(i)) - 97);
        if(int(string.charAt(i)) - 97 >= 0 && int(string.charAt(i)) - 97 < 25) {
          writeLetter(letters[int(string.charAt(i)) - 97]);
        }
        else if(int(string.charAt(i)) == 32) {
          delay(u*3);
        }
        delay(u*3);
    }
}

void loop() {
  writeMorse("SOS");
  delay(u*6);
}
