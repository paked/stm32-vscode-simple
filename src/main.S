.syntax unified
.global main

.type main, %function
main:
  nop
  b main
.size main, .-main