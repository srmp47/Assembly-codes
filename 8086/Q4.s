#Sum of positive 128-bit numbers
#input:
#43497487297439879731236782368126387263718493794
#+
#32738912738273971876437648736876125362563571253
#output:
#76236400035713851607674431105002512626282065047

.macro enter size
	stmg	%r6, %r15, 48(%r15)
	lay	%r15, -(160+\size)(%r15)
.endm

.macro leave size
	lay	%r15, (160+\size)(%r15)
	lmg	%r6, %r15, 48(%r15)
.endm
.macro print_string label       # Output is in the label
        enter   0
        larl    %r3, \label
        larl    %r2, psf
        call    printf
        leave   0
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
num1 : .space 200
.align 8
num2: .space 200
.align 8
num1_size: .space 20
.align 8
flag : .space 5
.align 8
num3: .space 300
.align 8
num4: .space 300
.align 8
num5: .space 300
.align 8
num5_size: .space 40
.align 8
number_zero: .space 10
.align 8
num2_size: .space 20
.align 8
num3_size: .space 40
.align 8
num4_size: .space 40
.align 8
pif:	.asciz	"%ld"
.align 8
nextline: .asciz "\n"
.align 8
psf:    .asciz  "%s"
.align 8
msg:    .asciz "here runed"
.align 8


input:	.space	100

.text
.global main


sum:
  enter 16
  cgr %r6, %r7
  jl change
  cgr %r6 , %r7
  je change
  j func
  
  
  change: #always %r7 is less size or equal to %r6 (least number is always in %r5, size in %r7)
  lgr %r8, %r4
  lgr %r4, %r5
  lgr %r5, %r8
  lgr %r8, %r6
  lgr %r6, %r7
  lgr %r7, %r8
func:
  lgr %r3 , %r6
  agfi %r3 , -1
  lgr %r8 , %r7
  agfi %r8 , -1
  xgr %r14 , %r14
  xgr %r10, %r10
  loop:
  xgr %r11, %r11
  xgr %r12, %r12
  agr %r11, %r4
  agr %r12, %r5
  agr %r12, %r8
  agr %r11, %r3
  llc %r11, 0(%r11)
  llc %r12, 0(%r12)
  agfi %r11, -48
  agfi %r12, -48
  xgr %r13 , %r13
  agrk %r13, %r11, %r12
  agr %r13, %r10
  cgfi %r13, 10
  jh case1
  cgfi %r13 , 10
  je case1
  larl %r10, num3
  agr %r10, %r14
  agfi %r13 , 48
  stc %r13, 0(%r10)
  xgr %r10, %r10
  j loop_check
  case1:
  xgr %r10 , %r10
  agfi %r10 , 10
  sgr %r13, %r10
  cgfi %r13, 10
  jh case2
  cgfi %r13 , 10
  je case2
  larl %r10, num3
  agr %r10, %r14
  agfi %r13 , 48
  stc %r13, 0(%r10)
  xgr %r10, %r10
  agfi %r10, 1
  j loop_check
case2:
  larl %r10, num3
  agr %r10, %r14
  agfi %r13 , 48
  stc %r13, 0(%r10)
  xgr %r10, %r10
  agfi %r10, 2
loop_check:
  agfi %r14 , 1
  agfi %r8, -1
  agfi %r3 , -1
  cgfi %r8, -1
  jne loop
  cgfi %r3 , -1
  je add_last_number
  j loop2
add_last_number:
  xgr %r1 , %r1
  agfi %r1 , 1
  stgrl %r1 , flag
  j exit_sum
  loop2:
  xgr %r13, %r13
  agr %r13, %r4
  agr %r13, %r3
  llc %r13, 0(%r13)
  agr %r13, %r10
  xgr %r8 , %r8
  lgr %r8 , %r13
  agfi %r8 , -48
  cgfi %r8, 10
  jh case11
  cgfi %r8 , 10
  je case11
  larl %r10, num3
  agr %r10, %r14
  stc %r13, 0(%r10)
  xgr %r10, %r10
  j loop_check2
  case11:
  lgfi %r10 , 10
  sgr %r8, %r10
  sgr %r13 , %r10
  cgfi %r8, 10
  jh case22
  cgfi %r8 , 10
  je case22
  larl %r10, num3
  agr %r10, %r14
  stc %r13, 0(%r10)
  xgr %r10, %r10
  agfi %r10, 1
  j loop_check2
case22:
  larl %r10, num3
  agr %r10, %r14
  stc %r13, 0(%r10)
  xgr %r10, %r10
  agfi %r10, 2

loop_check2:
  agfi %r14 , 1
  agfi %r3, -1
  cgfi %r3, -1
  jne loop2
  cgfi %r10 , 0
  jne add_last_number2
  j exit_sum
 add_last_number2:
 # larl %r9 , num3
 # agfi %r9 , %r14
 # xgr %r10 , %r10
 # agfi %r10 , +49
 # stc %r10 , 0(%r9)
  xgr %r1 , %r1
  agfi %r1 , 1
  stgrl %r1 , flag
  agfi %r14 , 1
  j exit_sum
  exit_sum:
  stgrl %r14 , num3_size
  lgrl %r13 , num3_size
  stgrl %r13 , num4_size
  final_loop_s:
  larl %r10 , num3
  larl %r11 , num4
  agr %r10 , %r13
  agr %r11 , %r13
  llc %r9 , 0(%r10)
  stc %r9 , 0(%r11)
  cgfi %r13 , 0
  je end_sum
  agfi %r13 , -1
  j final_loop_s
  end_sum:
  leave 16
  ret


print_sum_result:
enter 16
lgrl %r14 , num4_size
agfi %r14 , 1
print_output:
  agfi %r14 , -1
  main_loop_print:
  larl %r10 , num4
  xgr %r13 , %r13
  agr %r13 , %r10
  agr %r13 , %r14
  llc %r3 , 0(%r13)
  print_char
  agfi %r14 , -1
  cgfi %r14 , -1
  je exit_print_sum_result
  j  main_loop_print
exit_print_sum_result:
leave 16
ret









main:
	enter	0
	first:
	xgr %r1 , %r1
	stgrl %r1 , flag
	larl %r6 , num1
	larl %r7 , num2
	xgr %r8 , %r8
	xgr %r9 , %r9
get_num1:
	read_char
	cfi %r2, '\n'		
	je get_operator
	stc %r2, 0(%r6)
	agfi %r8 , 1
	agfi %r6, 1		
	
	j get_num1
get_operator:
        read_char
        j end_get_operator
end_get_operator:
        read_char
get_num2:
        read_char
	cfi %r2, '\n'		
	je end_get_num2
	cfi %r2 , 'q'
	je exit
	stc %r2, 0(%r7)	
	agfi %r9 ,1
	agfi %r7, 1		
	
	j get_num2
end_get_num2:
        stgrl %r8 , num1_size
        stgrl %r9 , num2_size
        j go_to_sum
go_to_sum:
        larl %r4, num1
        larl %r5, num2  
        lgrl %r6, num1_size
        lgrl %r7, num2_size
        call sum
        lgrl %r1 , flag
        cgfi %r1 , 1
        jne finish
        xgr %r3 , %r3 
        agfi %r3 , 49
	lgrl %r2 , num3_size
	agfi %r2 , 1
	stgrl %r2 , num3_size
	larl %r4 , num3
	agr %r2 , %r4
	stc %r3 , 0(%r2)
	finish:
        call print_sum_result
        j exit
        



  
  
exit:

	leave	0
 	xgr	%r2, %r2
	ret
