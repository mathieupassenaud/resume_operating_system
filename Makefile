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
OPT_C= -O -Wall  -nostdlib -nostartfiles -nodefaultlibs 
OPT_ASM=-s -f elf -w+orphan-labels -o
#
# Release compilation option 
#--------------------------------------------------------

#
# link option 
#--------------------------------------------------------
OPT_LD=-T link.ld --oformat=elf32-i386  -Map map.txt 
#
# Main Targets
#--------------------------------------------------------
all: ${OBJ} kernel.bin

default: ${OBJ} install

install: kernel.bin
	cp -rf kernel.bin ${COPY_ME}	
clean: 
	rm -rf .obj/*
	rm -rf kernel.bin 
	
${OBJ}: 
	mkdir .obj
	
#
# Compilation directive
#--------------------------------------------------------
kernel.bin: 	${OBJ}/start.o \
                ${OBJ}/main.o \
		${OBJ}/video.o
	${LD} ${OPT_LD}	-o kernel.bin ${OBJ}/start.o \
					${OBJ}/video.o \
					${OBJ}/main.o
#										
#--------------------------------------------------------
${OBJ}/start.o: ${SRC_ASM}/start.asm
	${AS} ${OPT_ASM} ${OBJ}/start.o ${SRC_ASM}/start.asm
#--------------------------------------------------------
${OBJ}/video.o: ${SRC_LIB}/video.c \
		${INCLUDE}/types.h \
		${INCLUDE}/video.h
	${CC} ${OPT_C} -c -o ${OBJ}/video.o -I${INCLUDE} ${SRC_LIB}/video.c 
#--------------------------------------------------------
${OBJ}/main.o:  ${SRC}/main.c \
		${INCLUDE}/types.h \
		${INCLUDE}/video.h
	${CC} ${OPT_C} -c -o ${OBJ}/main.o -I${INCLUDE} ${SRC}/main.c 



