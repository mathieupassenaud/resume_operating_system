#include "video.h"
#include "keyboard.h"
#include "resume.h"

void buildFrame();
void civil();
void interests();
void education();

void kernel_start(unsigned long magic, unsigned long addr) {
	cls();
	chg_color(BG_WHITE |CYAN);
	print("Mon OS\n");
	chg_color(BG_WHITE | BLACK);
	firstPart();
	getScancode();
	secondPart();
	while(1);
}


