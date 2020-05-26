#include <altera_avalon_sgdma.h>
#include <altera_avalon_sgdma_descriptor.h>
#include <altera_avalon_sgdma_regs.h>

#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include <unistd.h>
#include "network.h"



// Function Prototypes
void rx_ethernet_isr (void *context);

// Global Variables
unsigned int text_length;

// Create a transmit frame
unsigned char tx_frame[1024] = {
	0x00,0x00, 						// for 32-bit alignment
	0xFF,0xFF,0xFF,0xFF,0xFF,0xFF, 	// destination address (broadcast)
	0x69,0x69,0x69,0x69,0x69,0xAA, 	// source address
	0x69,0x69, 						// length or type of the payload data
	'\0' 							// payload data (ended with termination character)
};

// Create a receive frame
unsigned char rx_frame[1024] = { 0 };

// Create sgdma transmit and receive devices
alt_sgdma_dev * sgdma_tx_dev;
alt_sgdma_dev * sgdma_rx_dev;

// Allocate descriptors in the descriptor_memory (onchip memory)
alt_sgdma_descriptor tx_descriptor		__attribute__ (( section ( ".descriptor_memory" )));
alt_sgdma_descriptor tx_descriptor_end	__attribute__ (( section ( ".descriptor_memory" )));

alt_sgdma_descriptor rx_descriptor  	__attribute__ (( section ( ".descriptor_memory" )));
alt_sgdma_descriptor rx_descriptor_end  __attribute__ (( section ( ".descriptor_memory" )));

void setup(void)
{
	// Open the sgdma transmit device
	sgdma_tx_dev = alt_avalon_sgdma_open ("/dev/sgdma_tx");
	if (sgdma_tx_dev == NULL) {
		alt_printf ("Error: could not open scatter-gather dma transmit device\n");
	} else alt_printf ("Opened scatter-gather dma transmit device\n");

	// Open the sgdma receive device
	sgdma_rx_dev = alt_avalon_sgdma_open ("/dev/sgdma_rx");
	if (sgdma_rx_dev == NULL) {
		alt_printf ("Error: could not open scatter-gather dma receive device\n");
	} else alt_printf ("Opened scatter-gather dma receive device\n");

	// Set interrupts for the sgdma receive device
	alt_avalon_sgdma_register_callback( sgdma_rx_dev, (alt_avalon_sgdma_callback) rx_ethernet_isr, 0x00000014, NULL );

	// Create sgdma receive descriptor
	alt_avalon_sgdma_construct_stream_to_mem_desc( &rx_descriptor, &rx_descriptor_end, (alt_u32 *)rx_frame, 0, 0 );

	// Set up non-blocking transfer of sgdma receive descriptor
	alt_avalon_sgdma_do_async_transfer( sgdma_rx_dev, &rx_descriptor );

	// Triple-speed Ethernet MegaCore base address
	volatile int * tse = (int *) 0x00102000;

	// Initialize the MAC address
	*(tse + 3) = 0x116E6001;
	*(tse + 4) = 0x00000F02;

	// Specify the addresses of the PHY devices to be accessed through MDIO interface
	*(tse + 0x0F) = 0x10;
	*(tse + 0x10) = 0x11;

	// Write to register 20 of the PHY chip for Ethernet port 0 to set up line loopback
	*(tse + 0x94) = 0x4000;

	// Write to register 16 of the PHY chip for Ethernet port 1 to enable automatic crossover for all modes
	*(tse + 0xB0) = *(tse + 0xB0) | 0x0060;

	// Write to register 20 of the PHY chip for Ethernet port 2 to set up delay for input/output clk
	*(tse + 0xB4) = *(tse + 0xB4) | 0x0082;

	// Software reset the second PHY chip and wait
	*(tse + 0xA0) = *(tse + 0xA0) | 0x8000;
	while ( *(tse + 0xA0) & 0x8000  )
		;

	// Enable read and write transfers, 100 mbit Ethernet operation, and CRC forwarding
	//*(tse + 2) = *(tse + 2) | 0x00000043;

	// Enable read and write transfers, gigabit Ethernet operation, and CRC forwarding
	*(tse + 2) = *(tse + 2) | 0x0000004B;
}

void refresh_ethernet(){
	// Create transmit sgdma descriptor
	//alt_avalon_sgdma_construct_mem_to_stream_desc( &tx_descriptor, &tx_descriptor_end, (alt_u32 *)tx_frame, 62, 0, 1, 1, 0 );

	// Set up non-blocking transfer of sgdma transmit descriptor
	//alt_avalon_sgdma_do_async_transfer( sgdma_tx_dev, &tx_descriptor );

	// Wait until transmit descriptor transfer is complete
	//while (alt_avalon_sgdma_check_descriptor_status(&tx_descriptor) != 0)

}

void rx_ethernet_isr (void *context)
{
	int i;

		// Wait until receive descriptor transfer is complete
		while (alt_avalon_sgdma_check_descriptor_status(&rx_descriptor) != 0)
			;

		// Clear input line before writing
		for (i = 0; i < (6 + text_length); i++) {
			alt_printf( "%c", 0x08 );		 // 0x08 --> backspace
		}
		//alt_printf( "got: %s\n", rx_frame + 16);
		if(rx_frame[2] == 0x69){

			callback(rx_frame);
		}

		alt_avalon_sgdma_construct_mem_to_stream_desc( &tx_descriptor, &tx_descriptor_end, (alt_u32 *)tx_frame, 62, 0, 1, 1, 0 );
		// Create new receive sgdma descriptor
		alt_avalon_sgdma_construct_stream_to_mem_desc( &rx_descriptor, &rx_descriptor_end, (alt_u32 *)rx_frame, 0, 0 );


		// Set up non-blocking transfer of sgdma receive descriptor
		alt_avalon_sgdma_do_async_transfer( sgdma_rx_dev, &rx_descriptor );

		// Output received text
			for(int x = 0; x < 1024; x++){
						rx_frame[x] = 0;
			}
}

void tx_ethernet_isr(char *chars){
			for(int x = 0; x < strlen(chars); x++){
				tx_frame[16 + x] = chars[x];
			}
			// Create transmit sgdma descriptor
			alt_avalon_sgdma_construct_mem_to_stream_desc( &tx_descriptor, &tx_descriptor_end, (alt_u32 *)tx_frame, 62, 0, 1, 1, 0 );
			// Set up non-blocking transfer of sgdma transmit descriptor
			alt_avalon_sgdma_do_async_transfer( sgdma_tx_dev, &tx_descriptor );
			// Wait until transmit descriptor transfer is complete
			while (alt_avalon_sgdma_check_descriptor_status(&tx_descriptor) != 0);

}
