
.globl start
start:
  .code16                     # Assemble for 16-bit mode
  cli                         # Disable interrupts
  cld                         # String operations increment, set si di increase

  # Set up the important data segment registers (DS, ES, SS).
  # Use AT&T assembly
  # Be care for it paramter order
  # ds es ss set to zero
  xorw    %ax,%ax             # Segment number zero
  movw    %ax,%ds             # zero -> Data Segment
  movw    %ax,%es             # zero -> Extra Segment
  movw    %ax,%ss             # zero -> Stack Segment


