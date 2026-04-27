.section .data
label:      .ascii "The double is: "
label_len = . - label

.section .bss
.lcomm numStr, 32           
.lcomm result, 32           # buffer for the doubled val as ascii

.section .text
.global _start

_start:
    # THis just read the user's num
    movq $0, %rax          
    movq $0, %rdi          
    movq $numStr, %rsi      # where to put what we read
    movq $32, %rdx         
    syscall

    # THis one  convert the ascii string to an an int 
    movq $numStr, %rdi      # walking pointer
    xorq %rcx, %rcx         # value = 0

parseLoop:
    xorq %rax, %rax
    movb (%rdi), %al        # gets next char
    cmpb $'0', %al          
    jb   parseDone
    cmpb $'9', %al        
    ja   parseDone
    subb $'0', %al          
    imulq $10, %rcx         
    addq %rax, %rcx        
    incq %rdi               # advance to next char
    jmp  parseLoop
parseDone:

  
    addq %rcx, %rcx         # n + n  ==  2 * n 

    # and then it convert the doubled value back to ascii I wrote the  digits right ot right into 'result' so they end up in order
    
    movq $(result+31), %rdi 
    movb $'\n', (%rdi)      
    decq %rdi
    movq %rcx, %rax         

buildLoop:
    xorq %rdx, %rdx
    movq $10, %rcx
    divq %rcx           
    addb $'0', %dl         
    movb %dl, (%rdi)        # basiclly stores it here
    decq %rdi             
    cmpq $0, %rax          
    jne  buildLoop

    incq %rdi               
    pushq %rdi              # save it across the next syscall

    # this is where it print "The doubble is: "
    movq $1, %rax          
    movq $1, %rdi          
    movq $label, %rsi
    movq $label_len, %rdx
    syscall

    #  print the num n newline 
    popq %rsi              
    movq $(result+32), %rdx # length = (end of buffer) - (first digit)
    subq %rsi, %rdx
    movq $1, %rax
    movq $1, %rdi
    syscall

  
    movq $60, %rax          
    movq $0, %rdi       
    syscall

.section .note.GNU-stack,"",@progbits