#ifndef __VIDEO_H__
#define __VIDEO_H__

#define BLACK  0
#define BLUE  1
#define GREEN  2
#define CYAN  2
#define RED 4
#define GRAY 8
#define WHITE 15

#define BG_BLACK  (0<<4)
#define BG_BLUE  (1<<4)
#define BG_GREEN  (2<<4)
#define BG_RED (4<<4)
#define BG_GRAY (8<<4)
#define BG_WHITE (15<<4)


void cls();
void printchar(char c);
void chg_color(short color);
void print(char* str);
void iprint(int number);
void move_to_next_char();
void move_to_next_line();
void locate(int h, int w);
#endif

