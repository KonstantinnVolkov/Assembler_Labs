        org 100h
start:
        xor bx, bx  ; чистим регистр BX

        ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,txt
        int     21h

        ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,txt2
        int     21h

        ; вывод нашей строки
        mov ah, 9h
        mov     dx,string1
        int     21h

        cld      ; сбрасываем флаг направления, будем идти от начала строки и до конца
        mov     cx,10  ;установка длины строки в 10 байт
        mov     di,string1 ; в регистре DI адрес строки, в которой будем искать наш символ
        mov     al,[find] ; в регистре AL находится наш символ

repne   scasb    ; выполняем поиск до первого совпадения
       mov dx, YES
       je yes_symbol  ; переход, если наш символ есть в строке

        mov dx, NO
yes_symbol:
        ; вывод текстового ссообщения
        mov ah,9h
        int 21h
        ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,find
        int     21h

        ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,exit_str
        int     21h

        mov ah,8h   ;ждать нажатия любой клавиши для выхода из программы
        int 21h
        ret

txt             db      "Scan string example", 0dh, 0ah, '$'
txt2            db      "String $"
exit_str        db      0dh, 0ah, 0dh, 0ah,"To exit now press any button...", 0dh, 0ah, '$'
string1         db      "abcdefghij$";10,0,10 dup('$') ; "abcdefghij$"
find            db      "h$"
YES             db      0dh, 0ah," includes element $"
NO              db      0dh, 0ah, " NOT includes element $"


