
#include "types.h"
#include "video.h"

void kernel_start(unsigned long magic, unsigned long addr) {
    changecouleur(BG_NOIR |CYAN);
    print("Mon OS\n");
        
	changecouleur(BG_NOIR | BLANC);
        
    print("Entering Infinite loop\n");

	
	while(1);
}

