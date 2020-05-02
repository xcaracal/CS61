;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 5, ex 2
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000
;Instructions
LEA R0,PROMPT			;OUTPUT PROMPT
PUTS

LEA R0,NEWLINE			;OUTPUT NEWLINE
PUTS

LD R6,BIN_TO_DEC_3200	;CALLS IPON SUBROUTINE
JSRR R6

HALT
;Data
BIN_TO_DEC_3200 .FILL	x3200
PROMPT			.STRINGZ "ENTER 16 (1 or 0) WITH A 'b' IN FRONT:"
NEWLINE			.STRINGZ "\n"
;===================================================
;Subroutine: BIN_TO_DEC_3200
;Input(R5): 
;POSTCONDITIONS:USES LEFT SHIFTING AND TWO COMP TO MOVE 1 AND ZEROS INTO THE RIGHT PLACE
;RETURN VALUE: DECIMAL VALUE STORED INTO R2
;===================================================
.ORIG x3200

;Instructions
ST R7, BACKUP_R7_3200
LD R1,COUNTER

GETC			;SO I DONT HAVE TO WORRY ABOUT b
OUT

START_LOOP
	GETC
	OUT
	ADD R2,R2,R2		;SHIFT LEFT
	
	IF
	LD R4,ASCII_ZERO	;IF CURR IS 1 then ADD 1 TO R2 DECREMENT LOOP OTHERWISE
	ADD R3,R0,R4
	BRz SKIP
	LD R4,ASCII_ONE
	ADD R3,R0,R4
	BRz COMP
	
	COMP
	ADD R2,R2,#1
	
	SKIP
	ADD R1,R1,#-1		;DECREMENT LOOP SINCE U ONLU WANT 16NUM AFTER 'b'
	BRp START_LOOP

LD R7, BACKUP_R7_3200
RET
;Data
BACKUP_R7_3200			.BLKW #1
ASCII_ZERO		.FILL	#-48
ASCII_ONE		.FILL	#-49
END				.FILL	#-1
COUNTER			.FILL	#16
;===================================================
;				END SUB_ROUTINE
;===================================================
.END

