// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(2,3,4,5,6,7,8,9,10,11,12);
//keeps track of endline
int l=0;
//need to clear screen or not
int clear = 0; 

void setup() {
	//Setting up serial communication
	Serial.begin(57600);
	
	//starting LCD
	lcd.begin(16, 1);
	
	//test display by filling it with all the chars available
	for (int i=47; i<127; i++){
		lcd.print(i,BYTE);
	}
}

//function to print a character
void printIntToLCD(int val){
	//if endline or new line
	if (val == 10 || val == 13){
		//13 is endline, simply do nothing
		if(val == 10){ //newline
			clear = 1; // clear screen for new line
		}
	}else{
		if(clear == 1){
			lcd.clear(); 
			l = 0; 
			clear = 0;
		}
		if(l>31){ //if screen is full, return to beginning 
			lcd.clear(); 
			l=0;
		}
		lcd.print((char) val);
		l++;
	}
}

void loop() { 
	if (Serial.available() >0){ 
		int incoming = Serial.read();
		printIntToLCD(incoming);
	}
}
