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

# Platform Overrides
PLATFORM = HOST

LINKER_FILE= ../msp432p401r.lds

CPPFLAGs =    \
      	      -I./../include/CMSIS \
	      -I./../include/common \
	      -I./../include/msp432

#Common Flags
FLAGS = -Wall \
	-Werror\
	-g \
	-O0\
	-std=c99
TARGET = c1m2
     
ifeq ($(PLATFORM),HOST)
	CC = gcc
	CFLAGS = $(FLAGS)
	/*CPPFLAGS = -DHOST $(INCLUDES)*/
	LDFLAGS = -Wl,-Map=$(TARGET).map
	SIZE = size
endif

ifeq ($(PLATFORM),MSP432)
	# Architectures Specific Flags
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


OBJS = $(SOURCES:.c=.o)
DEPS = $(SOURCES:.c=.d)
ASMS = $(SOURCES:.c=.asm)
PRES = $(SOURCES:.c=.i)

# using -c flag to stop before linking
%.o : %.c
	$(CC) -c $< $(CPPFLAGS) $(CFLAGS) -o $@

#using -S to generate assembly file
%.asm : %.c
	$(CC) -S $< $(CPPFLAGS) $(CFLAGS) -o $@

#using -E to generate preprocessed file , so i only need CPPFLAGS
%.i : %.c
	$(CC) -E $< $(CPPFLAGS) -o $@

#using -E -M to generate dependency files  
%.d : %.c
	$(CC) -E -M $< $(CPPFLAGS) -o $@

# compile-all will generate all object files for all source files without linking
.PHONY: compile-all
compile-all:$(OBJS)

.PHONY: build
build: $(DEPS)
build: $(TARGET).out

$(TARGET).out: $(OBJS)
	$(CC) $(OBJS) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@
	$(SIZE) $@

.PHONY: clean
clean:
	rm -f $(OBJS) $(DEPS) $(ASMS) $(PRES) $(TARGET).out $(TARGET).map



