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
#      <Put a description of the supported targets here>
#
# Platform Overrides:
#      <Put a description of the supported Overrides here
#
#------------------------------------------------------------------------------
include sources.mk

# Platform Overrides
PLATFORM = HOST

# Common Flags
FLAGS = -Wall \
	-Werror \
	-g \
	-O0 \
	-std=c99
	
TARGET = C1M2

ifeq ($(PLATFORM), MSP432)
# Architectures Specific Flags
	LINKER_FILE = -T msp432p401r.lds
	CPU = cortex-m4
	ARCH = armv7e-m
	SPECS = nosys.specs
	OTHER_SPECS = -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

	SOURCE = main.c \
		 memory.c \
		 interrupts_msp432p401r_gcc.c \
		 startup_msp432p401r_gcc.c \
		 system_msp432p401r.c
	 
# Compiler Flags and Defines
	CC = arm-none-eabi-gcc
	LINKER_PATH = -L ../
	CPPFLAGS = -DMSP432 $(INCLUDES)
	CFLAGS = $(FLAGS) $(OTHER_SPECS) -mcpu=$(CPU) -march=$(ARCH) --specs=$(SPECS)
	CPPFLAGS = -DHOST $(INCLUDES)
	LDFLAGS = -wl, -MAP=$(TARGET).map, $(LINKER_PATH) $(LINKERFILE)
	SIZE = size
endif


ifeq ($(PLATFORM), HOST)
# Compiler Flags and Defines
	CC = gcc
	CFLAGS = $(FLAGS)
	CPPFLAGS = -DHOST $(INCLUDES)
	LDFLAGS = -Wl, -Map=$(TARGET).map
	SIZE = size
endif


OBJS = $(SOURCES: .c=.o)
DEPS = $(SOURCES: .c=.d)
ASMS = $(SOURCES: .c=.asm)
PRES = $(SOURCES: .c=.i)

# using -c flag to stop before linking
%.o : %.c
	$(CC) -c $< $(CPPFLAGS) $(CFLAGS) -o $@
	
# using -S to generate assembly file
%.asm : %.c
	$(CC) -S $< $(CPPFLAGS) $(CFLAGS) -o $@

# using -E to generate preprocessed file
%.i : %.c
	$(CC) -E $< $(CPPFLAGS) -o $@
	
# using -E -M to generate dependency files
%.d : %.c
	$(CC) -E -M $< $(CPPFLAGS) -o $@
	
#compile-all will generate all object files for all source files without linking
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

