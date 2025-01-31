; Two strings are received and compared byte by byte to see if they are equal.
global asm_main
section .data
    equal_msg db "Strings are equal!", 0xA, 0
    not_equal_msg db "Strings are not equal!", 0xA, 0
    buffer1 db 256 dup(0)
    buffer2 db 256 dup(0)
    format db "%s", 0

section .text
    extern printf, scanf, exit, fgets, stdin
    global _start

asm_main:

    mov rbx, rsp
    and rsp, -16

  


    lea rdi, [buffer1]    ; First argument: pointer to buffer1
    mov esi, 256          ; Second argument: size of the buffer
    mov rdx, [stdin]      ; Third argument: stdin
    call fgets


    lea rsi, [buffer1]
    call strip_newline

 


    lea rdi, [buffer2]    
    mov esi, 256          
    mov rdx, [stdin]      
    call fgets


    lea rsi, [buffer2]
    call strip_newline


    lea rsi, [buffer1]
    lea rdi, [buffer2]
compare_loop:
    mov al, [rsi]
    mov bl, [rdi]
    cmp al, bl
    jne not_equal
    test al, al        
    je equal
    inc rsi
    inc rdi
    jmp compare_loop

not_equal:
    mov rdi, not_equal_msg
    xor rax, rax         
    call printf
    jmp cleanup

equal:
    mov rdi, equal_msg
    xor rax, rax          
    call printf

cleanup:
    
    mov rsp, rbx
    xor rdi, rdi         
    call exit

strip_newline:
    xor rdi, rdi         
newline_loop:
    mov al, [rsi + rdi]   
    test al, al           
    je strip_done
    cmp al, 0x0A          
    jne next_char
    mov byte [rsi + rdi], 0 
    jmp strip_done
next_char:
    inc rdi
    jmp newline_loop
strip_done:
    ret

section .note.GNU-stack
    db 0

