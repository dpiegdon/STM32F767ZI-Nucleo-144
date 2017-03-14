#######################################################################
# settings for STM32F767 NUCLEO144 board

# MCU-specific setup
MCU_DEFINES  = -DSTM32 -DSTM32F7 -DSTM32F767xx
MCU_CFLAGS   = -mlittle-endian -mthumb -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-sp-d16
MCU_LDFLAGS  = $(MCU_CFLAGS)

# BSP-specific setup
BSP_DEFINES  =
BSP_CFLAGS   =
BSP_LDFLAGS  = -L $(BSP_CMSIS_PATH)/Projects/STM32F767ZI-Nucleo/Demonstrations/SW4STM32/STM32767ZI_Nucleo/ -T STM32F767ZITx_FLASH.ld
BSP_CMSIS_PATH ?= STM32Cube_FW_F7
BSP_CMSIS_DESCRIPTIONS := "STM32-CUBE-F7 pack (version >= 1.6.0)"
BSP_TARGET_ADDRESS = 0x08000000
BSP_TARGET_OPENOCD_FLAGS = -f interface/stlink-v2-1.cfg -f target/stm32f7x.cfg

#######################################################################
# EOF
