#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

//Code-11 numbers
int patterns[][10] = {
{0,1,0,0,1,1,1,0},
{0,1,0,0,1,1,1,0},


};

// 'barcode', 48x1px
int pixels[] = {0x30, 0xf9, 0x86, 0x61, 0x98, 0x3c};

//Amount of pixels represent 1 bar
int barWidth = 0;

int detectBarWidth(){
	int firstBlackBar = 0;
	int barWidth = 0;
	
     for (int byte : pixels){
		for(int x = 7; x >= 0; x--){
		int bit = ((byte >> x)  & 0x01);
		
		if(bit == 1 && firstBlackBar == 0){
			barWidth++;
		}
		
		if(barWidth > 0 && bit == 0){
			firstBlackBar = 1;
		}
		}
	}
		
	return barWidth;
}

int main()
{
    barWidth = detectBarWidth();
	printf("Detected barwidth to be: %d\n" , barWidth);
	
	int pattern[50];
	int pattern_x = 0;
	
	for (int byte : pixels){
		for(int x = 7; x >= 0; x-=barWidth){
		int bit = ((byte >> x)  & 0x01);
		pattern[pattern_x] = bit;
		printf("%d", bit);
		pattern_x++;
		}
	}
	
	
	int currentdigits = 0;
	int stop = 7;
	int current = 0;
	int match = 1;
		
	while(currentdigits < sizeof(patterns)){
		while(current < stop){
			if(pattern[current] != patterns[currentdigits][current - (currentdigits*8)]){
				match = 0;
				break;
			}
			current++;
		}
		if(match){
			printf("Match for: %d\n", currentdigits);
		}
		stop+=8;
		match = 1;
		currentdigits++;
	}
	
	
	
	
	
    return 0;
}



