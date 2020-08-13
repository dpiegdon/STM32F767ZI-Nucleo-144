
#pragma GCC diagnostic ignored "-Wunused-parameter"

extern int errno;

int _write(int fd, const void *buffer, unsigned int count)
{
    return -1;
}

int _read(int fd, void *buffer, unsigned int count)
{
    return -1;
}

int _close(int fd)
{
    return -1;
}

int _fstat(int fd, void *buffer)
{
    return -1;
}

int _isatty(int fd)
{
    return -1;
}

long _lseek(int fd, long offset, int origin)
{
    return -1;
}

void _exit(int status)
{
}

