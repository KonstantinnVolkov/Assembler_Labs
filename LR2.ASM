   org 100h

        ;����� ������ � �������
        mov ah, 09h
        mov dx, str1
        int 21h

        ;����� ������ � �������
        mov ah,09h
        mov dx, str2
        int 21h

        ;���� ������ �������������
        mov ah,0Ah
        mov dx, my_str
        int 21h

        ;������� �� ����� ������
        mov ah,09h
        mov dx, new_line
        int 21h

        ;������ 8-� � 9-� �������� ������
        mov bp, my_str+2 ; ����� ������� �������� ������
        mov bl,[bp-1]  ; ����������� ����� ������
        mov di,bx   ; ��������� �������� BX � DI
        mov cl,[bp+di-3] ; 8 ������� ������
        mov ch,[bp+di-2] ; 9 ������� ������
        xchg ch,cl        ;������ �������� �������
        mov [bp+di-2],ch  ;���������� � ������ ���������� ��������
        mov [bp+di-3],cl  ;���������� � ������ ���������� ��������

        ;��������� � ������
        mov ch,[bp+3]      ;4-� ������
        mov cl,[bp+6]      ;7-� ������
        sub ch,cl          ;S4-S7
        mov cl,[bp]        ;1-� ������
        sub cl,ch          ;S1-��������
        mov [bp+2],cl

        mov ah,09h
        mov dx, bp
        int 21h

        ;�������� ������� �������
        mov ah, 08h
        int 21h

   ret

str1    db "This program swaps first and last elements of the string",13,10, "$"
str2    db "Input string (max. 10 elements)", 13,10, "$"
my_str  db 11,0,11 dup('$')
new_line   db      $0d, $0A, "$"
