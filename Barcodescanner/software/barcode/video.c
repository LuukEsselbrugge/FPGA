#include <stdio.h>
#include <unistd.h>
#include "system.h"
//#include "altera_avalon_pio_regs.h"


void video()
{

  while (1)
  {
	  //Random RGB kleur
	  int r = rand()%(255-0 + 1) + 0;
	  int g = rand()%(255-0 + 1) + 0;
	  int b = rand()%(255-0 + 1) + 0;
	  drawColor((r<<16)| (g<<8) | b);
  }
}

void drawColor(int hex){
	int width = 50;
	int height = 50;

	int x = 0;
	while(x < width * height * 4){
		//Draw single pixel to video memory used by VGA controller
		//IOWR_ALTERA_AVALON_PIO_DATA(x ,hex);
		//Delay voor leuk effect
		usleep(500);
		x+=4;
	}
}

//void drawImage(){
//	  int x = 0;
//	  	  	int pixel = 0;
//	  	  	while(x < 50 * 50 * 4){
//	  	  		//Draw single pixel to video memory used by VGA controller
//	  	  		for(int bit = 7; bit > 0; bit--){
//	  	  			int val = 0;
//	  	  			if(((yeet[pixel] >> bit)  & 0x01)){
//	  	  				val = 255;
//	  	  			}
//	  				IOWR_ALTERA_AVALON_PIO_DATA(x,(val<<16)| (val<<8) | val);
//	  				x+=4;
//	  	  		}
//	  	  		pixel++;
//	  	  	}
//}
