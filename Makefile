OBJ=.obj
SRC = ./kernel
SRC_ASM = ./asm
SRC_LIB = ./lib
INCLUDE = ./include
COPY_ME = /boot  

#
# Setting up Compiler
# ---------------------------------------------------------
CC=gcc
AS=nasm
LD=ld
#
# Debug compilation option
# ---------------------------------------------------------
OPT_C= -m32 -O -Wall  -nostdlib -nostartfiles -nodefaultlibs -Wimplicit-function-declaration
OPT_ASM=-s -f elf -w+orphan-labels -o 
#
# Release compilation option 
#--------------------------------------------------------

#
# link option 
#--------------------------------------------------------
OPT_LD=-T link.ld --build-id=none -m elf_i386 -Map map.txt 
#
# Main Targets
#--------------------------------------------------------
all: ${OBJ} kernel.bin

default: ${OBJ} install

build-iso: kernel.bin
	cp -rf kernel.bin isofiles/boot/kernel.bin
	grub-mkrescue -o os.iso isofiles

run-iso:
	qemu-system-i386 -cdrom os.iso

run-bin:
	qemu-system-i386 -kernel kernel.bin

clean: 
	rm -rf .obj/*
	rm -rf kernel.bin 
	rm -rf isofiles/boot/kernel.bin
	rm -rf os.iso
	
${OBJ}: 
	mkdir .obj
	
#
# Compilation directive
#--------------------------------------------------------
kernel.bin: 	${OBJ}/start.o \
                ${OBJ}/main.o \
                ${OBJ}/keyboard.o \
		${OBJ}/resume.o \
		${OBJ}/video.o
	${LD} ${OPT_LD}	-o kernel.bin ${OBJ}/start.o \
					${OBJ}/video.o \
					${OBJ}/keyboard.o \
					${OBJ}/resume.o \
					${OBJ}/main.o
									
#--------------------------------------------------------
${OBJ}/start.o: ${SRC_ASM}/start.asm
	${AS} ${OPT_ASM} ${OBJ}/start.o ${SRC_ASM}/start.asm
#--------------------------------------------------------
${OBJ}/video.o: ${SRC_LIB}/video.c \
		${INCLUDE}/video.h
	${CC} ${OPT_C} -c -o ${OBJ}/video.o -I${INCLUDE} ${SRC_LIB}/video.c 
#--------------------------------------------------------
${OBJ}/resume.o: ${SRC_LIB}/resume.c \
		${INCLUDE}/resume.h
	${CC} ${OPT_C} -c -o ${OBJ}/resume.o -I${INCLUDE} ${SRC_LIB}/resume.c 
#--------------------------------------------------------
${OBJ}/keyboard.o: ${SRC_LIB}/keyboard.c \
		${INCLUDE}/keyboard.h
	${CC} ${OPT_C} -c -o ${OBJ}/keyboard.o -I${INCLUDE} ${SRC_LIB}/keyboard.c 
#--------------------------------------------------------
${OBJ}/main.o:  ${SRC}/main.c \
		${INCLUDE}/video.h
	${CC} ${OPT_C} -c -o ${OBJ}/main.o -I${INCLUDE} ${SRC}/main.c 

