# Makefile to build and run BrosOS bootloader

# File paths
BOOTLOADER_SRC = bootloader/asm/boot.asm
BOOTLOADER_BIN = bootloader/bootloader.bin

# Tools
NASM = nasm
QEMU = qemu-system-x86_64

.PHONY: all build run clean

all: build run

build:
	$(NASM) -f bin $(BOOTLOADER_SRC) -o $(BOOTLOADER_BIN)

run:
	$(QEMU) -drive format=raw,file=$(BOOTLOADER_BIN)

clean:
	del $(BOOTLOADER_BIN)
