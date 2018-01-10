TITLE ASM1 (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'
	MSG1 DB "> Enter initial of first name: ", '$'
	MSG2 DB "> Enter initial of middle name: ", '$'
	MSG3 DB "> Enter initial of last name: ", '$'

	NEWLINE DB 0AH, 0DH, '$'

	OUTMSG1 DB "Initial of your first name is "
	INPUT1 DB ?
	OUTMSG2 DB ", middle name is "
	INPUT2 DB ?
	OUTMSG3 DB " and last name is "
	INPUT3 DB ?
	OUTMSG4 DB "!", '$'

	FINALOUT DB ?

DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
	MOV AX, DATASEG
	MOV DS, AX

	LEA DX, MSG1
	MOV AH, 09
	INT 21H

	MOV AH, 10H
	INT 16H
	MOV INPUT1, AL

	LEA DX, NEWLINE
	MOV AH, 09
	INT 21H


	LEA DX, MSG2
	MOV AH, 09
	INT 21H

	MOV AH, 10H
	INT 16H
	MOV INPUT2, AL

	LEA DX, NEWLINE
	MOV AH, 09
	INT 21H


	LEA DX, MSG3
	MOV AH, 09
	INT 21H

	MOV AH, 10H
	INT 16H
	MOV INPUT3, AL

	LEA DX, NEWLINE
	MOV AH, 09
	INT 21H
	LEA DX, NEWLINE
	MOV AH, 09
	INT 21H


	LEA DX, OUTMSG1
	MOV AH, 09
	INT 21H


	MOV AH, 4CH
	INT 21H
CODESEG ENDS
END START