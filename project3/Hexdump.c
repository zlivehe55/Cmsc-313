#include <stdio.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("the usage: %s filename\n", argv[0]);
        return 1;
    }

    FILE *f = fopen(argv[1], "rb");
    if (f == NULL) {
        printf("cant open file\n");
        return 1;
    }

    unsigned char bytes[16];
    int addr = 0;
    int count;
    int i;

    while ((count = fread(bytes, 1, 16, f)) > 0) {
        printf("%08x ", addr);

        for (i = 0; i < 16; i++) {
            if (i < count)
                printf("%02x ", bytes[i]);
            else
                printf("   ");
        }

        printf("|");
        for (i = 0; i < count; i++) {
            if (isprint(bytes[i]))
                printf("%c", bytes[i]);
            else
                printf(".");
        }
        printf("|\n");

        addr += count;
    }

    fclose(f);
    return 0;
}