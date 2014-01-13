
# Run 'make V=1' to turn on verbose commands, or 'make V=0' to turn them off.
# We will add @ before a cmd if you turn off verbose, else nothing to do.
ifeq ($(V),1)
override V =
endif
ifeq ($(V),0)
override V = @
endif

# As no override, if V define before, conf is not use
# use -include as there maybe no this config
-include conf/env.mk


# GCCPREFIX -- set it in conf/env.mk
# If no set, check if i386 is supported  
# This Makefile will automatically use the cross-compiler toolchain
# installed as 'i386-jos-elf-*', if one exists.  If the host tools ('gcc',
# 'objdump', and so forth) compile for a 32-bit x86 ELF target, that will
# be detected as well.  If you have the right compiler toolchain installed
# using a different name, set GCCPREFIX explicitly in conf/env.mk

ifndef GCCPREFIX
GCCPREFIX := $(shell if i386-jos-elf-objdump -i 2>&1 | grep '^elf32-i386$$' >/dev/null 2>&1; \
        then echo 'i386-jos-elf-'; \
        elif objdump -i 2>&1 | grep 'elf32-i386' >/dev/null 2>&1; \
        then echo ''; \
        else echo "***" 1>&2; \
        echo "*** Error: Couldn't find an i386-*-elf version of GCC/binutils." 1>&2; \
        echo "*** Is the directory with i386-jos-elf-gcc in your PATH?" 1>&2; \
        echo "*** If your i386-*-elf toolchain is installed with a command" 1>&2; \
        echo "*** prefix other than 'i386-jos-elf-', set your GCCPREFIX" 1>&2; \
        echo "*** environment variable to that prefix and run 'make' again." 1>&2; \
        echo "*** To turn off this error, run 'gmake GCCPREFIX= ...'." 1>&2; \
        echo "***" 1>&2; exit 1; fi)
endif

CC      := $(GCCPREFIX)gcc -pipe
AS      := $(GCCPREFIX)as
AR      := $(GCCPREFIX)ar
LD      := $(GCCPREFIX)ld
OBJCOPY := $(GCCPREFIX)objcopy
OBJDUMP := $(GCCPREFIX)objdump
NM      := $(GCCPREFIX)nm


TOP = .

# O1 means default optmise
# fno-builtin: no builtin func, you can complete them as you link
# I$(TOP):header file dir
# MD:related file *.d
# fno-omit-frame-pointer: kernel will print frame pointer info when sth. err
# Wall:show warning info
# Werror:think warning as erro
# gstabs: show debug info as stabs no gdb extention
# m32:for 32bit compile
CFLAGS := $(CFLAGS) $(DEFS) $(LABDEFS) -O1 -fno-builtin -I$(TOP)/include -MD
CFLAGS += -fno-omit-frame-pointer
CFLAGS += -Wall -Werror -gstabs -m32

CPP =cpp -nostdinc -Iinclude

boot/bootsect.s:    boot/bootsect.S include/linux/config.h
	$(CPP) -traditional boot/bootsect.S -o boot/bootsect.s

boot/bootsect:  boot/bootsect.s
	$(AS) -o boot/bootsect.o boot/bootsect.s
	$(LD) -s -o boot/bootsect boot/bootsect.o

clean:
	rm -f /boot/bootsect.s boot/bootsect
