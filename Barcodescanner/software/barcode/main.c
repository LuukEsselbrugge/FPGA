#include "network.h"

int main(void){

	setup();
	//

	while(1){
		//tx_ethernet_isr("Hello");
		refresh_ethernet();
	}

	return 0;
}
