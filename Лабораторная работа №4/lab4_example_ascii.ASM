ESC_    equ     1Bh     ;ASCII-код клавиши ESC
        org 100h

        ; вывод текстового ссообщения
        mov ah, 9h
        mov dx, txt
        int 21h

start:
        ; ввод клавиши в консоль
        mov     ah,08h  ; no echo
        int     21h
        cmp     al,ESC_ ;нажата ли клавиша ESC?
        je      exit    ;если да, то переход к метке exit. символ = ESC

        mov     ah,02h  ; вывод символа в консоль
        mov     dl,al
        int     21h

        jmp     start ;переход в начало программы
exit:
        ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,exit_str
        int     21h

        mov ah,8h   ;ждать нажатия любой клавиши для выхода из программы
        int 21h

        ret
txt     db      "Display ASCII", 0dh, 0ah, '$'
exit_str        db      0dh, 0ah,"To exit now press any button...", 0dh, 0ah, '$'