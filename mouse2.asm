TITLE TEMPLATE (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'
	merr db "Mouse error!",0 ; (Put to the end if not TASM)
DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

START:
	MAIN PROC FAR
		MOV AX, DATASEG
		MOV DS, AX

		mov  ax, 3h
 int  33h
 mov  mouseClick, bx
 mov  mouseX, cx
 mov  mouseY, dx
 call checkMClick
 cmp  mousePos, 1h
 je   goodMPos
 jne  badMPos

 goodMPos:

 call firstLevel   
 call newMazePos
 call output

;---------------------------------------;                            

 checkMClick: cmp  mouseclick, 1h 
              je   checkMouseX
              jne  mouse  

 checkMouseX: cmp  mouseX, 7h
              jge  afterStartX
              jl   mouse

 afterStartX: cmp  mouseX, 23h
              jle  goodXPos
              jg   badMPos

 goodXPos:    mov  mousePos, 1h
              jmp  checkMouseY

 checkMouseY: cmp  mouseY, 7h
              jge  afterStartY
              jl   mouse

 afterStartY: cmp  mouseY, 11h
              jge  goodYPos
              jl   badMPos                 

 goodYPos:    mov  mousePos, 1h
              ret                 

 badMPos:     mov  mousePos, 0h
              jmp  mouse

		CALL _TERMINATE
	MAIN ENDP	
;--------------------------------------------------
_TERMINATE PROC
	MOV AH, 4CH		; System.exit(0)
	INT 21H
_TERMINATE ENDP

CODESEG ENDS
END START