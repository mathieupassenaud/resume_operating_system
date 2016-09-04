ENTRY (main)

SECTIONS {
    . = 0x0100000;
    .boot :
    {
        *(.boot);      
	LONG(0)     
    }
    
    
    _start_of_kernel = .;
    .text :
    {
        *(.text)
    }

    .rodata ALIGN (0x1000) :
    {
        *(.rodata)
    }

    .data ALIGN (0x1000) :
    {
        *(.data)
    }
    _end_of_load = .;
    
    .bss :
    {
        _sbss = .;
        *(COMMON)
        *(.bss)
        _ebss = .;
    }
    
    _end_of_kernel = .;

}

