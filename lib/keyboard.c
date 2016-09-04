
static inline char inb(short port)
{
    char ret;
    asm volatile ( "inb %1, %0"
                   : "=a"(ret)
                   : "Nd"(port) );
    return ret;
}


char getScancode() {
	char c=0;
	do {
		if(inb(0x60)!=c){
			c=inb(0x60);
		if(c>0)
			return c;
		}
	}while(1);
}
