
#include "stm32f7xx_nucleo_144.h"

int main(void)
{
	BSP_LED_Init(LED1);
	BSP_LED_Init(LED2);
	BSP_LED_Init(LED3);

	for(;;)
	{
		BSP_LED_Toggle(LED1);
		for (int j = 0; j < 100000; j++)
			;

		BSP_LED_Toggle(LED2);
		for (int j = 0; j < 100000; j++)
			;

		BSP_LED_Toggle(LED3);
		for (int j = 0; j < 100000; j++)
			;
	}

	return 0;
}
