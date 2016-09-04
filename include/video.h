#ifndef __VIDEO_H__
#define __VIDEO_H__

#define NOIR  0
#define BLEU  1
#define VERT  2
#define CYAN  2
#define ROUGE 4
#define GRIS 8
#define BLANC 15

#define BG_NOIR  (0<<4)
#define BG_BLEU  (1<<4)
#define BG_VERT  (2<<4)
#define BG_ROUGE (4<<4)


void cls(); //efface l'ecran
void affchar(char caractere); //affiche un caractere a l'ecran a la position suivante
void changecouleur(short couleur); //change l'attribut d'affichage (blanc sur fond noir par defaut
void print(char* chaine); //affiche une chaine de caracteres a l'ecran
void iprint(int number); //affiche une chaine de caracteres a l'ecran
void move_to_next_char();
void move_to_next_line();
void locate(int h, int w);
#endif

