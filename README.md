<!-- vim: fo=a tw=80 colorcolumn=80 syntax=markdown :
-->

STM32F767ZI-Nucleo-144 board example project
============================================

Small example project for STM32F767ZI-Nucleo-144 board using the
hackers choice of tools:

* GCC

* GNU Make

* GDB and one of ST-Link or OpenOCD for debugging and flashing

Originally based on https://github.com/ulfen/stm32f7-discovery-blinky.git
(thanks to http://github.com/ulfen!), the Makefile has been enhanced with
additional debugging options and simple GDB integration.

The sources and Makefile have been stripped to bare minimum by referencing the
original CUBE7 package downloadable from ST.



Usage
-----

* You need to download the CUBE F7 zip from ST and set the correspondig
environment variable or fix the Makefile (see Notes and pointers).

* The setup is optimized for debugging and GDB integration. Thus, it uses `-O0
-g -gdwarf2` to allow remote debugging. For production use, you might want to
change `DEBUG_OPTIMIZE_FLAGS` to `-O2`.

* HEAP SIZE is currently fixed to 0x400 (in the Makefile). For a larger heap,
fix this. It is used in `sys/_sbrk.c`. A better solution would be to create an
appropriate linker script that defines the value for `HEAP_SIZE`, just like it
currently defines the start of the heap as `_end`.



Notes and pointers
------------------

### Tools

* STM32 CUBEF7 package - http://www.st.com/en/embedded-software/stm32cubef7.html

* GNU ARM Embedded Toolchain - https://launchpad.net/gcc-arm-embedded

* ST-Link tool for linux - https://github.com/texane/stlink

* OpenOCD (you probably will need version 0.10.0 or higher for STM32F7xx
support) - http://openocd.org/

### Documentation

* STM32F767ZI documentation, especially the Reference Manual, the Programming
Manual and the DataSheet -
http://www.st.com/en/microcontrollers/stm32f767zi.html

* STM32F767ZI-Nucleo-144 documentation, especially the User Manual and the
Schematic Packs -
http://www.st.com/content/st_com/en/products/evaluation-tools/product-evaluation-tools/mcu-eval-tools/stm32-mcu-eval-tools/stm32-mcu-nucleo/nucleo-f767zi.html

* GCC linker scripts - https://sourceware.org/binutils/docs-2.27/ld/Scripts.html

* NewLib, the provided libc - https://sourceware.org/newlib/

* GDB command documentation - https://sourceware.org/gdb/onlinedocs/gdb/ --
`load` to flash firmware, `kill` to stop execution of currently running
application, `run` to start execution.

* ARM documentation for delwing really deep into the subject - ARMv7-M
Architecture Reference Manual and ARM Cortex-M7 Processor Technical Reference
Manual and the ARM and Thumb-2 InstructionSet QuickRefCard



Authors
-------

(alphabetically)

* David R. Piegdon <dgit@piegdon.de>

* Liviu Ionescu (`sys/_sbrk.c` via GNU ARM Eclipse Plug-in)

* ST Microelectronic (example `src/stm32f7xx_hal_conf.h`)

* Ulfen ( http://github.com/ulfen/ )



Prior Art
---------

* original version which this is based on, for a slightly different board:
https://github.com/ulfen/stm32f7-discovery-blinky.git

* ChibiOS has an example for many different boards, including this one:
http://chibios.org/

* plenty of howtos and guides when searching for `gcc gdb stm32 gnu make`

