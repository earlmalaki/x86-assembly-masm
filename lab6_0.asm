; Earl Timothy Malaki
; CMSC 131 Laboratory
; Lab 6 - Screen Processing

TITLE SCREEN PROCESSING (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'

	NEW_INPUT DB ?, 0AH, 0DH, "$"

	CONST_KEY_ESC DB 1BH

DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

START:
	;loop
	 ; clearscreen
	 ; get key
	  ; if arrow key, move to direction
	   ; move cursor
	   ; print character 
	  ; else if esc, exit program
	  ; else - stop moving
	 

	
	;--------------------------------------
	MAIN PROC FAR
		MOV AX, DATASEG
		MOV DS, AX

		CALL _ITERATE

	MAIN ENDP
	;--------------------------------------

	MOV AH, 4CH
	INT 21H
EXIT:
;--------------------------------------
_ITERATE PROC NEAR
	
	CALL _CLEAR_SCREEN
	CALL _GET_KEY

	CMP NEW_INPUT, 'S'
	JZ RETURN

	CALL _DELAY

	JMP _ITERATE

	RETURN:
		RET
_ITERATE ENDP
;--------------------------------------
_CLEAR_SCREEN PROC NEAR
	MOV AX, 0600H
	MOV BH, 0FH
	MOV CX, 0000H
	MOV DX, 184FH
	INT 10H

	MOV AX, 0600H
	MOV BH, 0B8H
	MOV CX, 0101H
	MOV DX, 174EH
	INT 10H

  RET
_CLEAR_SCREEN ENDP
;--------------------------------------
_GET_KEY PROC NEAR
	MOV AH, 01H		;check for input
	INT		16H

	JZ __LEAVETHIS

	MOV AH, 00H		;get input	MOV AH, 10H; INT 16H
	INT 16H

	MOV		NEW_INPUT, AH

	__LEAVETHIS:
		RET
_GET_KEY ENDP
;--------------------------------------
_DELAY PROC	NEAR
	mov bp, 2 ;lower value faster
	mov si, 2 ;lower value faster
		
	delay2:
		dec bp
		nop
		jnz delay2
		dec si
		cmp si,0
		jnz delay2
		RET
_DELAY ENDP
;--------------------------------------
_TERMINATE PROC NEAR
	MOV AH, 4CH
	INT 21H
_TERMINATE ENDP


CODESEG ENDS
END START