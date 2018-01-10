; Earl Timothy Malaki
; CMSC 131 Laboratory
; Long Exam 2 Practical 2

TITLE TEMPLATE (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'

DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

START:
	MAIN PROC FAR
		MOV AX, DATASEG
		MOV DS, AX

		CALL _TERMINATE
	MAIN ENDP
;--------------------------------------------------
_GET_KEY PROC	NEAR

	MOV	AH, 01H	;check for input
	INT	16H

	JZ __LEAVETHIS

	MOV	AH, 00H	;get input	MOV AH, 10H; INT 16H
	INT	16H

	MOV	NEW_INPUT, AH		; AH for scan code, AL for ASCII equivalent

	__LEAVETHIS:
		RET
_GET_KEY ENDP
;--------------------------------------------------
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
_CLEAR_SCREEN PROC NEAR
	; BLACK
	MOV AX, 0600H		; fullscreen
	MOV BH, 0FH			; colors
	MOV CX, 0000H
	MOV DX, 184FH
	INT 10H

	; LIGHT CYAN
	MOV AX, 0600H
	MOV BH, 0B0H
	MOV CX, 0101H
	MOV DX, 174EH
	INT 10H

  RET
_CLEAR_SCREEN ENDP
;--------------------------------------------------
_SET_CURSOR PROC	NEAR
	MOV	AH, 02H		; request set cursor, use DX's values
	MOV	BH, 00		; page number
	INT	10H

	RET
_SET_CURSOR ENDP
;--------------------------------------------------
_TERMINATE PROC
	MOV AH, 4CH		; System.exit(0)
	INT 21H
_TERMINATE ENDP

CODESEG ENDS
END START