ESC_    equ     1Bh     ;ASCII-код клавиши ESC
F2      equ     3Ch     ;скан-код клавиши F2
F3      equ     3Dh     ;скан-код клавиши F3
F4      equ     3Eh     ;скан-код клавиши F4
F5      equ     3Fh     ;скан-код клавиши F5
G       equ     67H     ;ASCII-код клавиши G
H       equ     68h     ;ASCII-код клавиши H
J       equ     6Ah     ;ASCII-код клавиши J
K       equ     6Bh     ;ASCII-код клавиши K

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
        je  OUTPUT
        ;jne start

        cmp al,'}'
        je  OUTPUT
        ;jne start

        cmp     al,'|'
        je  OUTPUT
        ;jne start

        cmp     al,'~'
        je  OUTPUT

        ;mov ah,2h
        ;int 16h       ;получаем байт статуса

        ;test al,00000100B   ;проверяем бит 3 - CTRL
        ;JZ   start     ;если 0, то CTRL выключен

        mov ah,10h
        int 16h

        cmp al,G
        je Color_1
        jne start

        jmp start

Color_1:
        ;gray backgrnd with black text
        mov ah,9h
        mov bl,0f9h
        mov cx,11
        int 10h
        jmp start

F2_met:
        ; вывод текстового ссообщения
        mov ah,9h
        mov al, 6
        int 29h

        mov ah, 9h
        mov dx, NL
        int 21h

        jmp start

F3_met:
        ; вывод текстового ссообщения
        mov ah,9h
        mov al, 5
        int 29h

        mov ah, 9h
        mov dx, NL
        int 21h

        jmp start

F4_met:
        ; вывод текстового ссообщения
        mov ah,9h
        mov al, 4
        int     29h

        mov ah, 9h
        mov dx, NL
        int 21h

        jmp start

F5_met:
        ; вывод текстового ссообщения
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

NL                 db     $0d,$0a,'$'
F2_str             db "F2",$0d,$0a,'$'
ctrl_six_str       db "CTRL+6",$0d,$0a,'$'
exit_str           db "To exit now press any button...",$0d,$0a,'$'