#
# Makefile for kernel like jos kernel.
# This is NOT a complete makefile;
# you must run make in the top-level directory
# where the makefile is located.
#


#mk boot dir
OBJDIRS += boot

BOOT_OBJS := $(OBJDIR)/boot/bootsect.o

$(OBJDIR)/boot/%.o: boot/%.S
	@echo + as $<
	@mkdir -p $(@D)
	$(V)$(CC) -nostdinc $(KERN_CFLAGS) -c -o $@ $<

$(OBJDIR)/boot/boot: $(BOOT_OBJS)
	@echo + ld boot/boot
#	$(V)$(LD) $(LDFLAGS) -N -e start -Ttext 0x7C00 -o $@.out $^
#	$(V)$(OBJDUMP) -S $@.out >$@.asm
#	$(V)$(OBJCOPY) -S -O binary -j .text $@.out $@
#	$(V)perl boot/sign.pl $(OBJDIR)/boot/boot

