#######################################################################
# Makefile for STM32F767 NUCLEO144 board projects

PROJECT = blinky
CMSIS_PATH ?= STM32Cube_FW_F7
OPENOCD_SCRIPT_DIR ?= /usr/share/openocd/scripts
HEAP_SIZE = 0x1000

################
# Sources

SOURCES_S = ${CMSIS_PATH}/Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/gcc/startup_stm32f767xx.s

SOURCES_C = src/app_ethernet.c src/ethernetif.c src/httpserver-netconn.c src/main.c src/stm32f7xx_hal_timebase_tim.c src/stm32f7xx_it.c src/system_stm32f7xx.c

SOURCES_C += sys/stubs.c sys/_sbrk.c sys/_io.c
SOURCES_C += ${CMSIS_PATH}/Drivers/BSP/STM32F7xx_Nucleo_144/stm32f7xx_nucleo_144.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_cortex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dma2d.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dma.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dsi.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_eth.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_gpio.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_i2c.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_i2c_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_ltdc.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_ltdc_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_sdram.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_tim.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_tim_ex.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_uart.c
SOURCES_C += ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_ll_fmc.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS/cmsis_os.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/croutine.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/list.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1/port.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/queue.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/tasks.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/timers.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/api/api_lib.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/api/api_msg.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/api/err.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/api/netbuf.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/api/netdb.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/api/netifapi.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/api/sockets.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/api/tcpip.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/apps/httpd/fs.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/apps/httpd/httpd.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/def.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/dns.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/inet_chksum.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/init.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/ip.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/ipv4/autoip.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/ipv4/dhcp.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/ipv4/etharp.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/ipv4/icmp.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/ipv4/igmp.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/ipv4/ip4_addr.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/ipv4/ip4.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/ipv4/ip4_frag.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/mem.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/memp.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/netif.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/pbuf.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/raw.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/stats.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/sys.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/tcp.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/tcp_in.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/tcp_out.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/timeouts.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/core/udp.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/netif/ethernet.c
SOURCES_C += ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/system/OS/sys_arch.c

SOURCES_CPP =

SOURCES = $(SOURCES_S) $(SOURCES_C) $(SOURCES_CPP)
OBJS = $(SOURCES_S:.s=.o) $(SOURCES_C:.c=.o) $(SOURCES_CPP:.cpp=.o)

################
# Includes and Defines

INCLUDES += -I src
INCLUDES += -I ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/include
INCLUDES += -I ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/system
INCLUDES += -I ${CMSIS_PATH}/Drivers/STM32F7xx_HAL_Driver/Inc
INCLUDES += -I ${CMSIS_PATH}/Drivers/CMSIS/Device/ST/STM32F7xx/Include
INCLUDES += -I ${CMSIS_PATH}/Drivers/CMSIS/Include
INCLUDES += -I ${CMSIS_PATH}/Drivers/BSP/STM32F7xx_Nucleo_144
INCLUDES += -I ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS
INCLUDES += -I ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/include
INCLUDES += -I ${CMSIS_PATH}/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1
INCLUDES += -I ${CMSIS_PATH}/Middlewares/Third_Party/LwIP/src/apps/httpd

DEFINES = -DSTM32 -DSTM32F7 -DSTM32F767xx -DHTTPD_USE_CUSTOM_FSDATA=1

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

DEBUG_OPTIMIZE_FLAGS = -O0 -g -gdwarf-5
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
