// Copyright (c) 2025 Pedro Botelho
// All rights reserved

#include "bsp.h"

int main(void) {
    cpu_setup();

    wdt_init(WDT_TIMEOUT_500MS, DISABLE_INTERRUPT);

    while(1) {
        __reset_watchdog();

        // Put your code here...

        cpu_sleep();
    } 
}
