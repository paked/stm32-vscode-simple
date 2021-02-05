PREFIX=arm-none-eabi-

CC=$(PREFIX)gcc
LD=$(PREFIX)ld

SRCS := $(shell find src -name *.c -or -name *.S)
OBJS := $(addsuffix .o,$(basename $(SRCS)))

CFLAGS ?=-mcpu=cortex-m4 -mthumb -Wall -Werror -O0 -gdwarf-4 -g3
LDFLAGS ?=-nostdlib -nostartfiles -T link.ld

TARGET ?= program.elf

all: clean $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.S
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	rm $(TARGET) $(OBJS) >/dev/null 2>/dev/null || true