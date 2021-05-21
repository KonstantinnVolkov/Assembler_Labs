; Calculate and print result of y=(3*a+(b-c))/(d+2)
; v6
; y should be < 9 or 8, else - result will be a symbol from ASCII, not number 
  org 100h;
start: 
        mov ah, 09h             ; DOS function to write text on the screen
        mov dx, name_prog       ; Passing function args to registers
        int 21h                 ; DOS interruption to execute functions
 
        mov ah, 02h     ; DOS function to write ASCII symbol
        mov dx, 0x0D0A  ; \n code in ASCII
        int 21h
 
        mov ah, 09h
        mov dx, str2
        int 21h
 
        mov ah, 02h
        mov dx, 0x0D0A
        int 21h
 
        mov ah, 09h
        mov dx, result_is
        int 21h

        ; <chiclitel'>
        mov bx, [a]
        mov ax, $03
        mul bx         ;3*a - result is in AX
 
        mov bx, [b]
        mov cx, [c]
        sub bx,cx      ;(b-c) - result is in BX

        add ax,bx       ;3a + (b-c) - result in AX
        ;</chiclitel'>

        ;<znamenatel'>
        mov bx, [d]
        mov cx, $02
        add bx,cx       ;d+2 - result is in AX
        ;</znamenatel'>

        div bx;
        add ax, '0'; Convert to ASCII code
 
        ; <print result>
        mov bx, ax; send result from AX to BX, because AH will be used to print result
        mov ah, 02h
        mov dx, bx
        int 21h
 
        mov ah, 08h
        int 21h
        ; </print result>
        ret
 
name_prog       db "This program calculates y=(3*a+(b-c))/(d+2)$"
str2            db "where a=1, b=10, c=5, d=2$"
result_is       db "result is equal to $"
a               dw 3
b               dw 10
c               dw 5
d               dw 2