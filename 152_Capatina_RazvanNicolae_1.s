.data
.text
.globl main
main:

etExit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

