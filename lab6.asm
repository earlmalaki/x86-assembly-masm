; Earl Timothy Malaki
; CMSC 131 Laboratory
; Lab 6 - Screen Processing

TITLE SCREEN PROCESSING (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'

	NEW_INPUT DB ?, '$'

	CTR_X DB ?
	CTR_Y DB ?

	CHAR_A DB 'A', '$'
	CONST_KEY_ESC DB 1BH


DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

START:
	MAIN PROC FAR
		MOV AX, DATASEG
		MOV DS, AX

		MOV NEW_INPUT, 4DH		; initialize input to right arrow key to make the cursor move rightwards
		MOV CTR_X, 01H			; initialize to leftmost column
		MOV CTR_Y, 0CH			; initialize to center row

		CALL _ITERATE

		CALL _TERMINATE
	MAIN ENDP
;--------------------------------------------------
_ITERATE PROC NEAR

	CALL _CLEAR_SCREEN		; paint screen light cyan with black borders
	CALL _GET_KEY			; listen for key press
	
	CALL _CHECK_INPUT		; check input from _GET_KEY if arrow/esc/etc

	MOV DL, CTR_X			; set CTR_X to row
	MOV DH, CTR_Y			; set CTR_Y to col
	CALL _SET_CURSOR		; set cursor using DX's values

	MOV AH, 09H
	LEA DX, CHAR_A			; print 'A' at cursor
	INT 21H

	CALL _DELAY				; delay screen update

	CALL _ITERATE			; loop

_ITERATE ENDP
;--------------------------------------------------
_CHECK_INPUT PROC NEAR
	; check key press
	CMP NEW_INPUT, 01H		; scan code for ESC key
	JE _BREAK

	CMP NEW_INPUT, 48H		; scan code for up arrow
	JE _UP

	CMP NEW_INPUT, 50H		; scan code for down arrow
	JE _DOWN

	CMP NEW_INPUT, 4BH		; scan code for left arrow
	JE _LEFT

	CMP NEW_INPUT, 4DH		; scan code for right arrow
	JE _RIGHT

	JMP _CONTINUE

	_UP:
		DEC CTR_Y
		CMP CTR_Y, 01H
		JLE _WRAPTO_BOT

		JMP _CONTINUE

		_WRAPTO_BOT:
			MOV CTR_Y, 17H
			JMP _CONTINUE

	_DOWN:
		INC CTR_Y
		CMP CTR_Y, 17H
		JGE _WRAPTO_TOP

		JMP _CONTINUE

		_WRAPTO_TOP:
			MOV CTR_Y, 01H
			JMP _CONTINUE

	_LEFT:
		DEC CTR_X
		CMP CTR_X, 01H
		JLE _WRAPTO_RIGHT

		JMP _CONTINUE

		_WRAPTO_RIGHT:
			MOV CTR_X, 4EH
			JMP _CONTINUE

	_RIGHT:
		INC CTR_X
		CMP CTR_X, 4EH
		JGE _WRAPTO_LEFT

		JMP _CONTINUE

		_WRAPTO_LEFT:
			MOV CTR_X, 01H
			JMP _CONTINUE

	_CONTINUE:
		RET

	_BREAK:
		CALL _TERMINATE
_CHECK_INPUT ENDP
;--------------------------------------------------
_GET_KEY PROC	NEAR

	MOV	AH, 01H				; passively check for any input from keyboard
	INT	16H					; listen for input key without stopping whole process

	JZ __LEAVETHIS 			; if no key entry, leave proc

	MOV	AH, 00H				; if has key entry, store key input
	INT	16H

	MOV	NEW_INPUT, AH		; store input to variable
							; AH for scan code equivalent, AL for ASCII equivalent

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
	MOV DX, 1700H		; set cursor to bottom left of screen
	CALL _SET_CURSOR

	MOV AH, 4CH		; System.exit(0)
	INT 21H
_TERMINATE ENDP

CODESEG ENDS
END START