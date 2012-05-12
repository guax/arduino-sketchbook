// Output signal
int led = 13;

// Dot duration
int u = 100;

// Standard definition of short and long
int s = u;
int l = u*3;

/*
Character mapping.

The character mapping is made by defining
the three signals for 'a' to 'z' in an ASCII
table order.
Thus being letters[0] = 'a' and letters[25] = 'z'
*/
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
  
  // Short delay to give time to read the message from the begining
  delay(2000); 
}


// Code responsible to write a single letter
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

// Function responsible to write words
void writeMorse(String raw_string) {
    // Working with the lower case part of the ascii table
    String string = raw_string.toLowerCase();
    
    for(int i = 0; i < string.length(); i++) {
        
        // Checking for valid letter range
        if(int(string.charAt(i)) - 97 >= 0 && int(string.charAt(i)) - 97 < 25) {
          // Printing the letter
          // Note that -97 is the offset of the ascii table to our char mapping
          writeLetter(letters[int(string.charAt(i)) - 97]);
        }
        else if(int(string.charAt(i)) == 32) {
          // Manual whitespace delay
          delay(u*3);
        }
        // inter-letter delay
        delay(u*3);
    }
}

void loop() {
  writeMorse("SOS");
  // Delay of repetition
  delay(u*6);
}
