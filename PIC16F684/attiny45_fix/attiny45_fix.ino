/*****************************
 * Program for an ATTiny45
 * Fix lab4 by turning on relay when button is pushed
 *****************************/

#define testSwitch 1
#define Relay 2

void setup() {
  pinMode(testSwitch, INPUT);
  pinMode(Relay, OUTPUT);
  delay(100);
}

void loop() {
  if(digitalRead(testSwitch) == LOW)
    digitalWrite(Relay, HIGH);
  
  
  if(digitalRead(testSwitch) == HIGH)
    digitalWrite(Relay, LOW);
  
}
