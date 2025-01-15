## Copyright (c) 2025 Pedro Botelho
## All rights reserved

## General
CC = avr-gcc
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
AVRDUDE = avrdude
MCU = atmega328p

## Compilation options
CFLAGS = -Iinc -I$(BSP_INC) -Os -std=gnu99 -Wall -Wl,-Tbsp/src/memory.lds
LDFLAGS = $(CFLAGS) -Wl,-Map,obj/app.map -Wl,-e,_start -nostartfiles
TARGET_MCU = -mmcu=$(MCU)
BSP = $(BSP_INC)/bsp.h
BSP_INC = bsp/inc

AVRBSP = libavrbsp.a
AVRBSP_LIB = avrbsp
AVRBSP_LIB_PATH = bsp/lib

GCC_LIB = gcc
GCC_LIB_PATH = ~/.platformio/packages/toolchain-atmelavr/lib/gcc/avr/7.3.0/

## Programmer options
PROGRAMMER_TYPE = -c arduino
PROGRAMMER_PORT = -P /dev/ttyUSB0 -b 115200

.PHONY: build upload clean distclean dump

all: build upload

$(AVRBSP):
	$(MAKE) -C bsp

build: obj/ bin/ $(AVRBSP) obj/app.elf bin/app.hex

obj/app.elf: obj/main.o
	$(CC) $(LDFLAGS) $(TARGET_MCU) $^ -o $@ -L$(AVRBSP_LIB_PATH) -l$(AVRBSP_LIB) -L$(GCC_LIB_PATH) -l$(GCC_LIB) -lc -lm

bin/app.hex: obj/app.elf
	$(OBJCOPY) -O ihex $< $@

obj/%.o: src/%.c $(BSP)
	$(CC) $(CFLAGS) $(TARGET_MCU) -c $< -o $@

upload: bin/app.hex
	$(AVRDUDE) $(PROGRAMMER_TYPE) -p $(MCU) $(PROGRAMMER_PORT) -D -U flash:w:$<:i

dump: obj/dump.txt

obj/dump.txt: obj/app.elf
	$(OBJDUMP) -D $< > $@

%/:
	mkdir -p $@

clean:
	rm obj/* bin/*

distclean: clean
	rmdir obj bin
	$(MAKE) -C bsp clean

