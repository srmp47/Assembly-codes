# A string of zeros and ones is taken and the largest substring made of ones
# and the largest substring made of zeros are printed respectively.
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

.macro	read_char
	enter	8
	larl	%r2, rcf
	lay	%r3, 167(%r15)
	call	scanf
	lb	%r2, 167(%r15)
	leave	8
.endm
.macro print_long	# Output is in r3
	enter	0
	larl	%r2, pif
	call	printf
	leave	0
.endm

.macro print_char
	enter	0
	larl	%r2, pcf
	call	printf
	leave	0
.endm

.data
.align 8
rcf:	.asciz	"%c"
.align 8
pcf:	.asciz	"%c"
.align 8
pif:	.asciz	"%ld\n"
.align 8

input:	.space	100

.text
.global main

main:
	enter	0

	larl	%r6, input
	xgr %r7 , %r7
	xgr %r8 , %r8
	xgr %r9 , %r9
	xgr %r10 , %r10
get_input:
	read_char
	cfi		%r2, '\n'		
	je		print_output
	cfi		%r2, 49		
	je		one                     
        cfi             %r2 , 48
        je              zero
        j               check
        one:
        agfi %r8 , 1
        j check
        
        zero:
        agfi %r7 , 1
        j check
        
        
        check :        
        cgr %r7 , %r9
        jh update_zero
        cgr %r8  , %r10
        jh update_one      
        j store
        
        update_one:
        lgr %r10 , %r8
        j  store
        update_zero:
        lgr %r9 , %r7
        j store
        

store:
        cfi		%r2, 49			
	je              reze
        cfi             %r2 , 48
        je              reone
        xgr %r7 , %r7
        xgr %r8 , %r8
        j end
reone:
xgr %r8 , %r8
j end
reze:
xgr %r7 , %r7
j end
end:
        
	agfi	%r6, 1			
	j		get_input

print_output:
        lgr %r3 , %r10
        print_long
        
        lgr %r3 , %r9
        print_long

	leave	0
 	xgr	%r2, %r2
	ret
