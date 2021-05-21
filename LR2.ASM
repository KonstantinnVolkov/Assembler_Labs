   org 100h

        ;вывод текста в консоль
        mov ah, 09h
        mov dx, str1
        int 21h

        ;вывод текста в консоль
        mov ah,09h
        mov dx, str2
        int 21h

        ;ввод строки пользователем
        mov ah,0Ah
        mov dx, my_str
        int 21h

        ;переход на новую строку
        mov ah,09h
        mov dx, new_line
        int 21h

        ;мен€ем 8-й и 9-й элементы строки
        mov bp, my_str+2 ; адрес первого элемента строки
        mov bl,[bp-1]  ; фактическа€ длина строки
        mov di,bx   ; сдержимое регистра BX в DI
        mov cl,[bp+di-3] ; 8 элемент строки
        mov ch,[bp+di-2] ; 9 элемент строки
        xchg ch,cl        ;мен€ем элементы местами
        mov [bp+di-2],ch  ;записываем в пам€ть измененное значение
        mov [bp+di-3],cl  ;записываем в пам€ть измененное значение

        ;вычитание и замена
        mov ch,[bp+3]      ;4-й символ
        mov cl,[bp+6]      ;7-й символ
        sub ch,cl          ;S4-S7
        mov cl,[bp]        ;1-й символ
        sub cl,ch          ;S1-разность
        mov [bp+2],cl

        mov ah,09h
        mov dx, bp
        int 21h

        ;ожидание нажати€ клавиши
        mov ah, 08h
        int 21h

   ret

str1    db "This program swaps first and last elements of the string",13,10, "$"
str2    db "Input string (max. 10 elements)", 13,10, "$"
my_str  db 11,0,11 dup('$')
new_line   db      $0d, $0A, "$"
