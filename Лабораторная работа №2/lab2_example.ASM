        org 100h

        ;вывод текста в консоль
        mov ah, 9h
        mov dx, str1
        int 21h

        ;вывод текста в консоль
        mov ah,9h
        mov dx, str2
        int 21h

        ;ввод строки пользователем
        mov ah,0Ah
        mov dx, my_str
        int 21h

        ;переход на новую строку
        mov ah,9h
        mov dx, new_line
        int 21h

        ;меняем первый и последний элементы строки
        mov bp, my_str+2 ; адрес первого элемента строки
        mov bl,[bp-1]  ; фактическая длина строки
        mov cl,[bp] ; первый элемент строки
        mov di,bx   ; сдержимое регистра BX в DI
        mov ch, [bp+di-1] ; последний элемент строки
        xchg ch,cl        ;меняем элементы местами
        mov [bp+di-1],ch  ;записываем в память измененное значение
        mov [bp],cl       ;записываем в память измененное значение

        ;вывод преобразованной строки в консоль
        mov ah,9h
        mov dx, bp
        int 21h

        ;ожидание нажатия клавиши
        mov ah, 8h
        int 21h

        ret

str1    db "This program swaps first and last elements of the string",$0d,$0a, "$"
str2    db "Input string (max. 10 elements)", $0d, $0a, "$"
my_str  db 11,0,11 dup('$')
new_line   db      $0d, $0A, "$"
