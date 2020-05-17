;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 7, ex 2
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000
;instructions
LD R2,ASCII

LEA R0,MSG
PUTS

LEA R0,NEWLINE
PUTS

GETC
OUT
ADD R1,R0,#0

LEA R0,NEWLINE
PUTS

LD R6,FIND_ONE
JSRR R6

LEA R0,MSG2
PUTS

ADD R0,R1,#0
OUT

LEA R0,MSG3
PUTS

ADD R0,R2,#0
OUT

HALT
;data
MSG				.STRINGZ	"ENTER ONE CHARACTER: "
NEWLINE			.STRINGZ		"\n"
MSG2			.STRINGZ	"The number of 1's in '"
MSG3			.STRINGZ	"' is: "
FIND_ONE		.FILL		x3200
ASCII			.FILL		#48
;=================================================
;Subroutine:FIND_ONE
;Parameter(R1):The ASCII Char
;Postcondition:Basically keeps shifting left To see if its a one or zero
;Return Value(R2): Number of ones
;=================================================
.ORIG x3200
;instructions

ST R7,BACKUP_R7_3200
ST R1,BACKUP_R1_3200
ST R3,BACKUP_R3_3200
LD R3,COUNTER

LOOP_3200
	ADD R1,R1,#0
	BRzp SKIP
	BRn INCREMENT
	
	INCREMENT
	ADD R2,R2,#1
	
	SKIP
		ADD R1,R1,R1
		ADD R3,R3,#-1
		BRz END
		BRnp LOOP_3200
	
END

LD R7,BACKUP_R7_3200
LD R1,BACKUP_R1_3200
LD R3,BACKUP_R3_3200

RET
;data
BACKUP_R7_3200			.BLKW #1
BACKUP_R1_3200			.BLKW #1
BACKUP_R3_3200			.BLKW #1
COUNTER 				.FILL #16
;=================================================
;				END 3200
;=================================================

.END
