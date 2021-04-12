ESC_    equ     1Bh     ;скан-код клавиши ESC
F2      equ     3Ch     ;скан-код клавиши F2
F3      equ     3Dh     ;скан-код клавиши F3
F4      equ     3Eh     ;скан-код клавиши F4
F5      equ     3Fh     ;скан-код клавиши F5
G       equ     22h     ;скан-код клавиши G
H       equ     23h     ;скан-код клавиши H
J       equ     24h     ;скан-код клавиши J
K       equ     25h     ;скан-код клавиши K

        org 100h
start:

        mov ah,10h
        int 16h       ;чтение символа с клавиатуры

        cmp al, ESC_ ; ESC check
        je exit

        cmp ah, F2   ; нажата ли клавиша F2
        je F2_met

        cmp ah, F3   ; нажата ли клавиша F3
        je F3_met

        cmp ah, F4   ; нажата ли клавиша F4
        je F4_met

        cmp ah, F5   ; нажата ли клавиша F5
        je F5_met

        mov ah,08h
        int 21h

        cmp al,'{'
        je OUTPUT

        cmp al,'}'
        je OUTPUT

        cmp al,'|'
        je OUTPUT

        cmp al,'~'
        je OUTPUT

        mov ah,2h
        int 16h       ;получаем байт статуса

        test al,00001000B   ;проверяем бит 3 - ALT
        JE   start     ;если 0, то CTRL выключен

        mov ah,8h
        int 21h

        cmp al,G
        je ALT_G

        cmp al,H
        je ALT_H

        cmp al,J
        je ALT_J

        cmp al,K
        je ALT_K

        jne start

bell:
        ;Звоночек в ДУРКУ ЕБАТЬ
        mov ah,2h
        mov dl,7h
        int 21h

        ret

ALT_G:
        mov     ah, 09h  ; вывод сообщения
        mov     bl, 0f0h ; черный текст на сером фоне
        mov     cx, 5   ; сообщение длиной 5 байт
        int     10h

        mov dx,ALTG
        int 21h
        jmp start

ALT_H:
        mov     ah, 09h  ; вывод сообщения
        mov     bl, 0f1h ; черный текст на белом фоне
        mov     cx, 5   ; сообщение длиной 5 байт
        int     10h

        mov dx,ALTH
        int 21h
        jmp start

ALT_J:
        mov     ah, 09h  ; вывод сообщения
        mov     bl, 5Fh ; белый текст на фиолетовом фоне
        mov     cx, 5   ; сообщение длиной 5 байт
        int     10h

        mov dx,ALTJ
        int 21h
        jmp start

ALT_K:
        mov     ah, 09h  ; вывод сообщения
        mov     bl, 90h ; черный текст на бирюзовом фоне
        mov     cx, 5   ; сообщение длиной 5 байт
        int     10h

        mov dx,ALTK
        int 21h
        jmp start

F2_met:
        ; вывод текстового сообщения
        mov ah,9h
        mov al, 6
        int 29h

        mov ah, 9h
        mov dx, NL
        int 21h

        jmp start

F3_met:
        ; вывод текстового сообщения
        mov ah,9h
        mov al, 5
        int 29h

        mov ah, 9h
        mov dx, NL
        int 21h

        jmp start

F4_met:
        ; вывод текстового сообщения
        mov ah,9h
        mov al, 4
        int     29h

        mov ah, 9h
        mov dx, NL
        int 21h

        jmp start

F5_met:
        ; вывод текстового сообщения
        mov ah,9h
        mov al, 3
        int 29h

        mov ah, 9h
        mov dx, NL
        int 21h

        jmp start


OUTPUT:
        ; Вывод ограниченных символов
        mov ah,02h  ; ввод символа в консоль
        mov dl,al
        int 21h

        mov ah, 9h
        mov dx, NL
        int 21h

        jmp start


exit:
        mov ah, 9h
        mov     dx, exit_str
        int     21h

        mov ah,8h   ;ждать нажатия любой клавиши для выхода из программы
        int 21h

        ret

NL                db $0d,$0a,'$'
F2_str            db "F2",$0d,$0a,'$'
ctrl_six_str      db "CTRL+6",$0d,$0a,'$'
exit_str          db "To exit now press any button...",$0d,$0a,'$'
ALTG              db "ALT_G", $0d,$0a,'$'
ALTH              db "ALT_H", $0d,$0a,'$'
ALTJ              db "ALT_J", $0d,$0a,'$'
ALTK              db "ALT_K", $0d,$0a,'$'