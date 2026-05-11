	.file	"Hexdump.c"
	.text
	.section	.rodata
.LC0:
	.string	"usage: %s filename\n"
.LC1:
	.string	"rb"
.LC2:
	.string	"cant open file"
.LC3:
	.string	"%08x "
.LC4:
	.string	"%02x "
.LC5:
	.string	"   "
.LC6:
	.string	"|"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	cmpl	$2, -52(%rbp)
	je	.L2
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %eax
	jmp	.L15
.L2:
	movq	-64(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L4
	movl	$.LC2, %edi
	call	puts
	movl	$1, %eax
	jmp	.L15
.L4:
	movl	$0, -4(%rbp)
	jmp	.L5
.L14:
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	$0, -8(%rbp)
	jmp	.L6
.L9:
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.L7
	movl	-8(%rbp), %eax
	cltq
	movzbl	-48(%rbp,%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	jmp	.L8
.L7:
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
.L8:
	addl	$1, -8(%rbp)
.L6:
	cmpl	$15, -8(%rbp)
	jle	.L9
	movl	$124, %edi
	call	putchar
	movl	$0, -8(%rbp)
	jmp	.L10
.L13:
	call	__ctype_b_loc
	movq	(%rax), %rdx
	movl	-8(%rbp), %eax
	cltq
	movzbl	-48(%rbp,%rax), %eax
	movzbl	%al, %eax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$16384, %eax
	testl	%eax, %eax
	je	.L11
	movl	-8(%rbp), %eax
	cltq
	movzbl	-48(%rbp,%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	putchar
	jmp	.L12
.L11:
	movl	$46, %edi
	call	putchar
.L12:
	addl	$1, -8(%rbp)
.L10:
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L13
	movl	$.LC6, %edi
	call	puts
	movl	-20(%rbp), %eax
	addl	%eax, -4(%rbp)
.L5:
	movq	-16(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rdx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fread
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jg	.L14
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	movl	$0, %eax
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.5.0 20240719 (Red Hat 11.5.0-5)"
	.section	.note.GNU-stack,"",@progbits
