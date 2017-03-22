//
// This file is part of the GNU ARM Eclipse Plug-in
// Copyright (c) 2013 Liviu Ionescu
//

#include <sys/types.h>
#include <errno.h>

extern char _end; /* Defined in linker script to be the start of the heap */

caddr_t _sbrk(int incr)
{
	static char* current_heap_end;
	char* current_block_address;

	if (current_heap_end == 0)
		current_heap_end = &_end;

	current_block_address = current_heap_end;

	// Need to align heap to word boundary, else will get
	// hard faults on Cortex-M0. So we assume that heap starts on
	// word boundary, hence make sure we always add a multiple of
	// 4 to it.
	incr = (incr + 3) & (~3); // align value to 4
	if (current_heap_end + incr > &_end + HEAP_SIZE)
	{
		// No more heap available
		errno = ENOMEM;
		return (caddr_t) - 1;
	}

	current_heap_end += incr;

	return (caddr_t) current_block_address;
}

