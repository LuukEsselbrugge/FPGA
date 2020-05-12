#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"


int main()
{
  int switches = 0;
  while (1)
  {
	  switches = IORD_ALTERA_AVALON_PIO_DATA(SWITCHES_BASE);
	  //switches |= 1UL << 5;
	  IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, switches);

	  //printf("\n Switch Value: %d",switches);

	  int x = 0;
	  while(x < 50){
		  IOWR_ALTERA_AVALON_PIO_DATA(x-1, 150);
		  IOWR_ALTERA_AVALON_PIO_DATA(x, 255);
		  usleep(20000);
		  x++;
	  }





  }
}
