        org 100h


start:
                mov ah, 09h
                mov dx, inputC          
                int 21h

                mov ah, 0ah            
                mov dx, strC           
                int 21h

                mov bx, dx              
                call count_number       ;��������� �� ������ ����� C
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

                call get_result         ;�������� ��������� ����������


                mov ax, [res]           ;���������� � �� ��������� ��� ������������ ������ �����
                call output_number      ;����� ������

                pop ax                  ;������ ����
                pop ax

                mov ah, 8h 
                int 21h
                ret

count_number:                   ;��������� ��������� ����� �� ������
                xor ax, ax      ;�������� ��
                xor dx, dx      ;�������� dx

                add bx, 1h      ;����������� ����� ������ �� 1
                mov cl, [bx]    ;����������� 1 ����, � ������� ��������� ����������� ����� ������

lp:                             ;���� ��������� �����
                inc bx          ;����������� ��������� �� ������ �� 1
                mul [cm]        ;�������� �� 10
                add al, [bx]    ;���������� �����
                sub ax, '0'     ;������� ��� '0'

                loop lp         ;��������� ������� �� �� 1, ���������� � �����, ���� �� ����, �� ��������� ����

                ret


output_number:                   ;��������� ������ ����� �� �����
                push '*'        ;����������, ��� ������ ����� � ����� ����� ������ *

lpt:                            ;���� ��������� ����� �� ����� � �������� ��� � ����
                div [cm]        ;������� ����� �� 10, ������� ������ � dx
                push dx         ;��������� � ���� ������� �� �������
                xor dx, dx      ;������� dx �� ��� ����������� ����������
                cmp ax, 0h      ;���������� ��������� ������� � 0
                jne lpt         ;���� �� 0, �� ������ ����


                mov ah, 02h
                mov dx, 0x0D0A
                int 21h

lpp:                            ;���� ������ �����
                pop bx          ;����������� ����� �� �����

                cmp bx, '*'     ;���� ����� �����
                je endst        ;�� ������� �� �����

                add bx, '0'     ;����� ��������� '0' ����� �������� ������

                mov ah, 02h
                mov dx, bx      ;������� ������
                int 21h

                jmp lpp         ;��������� ����

endst:          ret             ;�������

get_result:
                mov bp, sp      ;� ������� bp �������� ��������� �� ���� ��� ������� � ������ ���������� �����

         ;<�������� ��������� ����� ��������>
  
                mov ax, [bp+2]  ;� ������� ax �������� ���������� D
                mul ax          ;� ax D^2
                add ax,1h       ;D^2+1
                mov cx,ax

                mov ax, [bp+4]  ;� ������� �� �������� ���������� C

                call proc1 ;����� ���������

                mov ah,9h
                mov dx, new_line
                int 21h

                ;����� ������ � �������
                mov ah,9h
                mov dx, regRes
                int 21h

                ;����� � ������� ����������
                mov ah,2h
                mov dx, [res]
                int 21h

                ;������� �� ����� ������
                mov ah,9h
                mov dx, new_line
                int 21h

          ;</�������� ��������� ����� ��������>

          ;<�������� ��������� ����� ���������� ����������>
  
                mov ax, [bp+2]           ;� ������� ax �������� ���������� D
                mul ax                   ;� ax D^2
                add ax,1h                ;D^2+1
                mov cx, ax
                mov [D], cx
                xor ax,ax
                
                mov ax, [bp+4]  ;� ������� �� �������� ���������� C
                mov [C], ax  

                call proc2 ;����� ���������

          ;</�������� ��������� ����� ���������� ����������>

                ;����� ������ � ������� 
                mov ah,9h
                mov dx, globalRes
                int 21h

                ;����� � ������� ����������
                mov ah,2h
                mov dx, [res]
                int 21h

                ;������� �� ����� ������
                mov ah,9h
                mov dx, new_line
                int 21h

            ;<����� ����>
  
                mov ax, [bp+2]             ;� ������� ax �������� ���������� D
                mul ax                     ;� ax D^2
                add ax,1h                  ;D^2+1
                mov cx, ax
                push cx                    ;��������� � ���� ��������

                mov ax, [bp+4]  ;� ������� �� �������� ���������� C
                mov bx, ax
                push bx ;��������� � ���� ��������

                call proc3 ;����� ���������

           ;</����� ����>

                ;����� ������ � �������
                mov ah,9h
                mov dx, stackRes
                int 21h

                ;����� � ������� ����������
                mov ah,2h
                mov dx, [res]
                int 21h

                ;������� �� ����� ������
                mov ah,9h
                mov dx, new_line
                int 21h

                ;�������� ������� �������
                mov ah, 8h 
                int 21h


                ret             ;������� �� ���������


proc1:
                div cx          ;C/(D^2+1)
                add ax,1h       ;C/(D^2+1)+1
                mov bx,ax

                ;sub bx, 48
                ;add bx, '0'
                mov [res], bx   ;��������� ���������

                ret

proc2:
                mov ax, [C]  ; ��������� �������� C
                mov cx, [D]  ; ��������� �������� D
                div cx       ;C/(D^2+1)
                add ax,1h    ;C/(D^2+1)+1
                mov bx,ax

                ;sub bx, 48
                ;add bx, '0'  ;������� � ASCII ���
                mov [res], bx  ; ��������� �������� � ������

                ret

proc3:
                pop bx        ; ��������� C
                pop cx        ; ��������� �������� D^2+1
                pop dx        ; ��������� ����� �������� � �������� ���������
                mov ax,bx
                div cx        ;C/(D^2+1)
                add ax,1h     ;C/(D^2+1)+1
                mov bx,ax

                ;sub bx, 48
                ;add bx, '0'   ;������� � ASCII ���
                mov [res], bx  ; ��������� �������� � ������
                push dx ; ���������� �� ����� ����� �������� � �������� ���������

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

