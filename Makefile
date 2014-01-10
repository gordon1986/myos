AS   =gas
LD =gld


TOP = .
#o1 means default optmise
#-fno-builtin: no builtin func, you can complete them as you link
#-I$(TOP):header file dir
#-MD:related file *.d
#-fno-omit-frame-pointer: kernel will print frame pointer info when sth. err
#-Wall:show warning info
#-Werror:think warning as erro
#-gstabs: show debug info as stabs no gdb extention
#-m32:for 32bit compile
FLAGS := $(CFLAGS) $(DEFS) $(LABDEFS) -O1 -fno-builtin -I$(TOP)/include -MD
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
