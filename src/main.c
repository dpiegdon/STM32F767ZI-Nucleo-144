
#include "stm32f7xx_nucleo_144.h"

int main(void)
{
	int i = 0;

	BSP_LED_Init(LED_GREEN);

	for(;;)
	{
		BSP_LED_Toggle(LED_GREEN);

		for (int j = 0; j < 1000000; j++)
			;

		printf("Hello, world! -- %i\n", i++);
	}

	return 0;
}
