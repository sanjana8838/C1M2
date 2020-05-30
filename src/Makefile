#******************************************************************************
# Copyright (C) 2017 by Alex Fosdick - University of Colorado
#
# Redistribution, modification or use of this software in source or binary
# forms is permitted as long as the files maintain this copyright. Users are 
# permitted to modify this and use it to learn about the field of embedded
# software. Alex Fosdick and the University of Colorado are not liable for any
# misuse of this material. 
#
#*****************************************************************************

#------------------------------------------------------------------------------
# Makefile for an arm processor
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#     <FILE>.o - object file
#     <FILE>.i - preprocessed file
#     <FILE>.asm - assembly file
#     complie-all - complie all object files (do not link)
#     build - compile all object file and link to final executable
#     clean - remove all compiled file
#
# Platform Overrides:
#      Target Platform: HOST, MSP432
#
#------------------------------------------------------------------------------
include sources.mk

TARGET = c1m2

PLATFORM = HOST

LINKER_FILE= ../msp432p401r.lds



# Platform Overrides

ifeq ($(PLATFORM),HOST)
    PLATFORM=HOST
    CC = gcc
    LDFLAGS = -Wl,-Map=$(TARGET).map  
    CFLAGS = -std=c99 -Werror -Wall -g -O0 $(INCLUDES) -D$(PLATFORM)
   CPPFLAGS = -DHOST $(INCLUDES)
else
#Architectures Specific Flags
	SOURCES = main.c \
		memory.c \
		interrupts_msp432p401r_gcc.c \
		startup_msp432p401r_gcc.c \
	  	system_msp432p401r.c
   CPPFLAGS = -DMSP432 $(INCLUDES)
    PLATFORM=MSP432
    CPU = cortex-m4
    ARCH = thumb
    SPECS = nosys.specs 
    MARCH = armv7e-m
    ABI = hard
    FPU = fpv4-sp-d16
    CC = arm-none-eabi-gcc
    LD = arm-none-eabi-ld
    SIZE = arm-none-eabi-size
    LDFLAGS = -Wl,-Map=$(TARGET).map -T $(LINKER_FILE) 
    CFLAGS = -std=c99 -Werror -mcpu=$(CPU) -m$(ARCH) --specs=$(SPECS) -march=$(MARCH) -mfloat-abi=$(ABI) -mfpu=$(FPU) -Wall -g -O0 $(INCLUDES) -D$(PLATFORM)
endif 



# Compiler Flags and Defines
OBJS = $(SOURCES:.c=.o)
ASM = $(SOURCES:.c=.asm)
I = $(SOURCES:.c=.i)


%.asm : %.c
	$(CC) -c $< $(CPPFLAGs) $(CFLAGS) -S -o $@

%.i : %.c
	$(CC) -c $< $(CPPFLAGs) $(CFLAGS) -E -o $@

%.o : %.c
	$(CC) -c $< $(CPPFLAGs) $(CFLAGS) -o $@


.PHONY: build
build : all

.PHONY: all
all: $(TARGET).out

$(TARGET).out: $(OBJS)
	$(CC) $(OBJS) $(CFLAGS) $(LDFLAGS) -o $@
	


.PHONY: compile-all
compile-all:
	$(CC) $(CFLAGS) $(CPPFLAGs) -D$(PLATFORM) -c $(OBJS:.o=.c) 
	
.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET).out $(TARGET).map $(TARGET).i $(TARGET).asm $(I) $(ASM) $(OBJS)

.PHONY: debug    
debug:
	@echo $(CPPFLAGs)

