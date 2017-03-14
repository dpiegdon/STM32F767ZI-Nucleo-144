#######################################################################
# settings for a simple example project

# Project-specific setup
PROJECT_NAME := blinky
PROJECT_HEAP_SIZE := 0x400
PROJECT_DEFINES = -DHEAP_SIZE=$(PROJECT_HEAP_SIZE)
PROJECT_CFLAGS  =
PROJECT_LDFLAGS =

# Project-specific sources:

# assembly sources
PROJECT_SOURCES_S = $(BSP_CMSIS_PATH)/Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/gcc/startup_stm32f767xx.s

# c and c++ sources
PROJECT_SOURCES_C = src/main.c
PROJECT_SOURCES_CPP =

# stubs and helpers to support/use libnew
PROJECT_SOURCES_C += sys/stubs.c sys/_sbrk.c sys/_io.c

# required CMSIS/BSP/HAL drivers
PROJECT_SOURCES_C += $(BSP_CMSIS_PATH)/Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/system_stm32f7xx.c
PROJECT_SOURCES_C += $(BSP_CMSIS_PATH)/Drivers/BSP/STM32F7xx_Nucleo_144/stm32f7xx_nucleo_144.c
PROJECT_SOURCES_C += $(BSP_CMSIS_PATH)/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_gpio.c

PROJECT_INCLUDES += -I src
PROJECT_INCLUDES += -I $(BSP_CMSIS_PATH)/Drivers/CMSIS/Include
PROJECT_INCLUDES += -I $(BSP_CMSIS_PATH)/Drivers/CMSIS/Device/ST/STM32F7xx/Include
PROJECT_INCLUDES += -I $(BSP_CMSIS_PATH)/Drivers/STM32F7xx_HAL_Driver/Inc
PROJECT_INCLUDES += -I $(BSP_CMSIS_PATH)/Drivers/BSP/STM32F7xx_Nucleo_144

#######################################################################
# EOF
