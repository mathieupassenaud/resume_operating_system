[extern kernel_start]
[global kernel_stack]

[global main]

STACKSIZE equ 0x4000 ; taille de la pile

[section .text]
align 4
main:
 mov esp, kernel_stack + STACKSIZE
 mov eax, kernel_start
 jmp eax

[section .bss]
align 32
kernel_stack:
 resb STACKSIZE ; ici on aura la pile
