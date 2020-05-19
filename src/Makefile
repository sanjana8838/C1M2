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
# <Put a Description Here>
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#   write a makefile can compile multiple sources files and support two platform targets 
#
# Platform Overrides:
#     PLATFORM=MSP432, the target is cross compiler for MSP432  ;
#     PLATFORM=HOST , the target is native compiler 
#
#------------------------------------------------------------------------------
include sources.mk

TARGET = c1m2

LINKER_FILE= ../msp432p401r.lds

CPPFLAGs =    \
      	      -I./../include/CMSIS \
	      -I./../include/common \
	      -I./../include/msp432

# Platform Overrides

ifeq ($(PLATFORM),HOST)
    PLATFORM=HOST
    CC = gcc
    LDFLAGS = -Wl,-Map=$(TARGET).map  
    CFLAGS = -std=c99 -Werror -Wall -g -O0 -D$(PLATFORM)
else
#Architectures Specific Flags
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
    CFLAGS = -std=c99 -Werror -mcpu=$(CPU) -m$(ARCH) --specs=$(SPECS) -march=$(MARCH) -mfloat-abi=$(ABI) -mfpu=$(FPU) -Wall -g -O0 -D$(PLATFORM)
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
build: $(TARGET).out
$(TARGET).out: $(OBJS)
	$(CC) $(OBJS) $(CFLAGS) $(INCLUDES) $(LDFLAGS) -o $@
	$(SIZE) -Atd $(TARGET).out
	$(SIZE) -Btd $(OBJS)


.PHONY: compile-all
compile-all:
	$(CC) $(CFLAGS) $(CPPFLAGs) -D$(PLATFORM) -c $(OBJS:.o=.c) 
	$(SIZE) -Btd $(OBJS)	
.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET).out $(TARGET).map $(TARGET).i $(TARGET).asm $(I) $(ASM)

.PHONY: debug    
debug:
	@echo $(CPPFLAGs)




