PREFIX=$(shell echo ~/.comp2300)/arm-none-eabi/bin/arm-none-eabi-

CC=$(PREFIX)gcc
LD=$(PREFIX)ld
OBJCOPY=$(PREFIX)objcopy

SRCS := $(shell find src lib -name '*.c' -or -name '*.S')
OBJS := $(addsuffix .o,$(basename $(SRCS)))

CFLAGS ?=-nostdlib -nostartfiles -mcpu=cortex-m4 -mthumb -Wall -Werror -g
LDFLAGS ?=-nostdlib -nostartfiles -T lib/link.ld

TARGET ?= program.elf

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.S
	$(CC) $(CFLAGS) -o $@ -c $<

upload: $(TARGET)
	$(OBJCOPY) -O binary $(TARGET) program.bin
	st-flash write program.bin 0x20000000

clean:
	rm $(TARGET) $(OBJS) >/dev/null 2>/dev/null || true