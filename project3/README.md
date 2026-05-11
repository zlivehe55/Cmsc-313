# Project 3 - Hex Dump with Optimization Comparison

## What this is
A C program that prints a hex dump of a binary file in the format:
address  16 bytes of hex  

## How to build and run
gcc -o hexdump Hexdump.c
./hexdump binary.out

## How the .s files were made
gcc -O0 -S -o Hexdump_O0.s Hexdump.c
gcc -O1 -S -o Hexdump_O1.s Hexdump.c
gcc -O3 -S -o Hexdump_O3.s Hexdump.c

## Comparison

All three optimization levels produce the EXACT same hex dump output.
What changes is HOW the compiler builds the program.

## What I noticed

O0: 105 instructions. Uses %rbp as a frame pointer with the classic
`pushq %rbp / movq %rsp, %rbp / subq $64, %rsp` setup from class. All
variables sit on the stack (argc at -52(%rbp), argv at -64(%rbp), etc).
The loop counter gets loaded from memory, incremented, and stored back
every iteration.

O1: 89 instructions. No frame pointer. Main pushes %rbx, %rbp, %r12,
%r13, %r14, %r15 so it can hold variables in registers through the
whole program. The loop counter is just addq $1, %rb with no memory
access. About 15% fewer instructions than O0.

O3: Same 89 instructions as O1. Only real difference I saw was O3 uses
`xorl %eax, %eax` to zero out a register instead of `movl $0, %eax`.
Same result, shorter instruction.

Big jump is O0 to O1 because variables move from stack to registers.
O3 barely helps here because most of the time is in printf and fread,
not our loop. O0 is mainly useful for debugging.