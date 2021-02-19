This directory contains some initialisation code and linker configuration. A lot of the code and
constructs will be taught eventually, so you might not understand everything at first.

Don't add anything here, put your own source files in the src folder.


## startup.S

This file performs some initialisation required to make the board work as expected. It initialises
RAM with the `.data` section contents (this data is stored in flash memory with the code when uploaded
to the board). It also defines the vector table, which is responsible for setting the execution entry
point and other interrupt handlers.

When everything has been initialised, it will call the `main` function. You must define this function yourself.


## link.ld

This file tells the linker how to lay out all the `.text` and `.data` sections on the board. This one tells
the linker to concatenate all these sections together and store them in flash memory. It is also responsible
for ensuring the vector table gets put in the correct location in memory.

Some of these memory location details are exposed as constants the assembly code can use. For example, the
startup script uses the `_stack_end` variable to initialise the stack pointer register.
