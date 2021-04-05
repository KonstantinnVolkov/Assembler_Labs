        org 100h


start:
                mov ah, 09h
                mov dx, inputC          
                int 21h

                mov ah, 0ah            
                mov dx, strC           
                int 21h

                mov bx, dx              
                call count_number       ;извлекаем из строки число C
                push ax                

                mov ah, 02h            
                mov dx, 0x0D0A         
                int 21h

                mov ah, 09h
                mov dx, inputD         
                int 21h

                mov ah, 0ah
                mov dx, strD            
                int 21h

                mov bx, dx
                call count_number      
                push ax               

                call get_result         ;получаем результат вычислений


                mov ax, [res]           ;перемещаем в ах результат для последующего вывода ответ
                call output_number      ;вывод ответа

                pop ax                  ;чистим стек
                pop ax

                mov ah, 8h 
                int 21h
                ret

count_number:                   ;процедура получения числа из строки
                xor ax, ax      ;обнуляем ах
                xor dx, dx      ;обнуляем dx

                add bx, 1h      ;передвигаем адрес строки на 1
                mov cl, [bx]    ;захватываем 1 байт, в котором находится фактическая длина строки

lp:                             ;цикл получения числа
                inc bx          ;увеличиваем указатель на строку на 1
                mul [cm]        ;умножаем на 10
                add al, [bx]    ;прибавляем цифру
                sub ax, '0'     ;убираем код '0'

                loop lp         ;уменьшаем регистр сх на 1, сравниваем с нулем, если не ноль, то повторяем цикл

                ret


output_number:                   ;процедура вывода числа на экран
                push '*'        ;запоминаем, что концом числа в стеке будет символ *

lpt:                            ;цикл разбиения числа на цифры и передача его в стек
                div [cm]        ;деление числа на 10, остаток уходит в dx
                push dx         ;добавляем в стек остаток от деления
                xor dx, dx      ;очищаем dx от уже занесенного результата
                cmp ax, 0h      ;сравниваем результат деления с 0
                jne lpt         ;если не 0, то заново цикл


                mov ah, 02h
                mov dx, 0x0D0A
                int 21h

lpp:                            ;цикл вывода числа
                pop bx          ;вытаскиваем число из стека

                cmp bx, '*'     ;если конец стека
                je endst        ;то выходим из цикла

                add bx, '0'     ;иначе добавляем '0' чтобы получить символ

                mov ah, 02h
                mov dx, bx      ;выводим символ
                int 21h

                jmp lpp         ;повторяем цикл

endst:          ret             ;выходим

get_result:
                mov bp, sp      ;в регистр bp передаем указатель на стек для доступа к другим переменным стека

         ;<передача параметра через регистры>
  
                mov ax, [bp+2]  ;в регистр ax передаем переменную D
                mul ax          ;в ax D^2
                add ax,1h       ;D^2+1
                mov cx,ax

                mov ax, [bp+4]  ;в регистр ах передаем переменную C

                call proc1 ;вызов процедуры

                mov ah,9h
                mov dx, new_line
                int 21h

                ;вывод текста в консоль
                mov ah,9h
                mov dx, regRes
                int 21h

                ;вывод в консоль результата
                mov ah,2h
                mov dx, [res]
                int 21h

                ;переход на новую строку
                mov ah,9h
                mov dx, new_line
                int 21h

          ;</передача параметра через регистры>

          ;<передача параметра через глобальные переменные>
  
                mov ax, [bp+2]           ;в регистр ax передаем переменную D
                mul ax                   ;в ax D^2
                add ax,1h                ;D^2+1
                mov cx, ax
                mov [D], cx
                xor ax,ax
                
                mov ax, [bp+4]  ;в регистр ах передаем переменную C
                mov [C], ax  

                call proc2 ;вызов процедуры

          ;</передача параметра через глобальные переменные>

                ;вывод текста в консоль 
                mov ah,9h
                mov dx, globalRes
                int 21h

                ;вывод в консоль результата
                mov ah,2h
                mov dx, [res]
                int 21h

                ;переход на новую строку
                mov ah,9h
                mov dx, new_line
                int 21h

            ;<Через стек>
  
                mov ax, [bp+2]             ;в регистр ax передаем переменную D
                mul ax                     ;в ax D^2
                add ax,1h                  ;D^2+1
                mov cx, ax
                push cx                    ;сохраняем в стек значение

                mov ax, [bp+4]  ;в регистр ах передаем переменную C
                mov bx, ax
                push bx ;сохраняем в стек значение

                call proc3 ;вызов процедуры

           ;</Через стек>

                ;вывод текста в консоль
                mov ah,9h
                mov dx, stackRes
                int 21h

                ;вывод в консоль результата
                mov ah,2h
                mov dx, [res]
                int 21h

                ;переход на новую строку
                mov ah,9h
                mov dx, new_line
                int 21h

                ;ожидание нажатия клавиши
                mov ah, 8h 
                int 21h


                ret             ;выходим из процедуры


proc1:
                div cx          ;C/(D^2+1)
                add ax,1h       ;C/(D^2+1)+1
                mov bx,ax

                ;sub bx, 48
                ;add bx, '0'
                mov [res], bx   ;сохраняем результат

                ret

proc2:
                mov ax, [C]  ; извлекаем параметр C
                mov cx, [D]  ; извлекаем параметр D
                div cx       ;C/(D^2+1)
                add ax,1h    ;C/(D^2+1)+1
                mov bx,ax

                ;sub bx, 48
                ;add bx, '0'  ;перевод в ASCII код
                mov [res], bx  ; сохраняем значение в памяти

                ret

proc3:
                pop bx        ; извлекаем C
                pop cx        ; извлекаем параметр D^2+1
                pop dx        ; извлекаем адрес возврата к основной программе
                mov ax,bx
                div cx        ;C/(D^2+1)
                add ax,1h     ;C/(D^2+1)+1
                mov bx,ax

                ;sub bx, 48
                ;add bx, '0'   ;перевод в ASCII код
                mov [res], bx  ; сохраняем значение в памяти
                push dx ; возвращаем на место адрес возврата к основной программе

                ret




inputC          db "Enter number C: $"
inputD          db "Enter number D: $"
regRes          db "Register procedure result is $"
globalRes       db "Memory procedure result is $"
stackRes        db "Stack procedure result is $"
strC            db 10, 0, 10 dup(?)
strD            db 10, 0, 10 dup(?)
numC            dw 0h
numD            dw 0h
new_line        db $0d, $0A, "$"
cm              dw 10
C               dw 0h
D               dw 0h
res             dw 0h

