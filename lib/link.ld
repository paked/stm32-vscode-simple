/*
  Understanding this file is NOT part of the course at all. It is provided with comments
  in case you are interested in what it is doing.

  If you want to read more documentation on this file, see https://sourceware.org/binutils/docs/ld/Scripts.html#Scripts
 */

/*
  Says to start execution at the "Reset_Handler" symbol (see startup.S).
  Primarily used by debuggers: the board itself determines the entry point
  from the value stored in memory address 0x0000_0004 (we make sure to
  put the Reset_Handler address there).
 */
ENTRY(Reset_Handler)

/* Specifies the size and location of the memory areas */
MEMORY {
    RAM (rw)   : ORIGIN = 0x20000000, LENGTH = 96K
    RAM2 (rw)  : ORIGIN = 0x10000000, LENGTH = 32K
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1024K
}

/*
  Specifies the end of the main stack (see ARM reference manual B1.4.1) This variable is
  used in startup.S to initalise the SP register. We set it to the end of the larger RAM section.
 */
_stack_end = ORIGIN(RAM) + LENGTH(RAM); /* 0x2001_8000 */

/* Amount of room that must be left unused for the stack to grow into */
_min_stack_size = 0x400;

/*
  Defines where the .section regions are placed. Take a look in
  the memory view to see this in action; in particular, see that
  the .data section is actually loaded into FLASH too.
 */
SECTIONS {
    /*
      This section is used for the vector table. We put it first so that it goes to the start of FLASH,
      which is mapped to 0x0, which is where the vector table is expected to be by default.
    */
    .rodata.vtable : { *(.rodata.vtable) } > FLASH

    /* Next we insert all the .text sections */
    .text : {
        . = ALIGN(4);
        _text_start = .;
        *(.text)
        _text_end = .;
    } > FLASH

    /* Then we insert all the .data sections */
    .data : {
        . = ALIGN(4);
        _data_start_ram = .;
        KEEP(*(.data))
        . = ALIGN(4); /* Round up the data section to a multiple of 4 bytes, to make the startup copy routine simpler */
        _data_end_ram = .;

        /* Require that the stack has some room to grow */
        /*
          NOTE: Inside of a section entry like this, the current position starts at 0, not the start address of
          the memory region. This is why we compare against LENGTH(RAM) instead of _stack_end.
        */
        ASSERT(_data_end_ram + _min_stack_size < LENGTH(RAM), "Error: Stack does not have enough room to grow");
    } > RAM AT> FLASH

    /*
      Defines the start of data in FLASH. This is where the data is actually stored when uploaded to the board.
      (this is what `> RAM AT> FLASH` does: the section is marked as for RAM, but physically located in FLASH)
      It is up to the running program to copy this data from FLASH into RAM.
    */
    _data_start_flash = LOADADDR(.data);
    _data_end_flash = _data_start_flash + (_data_end_ram - _data_start_ram);
}
