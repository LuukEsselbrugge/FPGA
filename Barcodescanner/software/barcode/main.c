
#include "network.h"

#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include <unistd.h>
#include <time.h>

int main(void){

	setup();

	while(1){
		//tx_ethernet_isr("Hello");
		//printf("a\n");
		usleep(1000000);
		tx_ethernet_isr("12345");
		//refresh_ethernet();

	}

	return 0;
}

void callback(unsigned char *data){
	alt_printf( "Responds: %s\n", data + 16);
}
