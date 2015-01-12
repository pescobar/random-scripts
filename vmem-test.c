// Test code to allocate virtual memory and optionally fill it up with resident memory
// Adapted from the code in http://www.darkcoding.net/software/resident-and-virtual-memory-on-linux-a-short-example/
// to accept arguments
//
// compile with cc -Wall -g vmem-test.c -o mem
//
// First argument is the number of gigabytes to allocate of virtual memory
// By default just virtual mem is allocated and resident memory stays under 1M
// If a second argument is provided the resident memory is also allocated
//
// Examples:
// ./mem 4      >>  allocates 4G of vmem. Resident mem stays under 1M
// ./mem 10 1   >>  allocate 10G of vmem and then fills it up with resident mem


#include <stdio.h>
#include <stdlib.h>

void fill(unsigned char* addr, size_t amount) {
    unsigned long i;
    for (i = 0; i < amount; i++) {
        *(addr + i) = 42;
    }
}

int main(int argc, char **argv) {

    unsigned char *result;

    char input;
    size_t s = 1<<30;
    int numgigs = atoi(argv[1]);

    result = malloc(s*numgigs);

    printf("Addr: %p\n", result);

    if (argc > 2) {
        fill(result, s*numgigs);
    }

    scanf("%c", &input);
    return 0;
}
