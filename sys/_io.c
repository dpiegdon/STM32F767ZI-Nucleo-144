/*
 * Use the Instrumentation Trace Macrocell debugging
 * feature to send printf-like output to debugger.
 *
 * This is available on MCUs based on Cortex-M3, M4 and M7.
 * Among them:
 *	STM32F1		STM32L1
 *	STM32F2
 *	STM32F3
 *	STM32F4		STM32L4
 *	STM32F7				STM32H7
 */

#if (defined STM32L1)
//  Cortex-M3 device
#   include <stm32l1xx.h>
#elif (defined STM32F1)
//  Cortex-M3 device
#   include <stm32f1xx.h>
#elif (defined STM32F2)
//  Cortex-M3 device
#   include <stm32f2xx.h>
#elif (defined STM32L4)
//  Cortex-M4 device
#   include <stm32l4xx.h>
#elif (defined STM32F3)
//  Cortex-M4 device
#   include <stm32f3xx.h>
#elif (defined STM32F4)
//  Cortex-M4 device
#   include <stm32f4xx.h>
#elif (defined STM32F7)
//  Cortex-M7 device
#   include <stm32f7xx.h>
#elif (defined STM32H7)
//  Cortex-M7 device
#   include <stm32h7xx.h>
#endif

#if (defined STM32L1) || (defined STM32F1) || (defined STM32F2) || (defined STM32L4) || (defined STM32F3) || (defined STM32F4) || (defined STM32F7) || (defined STM32H7)

#pragma GCC diagnostic ignored "-Wunused-parameter"

volatile int32_t ITM_RxBuffer;

int __io_putchar(int ch)
{
	return ITM_SendChar(ch);
}

int __io_getchar(void)
{
	return ITM_ReceiveChar();
}

#else

int __io_putchar(int ch)
{
	// FIXME
	return 0xff;
}

int __io_getchar(void)
{
	// FIXME
	return 0xff;
}

#endif

