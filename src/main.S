.syntax unified
.global main

.type main, %function
main:
  nop
  ldr r0, =hello

  b main
.size main, .-main

.data
hello:
.word 0x424242