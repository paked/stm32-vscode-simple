PREFIX=arm-none-eabi-

CC=$(PREFIX)gcc
LD=$(PREFIX)ld
OBJCOPY=$(PREFIX)objcopy

SRCS := $(shell find src -name *.c -or -name *.S)
OBJS := $(addsuffix .o,$(basename $(SRCS)))

CFLAGS=-mcpu=cortex-m4 -mthumb -Wall -Werror -O0 -gdwarf-4 -g3
LDFLAGS=-nostdlib -nostartfiles -T link.ld

program.elf: $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.S
	$(CC) $(CFLAGS) -o $@ -c $<
