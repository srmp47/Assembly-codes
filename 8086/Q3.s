; The number of zeros and ones in the input string is printed in the output, respectively.
global asm_main

section .data
    buffer1 db 256 dup(0)      
    newline db 10, 0        
    format2 db "%d", 0         

section .text
    extern printf, fgets, exit, stdin

asm_main:

    push rbp                 
    mov rbp, rsp              
    sub rsp, 16            



    lea rdi, [buffer1]        
    mov esi, 256              
    mov rdx, [stdin]        
    call fgets

    ; Remove newline character if present
    lea rsi, [buffer1]
remove_newline:
    movzx rax, byte [rsi]    
    test rax, rax             
    je count_characters       
    cmp rax, 10              
    jne skip_char
    mov byte [rsi], 0        
    jmp count_characters
skip_char:
    inc rsi
    jmp remove_newline

count_characters:

    xor rcx, rcx              
    xor rbx, rbx             

    lea rsi, [buffer1]       
count_loop:
    movzx rax, byte [rsi]    
    test rax, rax            
    je print_results          
    cmp rax, '0'              
    je increment_zero
    cmp rax, '1'            
    je increment_one
    jmp next_char             

increment_zero:
    inc rcx                  
    jmp next_char

increment_one:
    inc rbx                  

next_char:
    inc rsi                   
    jmp count_loop

print_results:
    ; Print the counter for '0'
    mov rdi, format2         
    mov rsi, rcx            
    xor rax, rax              
    call printf


    mov rdi, newline         
    xor rax, rax             
    call printf


    mov rdi, format2        
    mov rsi, rbx             
    xor rax, rax             
    call printf


    mov rdi, newline         
    xor rax, rax             
    call printf


    xor rdi, rdi              
    call exit

