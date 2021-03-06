TITLE LAB3.1 (.EXE MODEL)
;
; EARL TIMOTHY MALAKI
; CMSC 131 LAB 3.1
;
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'

	INT_TEMP_READING DW 50
	; INT_TEMP_READING DW -273
	; INT_TEMP_READING DW 0
	; INT_TEMP_READING DW 29
	; INT_TEMP_READING DW 81

	INT_LEVEL_HOT DW 80				; EQUAL OR ABOVE THIS IS HOT
	INT_LEVEL_COLD DW 30			; EQUAL OR LESS THIS IS COLD
									; IN BETWEEN THIS TWO -- 30 < T < 80, IS NORMAL

	STRING_MSG_TOO_HOT DB "Too hot! Give yourself a shower.", '$'
	STRING_MSG_NORMAL DB "You", 27H, "re good. Stay alert.$", '$'
	STRING_MSG_TOO_COLD DB "Oh no! You", 27H, "re freezing.$", '$'


DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
	; initialize DS
	MOV AX, DATASEG
	MOV DS, AX

	;------------------


	MOV AX, INT_LEVEL_HOT
	CMP INT_TEMP_READING, AX
	JGE TOO_HOT
	JL NOT_TOO_HOT


TOO_HOT:
	MOV AH, 09H
	LEA DX, STRING_MSG_TOO_HOT
	INT 21H
	JMP EXIT

NOT_TOO_HOT:
	MOV AX, INT_LEVEL_COLD
	CMP INT_TEMP_READING, AX
	JG NORMAL
	JLE TOO_COLD
	JMP EXIT

NORMAL:
	MOV AH, 09H
	LEA DX, STRING_MSG_NORMAL
	INT 21H
	JMP EXIT

TOO_COLD:
	MOV AH, 09H
	LEA DX, STRING_MSG_TOO_COLD
	INT 21H
	JMP EXIT


;------------------

EXIT:
	; exit
	MOV AH, 4CH
	INT 21H
CODESEG ENDS
END START