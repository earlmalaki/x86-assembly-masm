TITLE ASM1 (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'
	LINE1 DB "* * * * *          *           * * * *        *           ", 0AH, 0DH
	LINE2 DB "*                 * *          *      *       *           ", 0AH, 0DH
	LINE3 DB "*                *   *         *       *      *           ", 0AH, 0DH
	LINE4 DB "*               *     *        *      *       *           ", 0AH, 0DH
	LINE5 DB "* * *          * * * * *       * * * *        *           ", 0AH, 0DH
	LINE6 DB "*             *         *      *      *       *			", 0AH, 0DH
	LINE7 DB "*            *           *     *       *      *           ", 0AH, 0DH
	LINE8 DB "*           *             *    *        *     *           ", 0AH, 0DH
	LINE9 DB "* * * * *  *               *   *         *    * * * * *	", 0AH, 0DH
	LINE10 DB "$"
DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
	MOV AX, DATASEG
	MOV DS, AX

	LEA DX, LINE1
	MOV AH, 09
	INT 21H

	MOV AH, 4CH
	INT 21H
CODESEG ENDS
END START