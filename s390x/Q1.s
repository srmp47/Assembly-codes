# A string containing uppercase and lowercase English letters is received
# and the sum of the numbers in the string is printed.
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



.data
.align 8
rcf:	.asciz	"%c"
.align 8
pif:	.asciz	"%d\n"
.align 8

input:	.space	100

.text
.global main

main:
	enter	0
	larl	%r6, input
	xgr %r7 , %r7
get_input:
	read_char
        stc		%r2, 0(%r6)
	cfi		%r2, '\n'		
	je		print_output
	cfi		%r2, 57			
	jh		label			
        cfi             %r2 , 48
        jl              label
      lgr %r8 , %r6
      second_loop:
      agfi %r6 , 1
      read_char
      stc		%r2, 0(%r6)	
      cfi		%r2, 57			
      jh		store			
      cfi             %r2 , 48
      jl              store
      cfi		%r2, '\n'
      je               store
      j               second_loop 
       
store:
        lgr %r9 , %r6
        agfi %r9 , -1
        xgr %r10 , %r10
        agfi %r10 , 1
        loop:
        lgb %r11, 0(%r9)
        aghi %r11 , -48
        mgrk %r4 , %r10 , %r11
        ar %r7 , %r5
        cgr %r9 , %r8
        je end_loop
        agfi %r9 , -1
        mhi %r10 , 10
        j   loop
        end_loop:
        
          cfi		%r2, '\n'
      je               print_output
        
	agfi	%r6, 1			
	j		get_input

label:

agfi	%r6, 1			
j		get_input

print_output:
        lgr      %r3, %r7      
	print_long

	
	
	
	
	leave	0
 	xgr	%r2, %r2
	ret
