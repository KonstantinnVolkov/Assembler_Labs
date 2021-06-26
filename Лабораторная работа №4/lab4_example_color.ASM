        org 100h
start:

        mov ah,2h
        int 16h       ;получаем байт статуса

        test al,00000100B   ;проверяем бит 3 - CTRL
        JZ   start     ;если 0, то CTRL выключен

        mov ah,8h ; scan keypad
        int 21h

        cmp al, 20h ; probel check
        je next1
        jmp start
next1:
        mov     ah, 09h  ; вывод сообщения
        mov     bl, 0f9h ; синий текст на белом фоне
        mov     cx, 11   ; сообщение длиной 11 байт
        int     10h

        mov     dx,CTRL_probel
        int     21h
        jmp start
        ret
CTRL_probel    db     "CTRL_probel", $0d,$0a,'$'