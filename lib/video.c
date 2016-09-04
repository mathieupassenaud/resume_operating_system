#include "video.h"
#include "types.h"
//
// Constant
//-----------------------------------------------
#define start_video_mem 0xB8000
#define width   80
#define lines    25
//
// Structure to access directly to the video mem
//-----------------------------------------------
typedef struct {
    unsigned char caractere;
    unsigned char attr;
} __attribute__ ((packed)) video_mem[width*lines];

// Make the structure point to the good address
//-----------------------------------------------
static volatile video_mem *ecran = (volatile video_mem *)start_video_mem;

// Global vars
//-----------------------------------------------

static short aff= BG_NOIR | BLANC;
static int x, y = 0;

//
// CLS : Clear the screen
//-----------------------------------------------
void cls(){

	long i;
	
	for(i=0;i<width*lines;++i){
	    (*ecran)[i].caractere=0;
	    (*ecran)[i].attr=aff;
	}
}

//
// affchar : Display character at current position
//------------------------------------------------
void affchar(char caractere){
        long offset = x+y*width;
	(*ecran)[offset].caractere =caractere ;
	(*ecran)[offset].attr = aff; 

}

//
// move_to_next_char : move current position to 
// next char
//------------------------------------------------
void move_to_next_char(){

   if(++x == width){
      move_to_next_line();
   }   

}
//
// move_to_next_line : move current position to 
// next line
//------------------------------------------------
void move_to_next_line(){
      x=0;
      if(++y == lines){
        long i;
	// Copy the screen one line before
      	for(i=0;i<width*(lines-1);++i){
	    (*ecran)[i].caractere=(*ecran)[i+width].caractere;
	    (*ecran)[i].attr=(*ecran)[i+width].attr;
	}
	// Empty last line
	for(;i<width*lines;++i){
	    (*ecran)[i].caractere=0;
	    (*ecran)[i].attr=aff;
	}
      }
}

//
// Print
//------------------------------------------------
void print(char* chaine){
	char* pt; /* pointeur sur la chaine de caractere */
	pt = chaine;
	while(*pt!=0x0){ /* tant que le caractere est different de 0x0 */
	        if(*pt == '\n'){
		   	move_to_next_line();   
		}else if (*pt == '\t'){  
			move_to_next_char();
			move_to_next_char();
			move_to_next_char();
			move_to_next_char();
			move_to_next_char();
		}else if (*pt == '\r'){
			x=0;
		}else{
			affchar(*pt);
			move_to_next_char();
		}		
		pt++;
	}
}
//
// iPrint
//------------------------------------------------
void iprint(int number){
	char str[256]; 
	int i=256;
	if(number == 0 ){
	   print("0");
	   return;
	}
	str[i--]=0;
	
	while(number > 0 ){
	  str[i--]='0'+(number%10);
	  number/=10;	   
	}
	print(str+i+1);
	return;
}
//
// Modify the current attributes
//------------------------------------------------
void changecouleur(short couleur){
		aff=couleur;
}
//
// locate on the screen
//
void locate(int h, int w){
	x=h;
	y=w;
}


