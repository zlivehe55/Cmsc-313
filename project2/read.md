
## Project 2

Reads a number from stdin, doubles it, prints The doubble is:  followed by a newline.

## For the build
```
gcc -nostdlib -no-pie project2.s -o project2
```

## Run
```
./project2
11
The double is: 22
```

You can also echo the number in:
```
echo {num} | ./project2

echo 21 | ./project2
```

## Notes on the implementation
I used syscall 0 (read) to grab the number from stdin since the lecture covered syscall 1 (write) and syscall 60 (exit) in print_hello.s same syscall instruction, just different nums in %rax. Not sure if I get points off for that

# I did not know about negative numbers so I just assume the user will only input positive ones.