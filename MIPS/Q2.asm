# Solving a quadratic equation with real coefficients, such that the coefficients
# are received from the user and two solutions to the equation are printed 
#(assuming that the equation has two real solutions)
	.text
	
	.globl	main
main:
	li	$v0,4
	la	$a0, msg1
	syscall
	
	li	$v0,6
	syscall
	mov.s $f2,$f0 # f2 = a

	li	$v0,4
	la	$a0, msg2
	syscall
	
	li	$v0,6
	syscall	
	mov.s $f4,$f0 # f4 = b

	li	$v0,4	
	la	$a0, msg3
	syscall
	
	li	$v0,6
	syscall
	mov.s $f6,$f0 # f6 = c
	
	la $t0,num
	l.s $f12,($t0)
	
	
	mul.s  $f8,$f4,$f4 # f8 = b^2
	
	
	mul.s $f10,$f2,$f6 # f10 = a*c
	
	mul.s $f10,$f10,$f12 # f10 = 4*a*c

	
	sub.s $f6,$f8,$f10 # f6 = b^2 - 4*a*c
	
	
	
	sqrt.s $f6,$f6 # f6 = sqrt(f6)
	neg.s $f4,$f4 # f4 = -b
	sub.s $f8,$f4,$f6 # f8 = -b - sqrt(b^2-4*a*c)
	add.s $f10,$f4,$f6 # f10 = -b + sqrt(b^2-4*a*c)
	add.s $f2,$f2,$f2 # f2 = 2*a
	div.s $f8,$f8,$f2 # f8 = r1
	div.s $f10,$f10,$f2 # f10 = r2
	
	li $v0,2
	mov.s $f12,$f8
	syscall 
	
	li	$v0,4
	la	$a0, newline
	syscall
	
	li $v0,2
	mov.s $f12,$f10
	syscall 
	# Start .data segment (data!)
	.data
msg1:	.asciiz	"Enter a:\n"
msg2:	.asciiz	"Enter b:\n"
msg3:	.asciiz	"Enter c:\n"
newline:   .asciiz	"\n"
num : .float 4
