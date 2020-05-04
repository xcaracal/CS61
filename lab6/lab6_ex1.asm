;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 6, ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000

;instructions
LD R1,ARR_PTR
LD R6,SUB_GET_STRING_3200

JSRR R6											;SUB_GET_STRING

HALT
;data

ARR_PTR						.FILL	ARR
SUB_GET_STRING_3200			.FILL	x3200
	;Remote Data
	.ORIG x4000
	ARR						.BLKW	#100
;==================================================
;Subroutine:SUB_GET_STRING
;Parameter(R1):Start Address of array
;Postcondition:The subroutine had prompt user to input a string,terminated by [ENTER]
;	(Sentinal) and has stored it in an array of characters starting at R1.
;	NULL TERMINATED(SENTINAL NOT STORED)
;Return Value(R5): num of non-sentinal characters read from user.
;	R1 Contains starting address of array unchanged
;==================================================
.ORIG x3200

;instructions
ST	R1,BACKUP_R1_3200
ST	R2,BACKUP_R2_3200
ST	R3,BACKUP_R3_3200
ST	R7,BACKUP_R7_3200

LD R2,NEWLINE_CHECK_3200
AND R5,R5,#0

LOOP_3200
	GETC
	
	ADD R3,R0,R2					;E3 CHECKS FOE THE SENTINAL AND ITERATES AND STORES OF ANYTHING ELSE BUT WILL LEAVE WITHOUT STOREING IF SENTINAL
	BRz END_3200
	BRnp ITERATE_3200
	
	ITERATE_3200
		OUT
		STR R0,R1,#0
		ADD R1,R1,#1
		ADD R5,R5,#1
		ADD R3,R3,#0
		BRnp LOOP_3200
	
	END_3200
		OUT
		LD R0,NEW_LINE_3200
		OUT
		
END_LOOP_3200

LEA R0,PRINT_MESSAGE_3200			;PRINT MESSAGE
PUTS

PRINT_LOOP_3200
	LD R0,BACKUP_R1_3200			;RESETS START OF ARRAY FOR PUTS IN R0
	PUTS
	LD R0,NEW_LINE_3200
	OUT
END_PRINT_LOOP
	

LD	R1,BACKUP_R1_3200
LD	R2,BACKUP_R2_3200
LD	R3,BACKUP_R3_3200
LD	R7,BACKUP_R7_3200
RET

;data
BACKUP_R1_3200				.BLKW	#1
BACKUP_R2_3200				.BLKW	#1
BACKUP_R3_3200				.BLKW	#1
BACKUP_R7_3200				.BLKW	#1
NEWLINE_CHECK_3200			.FILL	#-10
PRINT_MESSAGE_3200			.STRINGZ	"PRINT STRING: "
NEW_LINE_3200				.STRINGZ "\n"
;==================================================
;			END OF SUB ROUTINE
;==================================================

.END
