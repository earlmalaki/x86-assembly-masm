TITLE ASM1 (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'
	INPUT1 DB ?
	INPUT2 DB ?
	INPUT3 DB ?
	DB '$'
DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
	MOV AX, DATASEG
	MOV DS, AX

	MOV AH, 10H
	INT 16
	MOV INPUT1, AL

	MOV AH, 10H
	INT 16
	MOV INPUT2, AL

	MOV AH, 10H
	INT 16
	MOV INPUT3, AL

	LEA DX, INPUT1
	MOV AH, 09H
	INT 21

	MOV AH, 4CH
	INT 21H
CODESEG ENDS
END START