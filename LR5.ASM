         org 100h
start:
        mov ah, 09h
        mov dx,txt
        int 21h

        mov ah, 0ah
        mov dx, enter_str
        int 21h

        cld
        mov cx,11
        mov si,enter_str+17   ; откуда
        mov di,string2+17  ; куда

rep     movsb

        ; вывод получ строки
        mov ah,9h
        mov dx, string2+2
        int 21h

        mov ah, 02h
        mov dx, 0x0D0A
        int 21h

        mov ah, 09h
        mov dx,txt
        int 21h

        mov ah, 0ah
        mov dx, a_str
        int 21h

        mov ah, 02h
        mov dx, 0x0D0A
        int 21h

        mov ah, 09h
        mov dx,txt
        int 21h

        mov ah, 0ah
        mov dx, b_str
        int 21h
        mov ah, 02h
        mov dx, 0x0D0A
        int 21h

        cld
        mov cx,9
        mov al,[a_str+2]
        mov di,b_str+2

        xor bx,bx
next:
repne   scasb
        je symbol_found
        jmp eos

symbol_found:
        push ax

        mov dx,di
        sub dx,13
        add dx,'0'

        mov ah,02h
        int 21h

        pop ax
        jmp next

eos:    mov ah,08h
        int 21h

        ret

txt             db      "enter string", 0dh, 0ah, '$'
exit_str        db      0dh, 0ah,"To exit now press any button...", 0dh, 0ah, '$'
string2         db      33,0,32 dup('*'), '$'
enter_str       db      33,0,33 dup('$')
yes             db      "yes $"

problem_str     db      'net sovpadeniy $'
a_str           db      2,0,2 dup('$')
b_str           db      10,0,10 dup ('$')
