C = gcc
ASM = nasm
CPP = g++
LINK = ld

C_FLAGS = -Wall -std=c99
CPP_FLAGS = -Wall -std=c++23
ASM_FLAGS = -Wall -f elf64

BIN = bin/
STATIC = bin/static/
INT = int/
SRC = src/

default: math cpu
	$(LINK) --shared -o $(BIN)stdlib.so \
		$(STATIC)math.o \
		$(STATIC)cpu.o

math:
	$(ASM) $(ASM_FLAGS) -o $(INT)arithmetic.o $(SRC)arithmetic.asm
	$(ASM) $(ASM_FLAGS) -o $(INT)trig.o $(SRC)trig.asm
	$(ASM) $(ASM_FLAGS) -o $(INT)exp.o $(SRC)exp.asm
	$(LINK) --relocatable -o $(STATIC)math.o \
		$(INT)arithmetic.o $(INT)trig.o $(INT)exp.o

cpu:
	$(ASM) $(ASM_FLAGS) -o $(INT)cpuid.o $(SRC)cpuid.asm
	$(LINK) --relocatable -o $(STATIC)cpu.o \
    		$(INT)cpuid.o