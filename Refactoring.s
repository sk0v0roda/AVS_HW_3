	.file	"7.c"
	.intel_syntax noprefix
	.text
	.globl	f
	.type	f, @function
f:
	push	rbp
	push	r12				#r12 = n
	push	r13				#i = 1
	mov	rbp, rsp
	movsd	xmm2, xmm0			#double x 
	movsd	xmm0, QWORD PTR .LC0[rip]	#fx
	movsd	xmm3, xmm0		
	mov	r12, 100			#n = 100
	movsd	xmm0, xmm2
	movsd	xmm4, xmm0			#pow = x
	movsd	xmm0, QWORD PTR .LC0[rip]	#fact = 1.0
	movsd	xmm5, xmm0
	mov	r13, 1				#int i = 1
	jmp	.L2
.L5:
	mov	rax, r13
	and	eax, 1
	test	eax, eax
	je	.L3
	movsd	xmm0, xmm4
	divsd	xmm0, xmm5
	movsd	xmm1, xmm3
	subsd	xmm1, xmm0
	movapd	xmm0, xmm1
	movsd	xmm3, xmm0
	jmp	.L4
.L3:
	movsd	xmm0, xmm4
	divsd	xmm0, xmm5
	movsd	xmm1, xmm3
	addsd	xmm0, xmm1
	movsd	xmm3, xmm0
.L4:
	movsd	xmm0, xmm4
	mulsd	xmm0, xmm2
	movsd	xmm4, xmm0
	mov	rax, r13
	add	eax, 1
	cvtsi2sd	xmm0, eax
	movsd	xmm1, xmm5
	mulsd	xmm0, xmm1
	movsd	xmm5, xmm0
	add	r13, 1
.L2:
	mov	rax, r13
	cmp	rax, r12
	jl	.L5
	movsd	xmm0, xmm3			#return fx
	pop	r13
	pop	r12
	pop	rbp
	ret
	.size	f, .-f
	.section	.rodata
	.align 8
.LC1:
	.string	"Incrorrect input, check README.md"
.LC2:
	.string	"r"
.LC3:
	.string	"w"
.LC4:
	.string	"Can't find this file"
.LC5:
	.string	"%lf"
.LC7:
	.string	"result is too small to print"
.LC8:
	.string	"%.9lf"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	DWORD PTR -36[rbp], edi		#argc
	mov	QWORD PTR -48[rbp], rsi		#argv
	cmp	DWORD PTR -36[rbp], 3		# argc !=3
	je	.L8
	lea	rdi, .LC1[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L14
.L8:
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT			#input
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	call	fopen@PLT			#out
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -8[rbp], 0		#check correct open
	je	.L10
	cmp	QWORD PTR -16[rbp], 0		#check correct open
	jne	.L11
.L10:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L14
.L11:
	lea	rdx, -32[rbp]
	mov	rax, QWORD PTR -8[rbp]		#x
	lea	rsi, .LC5[rip]			#"%lf"
	mov	rdi, rax			# input
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	movsd	xmm0, QWORD PTR -32[rbp]	#x
	ucomisd	xmm0, QWORD PTR .LC6[rip]
	jbe	.L16
	lea	rdi, .LC7[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L14
.L16:
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -56[rbp], rax
	movsd	xmm0, QWORD PTR -56[rbp]	#x to func f
	call	f
	movq	rax, xmm0			#save result to fx
	mov	QWORD PTR -24[rbp], rax
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	QWORD PTR -56[rbp], rdx
	movsd	xmm0, QWORD PTR -56[rbp]	#fx
	lea	rsi, .LC8[rip]			#"%.9lf"
	mov	rdi, rax			#out
	mov	eax, 1
	call	fprintf@PLT			#print result
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT			#close input
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT			#close out
	mov	eax, 0
.L14:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC6:
	.long	0
	.long	1077215232
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
