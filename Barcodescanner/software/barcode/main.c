
#include "network.h"
#include "chartemplate.h"

#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include <unistd.h>
#include <time.h>
#include "io.h"
#include "altera_avalon_pio_regs.h"

	//Clear all text on screen
	void clearText(){
		for(int x = 0; x < 10000; x+=4){
			IOWR_ALTERA_AVALON_PIO_DATA(x ,(0<<16)| (0<<8) | 0);
		}
	}

	//Method to draw raw char pixels to VGA output
	void drawChars(int pixels[35][8]){
			int totalChars = 35;
			int add = 0;
			int x = 0;
			int linePixelCount = 0;
			clearText();
			int pixel = 0;
			while(x < 40*totalChars){
				//Draw all chars to video memory used by VGA controller
				for(int currentChar = 0; currentChar < totalChars; currentChar++){
					for(int bit = 4; bit >= 0; bit--){
						linePixelCount++;
						int val = 0;
						if((pixels[currentChar][pixel] & (1 << bit)) != 0){
							val = 255;
						}
						IOWR_ALTERA_AVALON_PIO_DATA(add ,(val<<16)| (val<<8) | val);
						x++;
						add+=4;
					}
					add+=4;
				}
				if(linePixelCount == (5*totalChars)){
					add+=(800-(24*totalChars));
					linePixelCount = 0;
				}
				pixel++;
			}
		}


//Draw char array argument on screen
void showText(char *chars){
	int pixeldata[35][8];
	for(int x = 0; x < 35; x++){
		switch (chars[x]) {
		  case 'a': memcpy(&pixeldata[x], &charTemplate[0], sizeof(pixeldata[x]) ); break;
		  case 'b': memcpy(&pixeldata[x], &charTemplate[1], sizeof(pixeldata[x]) ); break;
		  case 'c': memcpy(&pixeldata[x], &charTemplate[2], sizeof(pixeldata[x]) ); break;
		  case 'd': memcpy(&pixeldata[x], &charTemplate[3], sizeof(pixeldata[x]) ); break;
		  case 'e': memcpy(&pixeldata[x], &charTemplate[4], sizeof(pixeldata[x]) ); break;
		  case 'f': memcpy(&pixeldata[x], &charTemplate[5], sizeof(pixeldata[x]) ); break;
		  case 'g': memcpy(&pixeldata[x], &charTemplate[6], sizeof(pixeldata[x]) ); break;
		  case 'h': memcpy(&pixeldata[x], &charTemplate[7], sizeof(pixeldata[x]) ); break;
		  case 'i': memcpy(&pixeldata[x], &charTemplate[8], sizeof(pixeldata[x]) ); break;
		  case 'j': memcpy(&pixeldata[x], &charTemplate[9], sizeof(pixeldata[x]) ); break;
		  case 'k': memcpy(&pixeldata[x], &charTemplate[10], sizeof(pixeldata[x]) ); break;
		  case 'l': memcpy(&pixeldata[x], &charTemplate[11], sizeof(pixeldata[x]) ); break;
		  case 'm': memcpy(&pixeldata[x], &charTemplate[12], sizeof(pixeldata[x]) ); break;
		  case 'n': memcpy(&pixeldata[x], &charTemplate[13], sizeof(pixeldata[x]) ); break;
		  case 'o': memcpy(&pixeldata[x], &charTemplate[14], sizeof(pixeldata[x]) ); break;
		  case 'p': memcpy(&pixeldata[x], &charTemplate[15], sizeof(pixeldata[x]) ); break;
		  case 'q': memcpy(&pixeldata[x], &charTemplate[16], sizeof(pixeldata[x]) ); break;
		  case 'r': memcpy(&pixeldata[x], &charTemplate[17], sizeof(pixeldata[x]) ); break;
		  case 's': memcpy(&pixeldata[x], &charTemplate[18], sizeof(pixeldata[x]) ); break;
		  case 't': memcpy(&pixeldata[x], &charTemplate[19], sizeof(pixeldata[x]) ); break;
		  case 'u': memcpy(&pixeldata[x], &charTemplate[20], sizeof(pixeldata[x]) ); break;
		  case 'v': memcpy(&pixeldata[x], &charTemplate[21], sizeof(pixeldata[x]) ); break;
		  case 'w': memcpy(&pixeldata[x], &charTemplate[22], sizeof(pixeldata[x]) ); break;
		  case 'x': memcpy(&pixeldata[x], &charTemplate[23], sizeof(pixeldata[x]) ); break;
		  case 'y': memcpy(&pixeldata[x], &charTemplate[24], sizeof(pixeldata[x]) ); break;
		  case 'z': memcpy(&pixeldata[x], &charTemplate[25], sizeof(pixeldata[x]) ); break;
		  case ' ': memcpy(&pixeldata[x], &charTemplate[26], sizeof(pixeldata[x]) ); break;
		  default: memcpy(&pixeldata[x], &charTemplate[26], sizeof(pixeldata[x]) );

		 }
	}

	drawChars(pixeldata);
}

//Method for decoding the barcode based on pixel data from VGA
char charcode[256] = {};
int barwidth = 0;
int actualCount = 0;
void scanBarcode(){
	int firstBit = 0;
	int countingBarWidth = 1;
	barwidth = 0;
	actualCount = 0;

	//Calculate all pixels based on VGA pixel's
	for(int x =0; x < 255; x++){
		IOWR_ALTERA_AVALON_PIO_DATA(0x4020, x);
		int r = IORD_ALTERA_AVALON_PIO_DATA(0x4000);
		int g = IORD_ALTERA_AVALON_PIO_DATA(0x4010);
		int b = IORD_ALTERA_AVALON_PIO_DATA(0x4040);

		int grey =  0.2126*r + 0.7152*g + 0.0722*b;
		usleep(5100);
		if(grey > 128){
			if(firstBit==1){
				countingBarWidth = 0;
				charcode[actualCount] = '0';
				actualCount++;
			}
		}else{
			charcode[actualCount] = '1';
			actualCount++;
			if(countingBarWidth == 1){
				barwidth++;
			}
			firstBit = 1;
		}
	}
	for(int x = 0; x < 255; x+=barwidth){
		printf("%c",charcode[x]);
		tx_char(charcode[x],x);
	}
	transmit();
}
int main(void){
	setup();
	//Show default text on screen
	showText("please hold barcode over line");

	//Delay to Wait for network connection with PC to start
	usleep(2000000);
	//Scan barcode
	scanBarcode();

	while(1){}

	return 0;
}

//Called when network packet is received from server
void callback(unsigned char *data){
	alt_printf( "\nResponds: %s\n", data + 16);
	showText(data + 16);
}
