.286
.MODEL TINY

_CODE SEGMENT PARA PUBLIC 'CODE' USE16
    ASSUME CS:_CODE, DS:_CODE 
    ORG 100h

 __START__:

    call initGraphics                   ;Get into graphic mode and show cursor 

    push 08h 
    push 08h 
    push OFFSET barCursor
    call setCursor 

    xor ah, ah
    int 16h

    push 08h 
    push 08h 
    push OFFSET checkerCursor
    call setCursor 

    xor ah, ah
    int 16h

    call finalizeGraphics

    mov ax, 4c00h
    int 21h 

    ;
    ; PROCEDURES
    ;

    ;Set graphic mode, reset mouse and show cursor
 initGraphics:
    push es

    mov ax, 13h
    int 10h

    push 0a000h
    pop es 
    xor di, di 
    mov ax, 0909h
    mov cx, 320*200/2 
    rep stosw 

    xor ax, ax 
    int 33h 

    mov ax, 01h 
    int 33h

    pop es
    ret

 ;Hide cursor and set text mode
 finalizeGraphics:
    mov ax, 02h
    int 33h 

    mov ax, 03h 
    int 10h 

    ret 

 ;Set cursor
 ;Hotspot X
 ;Hotspot Y
 ;Ptr to cursor bitmaps
 setCursor:
    push bp 
    mov bp, sp

    pusha
    push es

    mov ax, 09h
    mov bx, WORD PTR [bp+08h]
    mov cx, WORD PTR [bp+06h]
    mov dx, WORD PTR [bp+04h]
    push ds                         ;Setting ES = DS is not necessary in COM
    pop es                          ;files unless somebody changed ES
    int 33h 

    pop es
    popa

    pop bp  
    ret 06h     


    ;
    ; CURSORS
    ;

    barCursor       dw  16 DUP(0fe7fh)
                    dw  16 DUP(0180h)

    checkerCursor   dd  8 DUP(5555aaaah)
                    dd  8 DUP(0aaaa5555h)

_CODE ENDS 

END __START__