#######################################################################
# Generic Makefile for STM32 MCU projects

# XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX
# XXX     this generic Makefile should not require any    XXX
# XXX changes. all your changes should go into project.mk XXX
# XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX XXX

################
# Import specific settings

# load host-specifics
include host.mk

# load hardware-specifics
include hardware.mk

# load project-specifics
include project.mk

# these includes are expected to setup all
# MCU, BSP, HOST and project-specific settings.

# these are in specific:

#MCU_DEFINES MCU_CFLAGS MCU_LDFLAGS

#BSP_DEFINES BSP_CFLAGS BSP_LDFLAGS
#BSP_CMSIS_PATH BSP_CMSIS_DESCRIPTIONS
#BSP_TARGET_ADDRESS BSP_TARGET_OPENOCD_FLAGS

#PROJECT_NAME
#PROJECT_DEFINES PROJECT_CFLAGS PROJECT_LDFLAGS
#PROJECT_SOURCES_S PROJECT_SOURCES_C PROJECT_SOURCES_CPP PROJECT_INCLUDES 

#PREFER_STLINK (set to 0 or 1)

# also it may override the following:

#PREFIX OPENOCD_SCRIPT_DIR DEBUG_OPTIMIZE_FLAGS

################
# Collect sources and target files

SOURCES_S = $(PROJECT_SOURCES_S)
SOURCES_C = $(PROJECT_SOURCES_C)
SOURCES_CPP = $(PROJECT_SOURCES_CPP)
INCLUDES = $(PROJECT_INCLUDES)

SOURCES = $(SOURCES_S) $(SOURCES_C) $(SOURCES_CPP)
OBJS = $(SOURCES_S:.s=.o) $(SOURCES_C:.c=.o) $(SOURCES_CPP:.cpp=.o)

################
# Generic binaries and paths

PREFIX ?= arm-none-eabi

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
STLINK_UTIL=st-util
OPENOCD=openocd
OPENOCD_SCRIPT_DIR ?= /usr/share/openocd/scripts

################
# Generic toolchain options

#DEBUG_OPTIMIZE_FLAGS ?= -O2
DEBUG_OPTIMIZE_FLAGS ?= -O0 -g -gdwarf-2

LOWFOOTPRINT_FLAGS := -nostartfiles -nodefaultlibs -nostdlib -fdata-sections -ffunction-sections

CFLAGS = -std=c11 -Wall -Wextra --pedantic -Wa,-aghlms=$(<:%.c=%.lst) -fstack-usage
CFLAGS += $(DEBUG_OPTIMIZE_FLAGS) $(LOWFOOTPRINT_FLAGS)
CFLAGS += $(MCU_CFLAGS) $(BSP_CFLAGS) $(PROJECT_CFLAGS)
CFLAGS += $(MCU_DEFINES) $(BSP_DEFINES) $(PROJECT_DEFINES)
CFLAGS += $(INCLUDES)

LDFLAGS = -static
LDFLAGS += -Wl,--start-group -lgcc -lm -lc -lg -lstdc++ -lsupc++ -Wl,--end-group
LDFLAGS += -Wl,--gc-sections -Wl,--print-gc-sections -Wl,--cref,-Map=$(@:%.elf=%.map)
LDFLAGS += $(MCU_LDFLAGS) $(BSP_LDFLAGS) $(PROJECT_LDFLAGS)

################
# Phony rules

.PHONY: all clean flash erase check_cube_exists

all: check_cube_exists $(PROJECT_NAME).bin $(PROJECT_NAME).hex $(PROJECT_NAME).asm

clean:
	$(RM) $(OBJS) $(OBJS:$.o=$.lst) $(OBJS:$.o=$.su) $(PROJECT_NAME).elf $(PROJECT_NAME).bin $(PROJECT_NAME).hex $(PROJECT_NAME).map $(PROJECT_NAME).asm

flash: $(PROJECT_NAME).bin
	st-flash write $(PROJECT_NAME).bin $(BSP_TARGET_ADDRESS)

erase:
	st-flash erase

check_cube_exists:
	@if ! test -e $(BSP_CMSIS_PATH); then echo 'please download and extract or symlink $(BSP_CMSIS_DESCRIPTIONS) to $(BSP_CMSIS_PATH)'; false; fi

gdb-server:
ifeq ($(PREFER_STLINK),1)
	# st-util will listen on port :3333 (default was 4242)
	$(STLINK_UTIL) -p 3333
else
	# openocd will listen on port :3333
	$(OPENOCD) -s $(OPENOCD_SCRIPT_DIR) $(BSP_TARGET_OPENOCD_FLAGS)
endif

gdb: $(PROJECT_NAME).elf
	$(GDB) --eval-command="target extended-remote localhost:3333" --eval-command="monitor halt" $(PROJECT_NAME).elf

################
# Dependency graphs for wildcard rules

$(PROJECT_NAME).elf: $(OBJS)

################
# Wildcard rules

%.elf:
	$(LD) $(OBJS) $(LDFLAGS) -o $@
	$(SIZE) -A $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

%.hex: %.elf
	$(OBJCOPY) -O ihex $< $@

%.asm: %.elf
	$(OBJDUMP) -dgCxw $< > $@

#######################################################################
# EOF
