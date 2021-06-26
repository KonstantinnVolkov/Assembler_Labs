        org 100h

        ;вывод текста в консоль
        mov ah, 9h
        mov dx, str1
        int 21h

        ;вывод текста в консоль
        mov ah,9h
        mov dx, str2
        int 21h

        ;передача параметра через регистры

        mov bx, 2h ; A = 2
        mov cx, 4h ; B = 4
        call proc1 ;вызов процедуры

        ;вывод текста в консоль
        mov ah,9h
        mov dx, str3
        int 21h

        ;вывод в консоль результата
        mov ah,2h
        mov dx, bx
        int 21h

        ;переход на новую строку
        mov ah,9h
        mov dx, new_line
        int 21h


        ;передача параметра через глобальные переменные

        mov bx, 2h ; A = 2
        mov cx, 4h ; B = 4
        mov [A], bx ;сохраняем в ЯП значение
        mov [B], cx ;сохраняем в ЯП значение
        call proc2 ;вызов процедуры

        ;вывод текста в консоль
        mov ah,9h
        mov dx, str4
        int 21h

        ;вывод в консоль результата
        mov ah,2h
        mov dx, [res]
        int 21h

        ;переход на новую строку
        mov ah,9h
        mov dx, new_line
        int 21h


        ;передача параметра через стек

        mov bx, 2h ; A = 2
        mov cx, 4h ; B = 4
        push bx ;сохраняем в стек значение
        push cx ;сохраняем в стек значение
        call proc3 ;вызов процедуры

        ;вывод текста в консоль
        mov ah,9h
        mov dx, str5
        int 21h

        ;вывод в консоль результата
        mov ah,2h
        mov dx, bx
        int 21h

        ;переход на новую строку
        mov ah,9h
        mov dx, new_line
        int 21h

        ;ожидание нажатия клавиши
        mov ah, 8h
        int 21h

        ret
proc1:
        add bx, cx ;сумма
        add bx, '0' ;перевод в ASCII код
        ret

proc2:
        mov bx, [A]  ; извлекаем параметр A
        mov cx, [B]  ; извлекаем параметр B
        add bx, cx  ;сумма
        add bx, '0'  ;перевод в ASCII код
        mov [res], bx  ; сохраняем значение в памяти

        ret


proc3:
        pop dx  ; извлекаем адрес возврата к основной программе
        pop cx ; извлекаем параметр B
        pop bx ; извлекаем параметр A
        add bx,cx ;сумма
        add bx, '0' ;перевод в ASCII код
        push dx ; возвращаем на место адрес возврата к основной программе
        ret




str1    db "This program will show you how to use procedures in FASM",$0d,$0a, "$"
str2    db "We will calculate y = a+b", $0d, $0a, "$"
str3    db "Register procedure result is $"
str4    db "Memory procedure result is $"
str5    db "Stack procedure result is $"
new_line   db      $0d, $0A, "$"
A       dw 0h
B       dw 0h
res     dw 0h
