#The input lines receive the length of the substring, substring, string length,
# and string in that order, and check how many times the substring is repeated 
#in the string. The length of the string is in the range of 32-bit numbers.
.data
newline:         .asciiz "\n"
length1:         .word 0
length2:         .word 0
.text
main:
  
    li $v0, 5
    syscall
    move $t0, $v0          
    sw $t0, length1       

    addi $a0, $t0, 1        
    li $v0, 9
    syscall
    move $t1, $v0          

   
    move $a0, $t1          
    move $a1, $t0          
    addi $a1 , $a1 , 1
    li $v0, 8
    syscall
    move $s0 , $a0

  
    li $v0, 5
    syscall
    move $t2, $v0         
    sw $t2, length2         

  
    addi $a0, $t2, 1       
    li $v0, 9
    syscall
    move $t3, $v0          

   
    move $a0, $t3        
    move $a1, $t2          
    addi $a1 , $a1 , 1
    li $v0, 8
    syscall
    move $s1 , $a0

    la $a0 , length1
    lw $a0 , 0($a0)
    move $a1 , $s0
    la $a2 , length2
    lw $a2,0($a2)
    move $a3 , $s1
   
   
  

   li $t9 , 1
   label:
   move $a2 , $t9
   la $a0 , length1
   lw $a0 , 0($a0) 
    jal func
    move $a0 , $v0
    li $v0 , 1
    syscall
    li $v0 , 4
    la $a0 , newline
    syscall
    la $t8 , length2
    lw $t8 , 0($t8)
    beq $t9 , $t8 , finish
    addi $t9 , $t9 , 1
    j label
     finish:
    
    
   
    li $v0, 10
    syscall


func:
li $v0 , 0
subi $sp , $sp , 20
sw $ra , 0($sp)
sw $a0 , 4($sp)
sw $a1 , 8($sp)
sw $a2 , 12($sp)
sw $a3 , 16($sp)
sub $t0 , $a2 , $a0
bltz $t0 , exit1
li $t1 , 0
loop1:
move $s5 , $a3
move $s4 , $a1
li $t2 , 0
loop2:
add $s4 , $a1 , $t2
add $s5 , $a3 , $t2
lb $t3 , 0($s4)
lb $t4 , 0($s5)
bne $t4 , $t3 , exit2
addi $t2 , $t2 , 1
beq $t2 , $a0 , add_label
j loop2
add_label:
addi $v0 , $v0 , 1
exit2:

beq $t1 , $t0 , exit1
addi $t1 , $t1 , 1
addi $a3 , $a3 , 1
j loop1
exit1:
lw $ra , 0($sp)
lw $a0 , 4($sp)
lw $a1 , 8($sp)
lw $a2 , 12($sp)
lw $a3 , 16($sp)
addi $sp , $sp , 20
jr $ra
