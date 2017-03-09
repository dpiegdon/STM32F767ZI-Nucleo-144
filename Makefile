#######################################################################
# Makefile for STM32F767 NUCLEO144 board projects

PROJECT = blinky
CMSIS_PATH ?= STM32Cube_FW_F7
OPENOCD_SCRIPT_DIR ?= /usr/share/openocd/scripts
HEAP_SIZE = 0x1000

################
# Sources

SOURCES_S = ${CMSIS_PATH}/Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/gcc/startup_stm32f767xx.s

SOURCES_C = src/main.c src/stm32f7xx_it.c src/system_stm32f7xx.c src/usbd_conf.c src/usbd_desc.c

SOURCES_C += sys/stubs.c sys/_sbrk.c sys/_io.c
SOURCES_C += ${CMSIS_PATH}/Drivers/BSP/STM32F7xx_Nucleo_144/stm32f7xx_nucleo_144.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_adc.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_adc_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_cortex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dma.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_gpio.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_hcd.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_i2c.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pcd.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pcd_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_sdram.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_spi.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_sram.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_uart.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_ll_fmc.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_ll_usb.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/ST/STM32_USB_Device_Library/Class/HID/Src/usbd_hid.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_core.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ioreq.c

SOURCES_CPP =

SOURCES = $(SOURCES_S) $(SOURCES_C) $(SOURCES_CPP)
OBJS = $(SOURCES_S:.s=.o) $(SOURCES_C:.c=.o) $(SOURCES_CPP:.cpp=.o)

################
# Includes and Defines

INCLUDES += -I src
INCLUDES += -I ${CMSIS_PATH}/Drivers/CMSIS/Include
INCLUDES += -I ${CMSIS_PATH}/Drivers/CMSIS/Device/ST/STM32F7xx/Include
INCLUDES += -I ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Inc
INCLUDES += -I ${CMSIS_PATH}/Drivers/BSP/STM32F7xx_Nucleo_144
INCLUDES += -I ${CMSIS_PATH}/Middlewares/ST/STM32_USB_Device_Library/Core/Inc
INCLUDES += -I ${CMSIS_PATH}/Middlewares/ST/STM32_USB_Device_Library/Class/HID/Inc

DEFINES = -DSTM32 -DSTM32F7 -DSTM32F767xx

################
# Compiler/Assembler/Linker/etc

PREFIX = arm-none-eabi

CC = $(PREFIX)-gcc
AS = $(PREFIX)-as
AR = $(PREFIX)-ar
LD = $(PREFIX)-gcc
NM = $(PREFIX)-nm
OBJCOPY = $(PREFIX)-objcopy
OBJDUMP = $(PREFIX)-objdump
READELF = $(PREFIX)-readelf
SIZE = $(PREFIX)-size
GDB = $(PREFIX)-gdb
RM = rm -f
OPENOCD=openocd

################
# Compiler options

MCUFLAGS = -mcpu=cortex-m7 -mlittle-endian
MCUFLAGS += -mfloat-abi=hard -mfpu=fpv5-sp-d16
MCUFLAGS += -mthumb

DEBUG_OPTIMIZE_FLAGS = -O0 -g -gdwarf-2
#DEBUG_OPTIMIZE_FLAGS = -O2

CFLAGS = -std=c11
CFLAGS += -Wall -Wextra --pedantic
# generate listing files
CFLAGS += -Wa,-aghlms=$(<:%.c=%.lst)
CFLAGS += -DHEAP_SIZE=$(HEAP_SIZE)
CFLAGS += -fstack-usage

CFLAGS_EXTRA = -nostartfiles -nodefaultlibs -nostdlib
CFLAGS_EXTRA += -fdata-sections -ffunction-sections

CFLAGS += $(DEFINES) $(MCUFLAGS) $(DEBUG_OPTIMIZE_FLAGS) $(CFLAGS_EXTRA) $(INCLUDES)

LDFLAGS = -static $(MCUFLAGS)
LDFLAGS += -Wl,--start-group -lgcc -lm -lc -lg -lstdc++ -lsupc++ -Wl,--end-group
LDFLAGS += -Wl,--gc-sections -Wl,--print-gc-sections -Wl,--cref,-Map=$(@:%.elf=%.map)
LDFLAGS += -L ${CMSIS_PATH}/Projects/STM32F767ZI-Nucleo/Demonstrations/SW4STM32/STM32767ZI_Nucleo/ -T STM32F767ZITx_FLASH.ld

################
# phony rules

.PHONY: all clean flash erase check_cube_exists

all: check_cube_exists $(PROJECT).bin $(PROJECT).hex $(PROJECT).asm

clean:
	$(RM) $(OBJS) $(OBJS:$.o=$.lst) $(OBJS:$.o=$.su) $(PROJECT).elf $(PROJECT).bin $(PROJECT).hex $(PROJECT).map $(PROJECT).asm

flash: $(PROJECT).bin
	st-flash write $(PROJECT).bin 0x08000000

erase:
	st-flash erase

check_cube_exists:
	if ! test -e ${CMSIS_PATH}; then echo 'please download and extract or symlink the STM32-CUBE-F7 pack (>= 1.6.0) to ${CMSIS_PATH}'; false; fi

GDB_PORT:=4242
gdb-server:
	# st-util will listen on port :4242
	st-util
	# openocd will listen on port :3333
	#$(OPENOCD) -f $(OPENOCD_SCRIPT_DIR)/interface/stlink-v2-1.cfg -f $(OPENOCD_SCRIPT_DIR)/target/stm32f7x.cfg

gdb: $(PROJECT).elf
	$(GDB) --eval-command="target extended-remote localhost:$(GDB_PORT)" --eval-command="monitor halt" $(PROJECT).elf

################
# dependency graphs for wildcard rules

$(PROJECT).elf: $(OBJS)

################
# wildcard rules

%.elf:
	$(LD) $(OBJS) $(LDFLAGS) -o $@
	$(SIZE) -A $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

%.hex: %.elf
	$(OBJCOPY) -O ihex $< $@

%.asm: %.elf
	$(OBJDUMP) -dgCxw $< > $@

# EOF
