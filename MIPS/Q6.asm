#First, three numbers between 0 and 31 are taken as input.
# First, these three numbers are sorted and printed. 
#Then, the binary values ​​of the numbers are reversed and printed in the same order.
# No jump or conditional statements are used in this code.
#input:
# 3 23 7
# output : 
#23 7 3
#111010 111000 110000
.data
space: .asciiz " "
newline: .asciiz "\n"
.text
main:
    li $v0, 5             
    syscall
    move $t0, $v0 
    li $v0, 5             
    syscall
    move $t1, $v0 
    li $v0, 5             
    syscall
    move $t2, $v0 
    
    add $t7 , $t0 , $t1
    add $t7 , $t7 , $t2
            
    sub $t3 ,$t2 , $t1
    srl $t3 , $t3 ,31
    xor $t4 , $t3 , 1
    mul $t5 , $t3 , $t1
    mul $t6 , $t4 , $t2
    add $t9 , $t5 , $t6

    
    sub $t3 ,$t9 , $t0
    srl $t3 , $t3 ,31
    xor $t4 , $t3 , 1
    mul $t5 , $t3 , $t0
    mul $t6 , $t4 , $t9
    add $t8 , $t5 , $t6
    sub $t7 , $t7 , $t8
    move $s0 , $t8
    move $a0 , $t8
    li $v0 , 1
    syscall 
    li $v0, 4          
    la $a0, space        
    syscall  
    
    sub $t3 ,$t2 , $t1
    srl $t3 , $t3 ,31
    xor $t4 , $t3 , 1
    mul $t5 , $t3 , $t2
    mul $t6 , $t4 , $t1
    add $t9 , $t5 , $t6
    
    sub $t3 ,$t9 , $t0
    srl $t3 , $t3 ,31
    xor $t4 , $t3 , 1
    mul $t5 , $t3 , $t9
    mul $t6 , $t4 , $t0
    add $t8 , $t5 , $t6
    sub $t7 , $t7 , $t8
    
    move $s1 , $t7
    move $a0 , $t7
    li $v0 , 1
    syscall 
    
    li $v0, 4          
    la $a0, space        
    syscall
     
    move $s2 , $t8 
    move $a0 , $t8
    li $v0 , 1
    syscall
     
    li $v0 , 4
    la $a0 , newline
    syscall 
    
   and $t3 , $s0 , 1
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s0 , 2
   srl $t3 , $t3 , 1
   move $a0 , $t3
   li $v0 , 1
   syscall 
    
   and $t3 , $s0 , 4
   srl $t3 , $t3 , 2
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s0 , 8
   srl $t3 , $t3 , 3
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s0 , 16
   srl $t3 , $t3 , 4
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s0 , 32
   srl $t3 , $t3 , 5
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
    li $v0, 4          
    la $a0, space        
    syscall
   
   and $t3 , $s1 , 1
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s1 , 2
   srl $t3 , $t3 , 1
   move $a0 , $t3
   li $v0 , 1
   syscall 
    
   and $t3 , $s1 , 4
   srl $t3 , $t3 , 2
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s1 , 8
   srl $t3 , $t3 , 3
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s1 , 16
   srl $t3 , $t3 , 4
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s1 , 32
   srl $t3 , $t3 , 5
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
    li $v0, 4          
    la $a0, space        
    syscall
   
   and $t3 , $s2 , 1
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s2 , 2
   srl $t3 , $t3 , 1
   move $a0 , $t3
   li $v0 , 1
   syscall 
    
   and $t3 , $s2 , 4
   srl $t3 , $t3 , 2
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s2 , 8
   srl $t3 , $t3 , 3
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s2 , 16
   srl $t3 , $t3 , 4
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
   and $t3 , $s2 , 32
   srl $t3 , $t3 , 5
   move $a0 , $t3
   li $v0 , 1
   syscall 
   
    li $v0, 10         
    syscall
