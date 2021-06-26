ESC_    equ     1Bh     ;ASCII-код клавиши ESC
F2      equ     3Ch     ;скан-код клавиши F2

        org 100h
start:

        mov ah,0h
        int 16h       ;чтение символа с клавиатуры

        cmp al, ESC_ ; ESC check
        je exit

        cmp al, 1Eh   ; нажата ли комбинация клавиш Ctrl+6
        je ctrl_six

        cmp ah, F2   ; нажата ли клавиша F2
        je F2_met
        jmp start

F2_met:
        ; вывод текстового ссообщения
        mov ah,9h
        mov dx, F2_str
        int     21h
        jmp start

ctrl_six:
        ; вывод текстового ссообщения
        mov ah,9h
        mov dx,ctrl_six_str
        int     21h
        jmp start

exit:
        mov ah, 2h
        mov     dl, '!'
        int     21h

        mov ah,8h   ;ждать нажатия любой клавиши для выхода из программы
        int 21h

        ret
NL    db     $0d,$0a,'$'
F2_str       db "F2",$0d,$0a,'$'
ctrl_six_str       db "CTRL+6",$0d,$0a,'$'