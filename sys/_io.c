
#include "stm32f7xx_nucleo_144.h"

volatile int32_t ITM_RxBuffer;

int __io_putchar(int ch)
{
    return ITM_SendChar(ch);
}

int __io_getchar(void)
{
    return ITM_ReceiveChar();
}
