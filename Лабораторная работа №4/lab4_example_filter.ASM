ESC_    equ     1Bh     ;скан-код клавиши ESC
        org 100h
start:
        mov     ah,08h  ; no echo
        int     21h
        cmp     al,ESC_ ;нажата ли клавиша ESC?
        je      exit    ;если да, то переход к метке exit. символ = ESC
        ; разрешён ввод только больших латинских букв
        cmp     al,'A'
        jb      start            ; sym < 'A'
        cmp     al,'Z'
        ja      start            ; sym > 'Z'

        mov     ah,02h  ; ввод символа в консоль
        mov     dl,al
        int     21h

        jmp     start ;переход в начало программы
exit:
        mov ah, 2h
        mov     dl, '!'
        int     21h

        mov ah,8h   ;ждать нажатия любой клавиши для выхода из программы
        int 21h

        ret