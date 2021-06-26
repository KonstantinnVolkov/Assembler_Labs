        org 100h
start:
        ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,txt
        int     21h

        cld    ; сбрасываем флаг направления, будем идти от начала строки и до конца
        mov     cx,10 ;установка длины строки в 10 байт
        mov     si,string1   ; в регистре SI адрес строки, откуда копируем байты
        mov     di,string2  ; в регистре DI адрес строки, куда копируем байты

rep     movsb     ; выполняем компирование

        ; вывод полученной строки
        mov ah,9h
        mov dx, string2
        int 21h

        ; вывод текстового ссообщения
        mov ah, 9h
        mov     dx,exit_str
        int     21h

        mov ah,8h   ;ждать нажатия любой клавиши для выхода из программы
        int 21h
        ret

txt     db      "Transfer string example", 0dh, 0ah, '$'
exit_str        db      0dh, 0ah,"To exit now press any button...", 0dh, 0ah, '$'
string1    db      '0123456789012345','$'
string2    db      '****************',0dh, 0ah, '$'

