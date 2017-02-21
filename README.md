Small example project for STM32F767ZI-Nucleo-144 board using GCC, Make, GDB and st-link or openocd for debugging.

Originally based on https://github.com/ulfen/stm32f7-discovery-blinky.git (thanks to github.com/ulfen!),
the Makefile has been enhanced with many debugging options and simple GDB integration.
It has been stripped to bare minimum when referencing the original CUBE7 package
downloadable from ST at http://www.st.com/en/embedded-software/stm32cubef7.html

Please note: HEAP size is currently fixed to 0x400 by a define in sys/_sbrk.c.



