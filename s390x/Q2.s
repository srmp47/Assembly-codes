#In this code, the sequential multiplier function is implemented.
.macro enter size
	stmg	%r6, %r15, 48(%r15)
	lay	%r15, -(160+\size)(%r15)
.endm

.macro leave size
	lay	%r15, (160+\size)(%r15)
	lmg	%r6, %r15, 48(%r15)
.endm

.macro ret
	br	%r14
.endm

.macro call func
	brasl	%r14, \func
.endm

.macro print_long	# Output is in r3
	enter	0
	larl	%r2, pif
	call	printf
	leave	0
.endm

.macro read_long
	enter	8						
	larl	%r2, rif				
	lay		%r3, 160(%r15)			
	call	scanf					
	lg		%r2, 160(%r15)			
	leave	8						
.endm


.data
.align 8
rif:	.asciz	"%ld"
.align 8
pif:	.asciz	"%ld\n"
.align 8


.text
.global main

main:
	enter	0
	read_long
	lgr %r14 , %r2
	read_long 
	lgr %r1 , %r14
	xgr %r3 , %r3
	xgr %r4 , %r4
	xgr %r5 , %r5
	xgr %r6 , %r6
	loop:
	cgfi %r1 , 0
	je end_loop
	lgr %r3 , %r1
	sllg %r3 ,%r3 , 63
	srlg %r3 , %r3 , 63
	cgfi %r3 , 1
	je add
	j not_add
	add:
	mgrk %r4 , %r2 , %r3
	ar %r6 , %r5
	not_add:
	sllg %r2 , %r2, 1
	srlg %r1 , %r1 , 1
	j loop
	end_loop:
	lgr %r3 , %r6
	print_long
	
	
	leave	0
 	xgr	%r2, %r2
	ret
