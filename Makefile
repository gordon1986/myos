AS   =gas
LD =gld

CPP =cpp -nostdinc -Iinclude

	echo "kkkkkk"
boot/bootsect.s:    boot/bootsect.S include/linux/config.h
	$(CPP) -traditional boot/bootsect.S -o boot/bootsect.s

boot/bootsect:  boot/bootsect.s
	$(AS) -o boot/bootsect.o boot/bootsect.s
	$(LD) -s -o boot/bootsect boot/bootsect.o

echo "hhhhhhahahh"

clean:
	rm -f /boot/bootsect.s boot/bootsect
