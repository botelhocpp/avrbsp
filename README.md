# AVR BSP (Board Support Package)

Drivers made for the AVR ATmega328P microcontroller to facilitate development.

## Library Components:

The library has almost every important configuration needed for the MCU development. 

### Low Level Setup

- memory.lds: Linker script for the memory configuration
- start.s: The startup code and the vector table

### Definitions

- atmega328p.h: The register definitions of the MCU.
- bsp.h: The main header of the BSP, includes all main peripherals
- vectors.h: Interrupt vector definitions

### Peripherals

- adc.h and adc.c: 10-bit A/D Converter
- cpu.h and cpu.c: Power-related functionalities (e.g. sleep)
- eeprom.h and eeprom.c: Internal EEPROM
- gpio.h and gpio.c: I/O ports
- interrupt.h and interrupt.c: External and Pin Change interrupts
- pin.h and pin.c: Pin definitions for the board
- spi.h and spi.c: SPI protocol
- timer.h and timer.c: Timers 0, 1 and 2
- twi.h and twi.c: TWI (the Atmel I2C) protocol
- usart.h and usart.c: U(S)ART protocol
- utils.h and utils.c: Utilitary functions (map, delay)
- wdt.h and wdt.c: Watchdog Timer

### Devices

- buzzer.h and buzzer.c: Controls a Buzzer using Timers
- lcd.h and lcd.c: Controls a 16x2 LCD using TWI
- ntc.h and ntc.c: Converts NTC sensor readings
- rtc.h and rtc.c: Controls a DS3231 RTC using TWI
- servo.h and servo.c: Controls a Servo using Timer 1

## How to

Firstly make sure you have the ```bsp``` folder in your project, which contains the avrbsp library. Then, include the main header in your code:

```
#include "bsp.h
```

If you want another component that isn't native to the AVR (e.g. servo) you have to include it as well:

```
#include "servo.h
```

Then, call the Makefile of the ```bsp``` folder inside the main Makefile to generate the static library (you can build and link manually if you want):

```
$make -C bsp
```

And link it to your project, placing the following at the end of the linker command:

```
 -Lbsp/lib -lavrbsp -L$(LIB_GCC_PATH) -lgcc -lc -lm
```

Or you can just use the template of this repository if you want. Simply put your code and add your files to the Makefile, and hit ```make```.

Have fun!
