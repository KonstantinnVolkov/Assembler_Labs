PROBEL_    equ     20h     ;ascii-код клавиши пробел
        org 100h
start:
        mov     ah,08h  ; no echo
        int     21h
        cmp     al,PROBEL_ ;нажата ли клавиша пробел?
        je next
        jmp start

next:
        ; вывод звукового сообщения
        mov ah, 2h
        mov     dl, 7h ;7h - bell
        int     21h
        jmp start
        ret

