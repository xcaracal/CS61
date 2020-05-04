;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000

;instructions
LD R1,ARR_PTR
LD R6,SUB_GET_STRING_3200

JSRR R6											;SUB_GET_STRING

LD R6,SUB_IS_PALINDROME_3400
JSRR R6

LEA R0,START_PROMPT
PUTS

AND R0,R0,#0
ADD R0,R1,#0
PUTS

ADD R4,R4,#0
BRz NO
BRp YES

YES
	LEA R0,PROMPT_YES
	PUTS
	ADD R4,R4,#0
	BRp FINISH

NO
	LEA R0,PROMPT_NO
	PUTS

FINISH
HALT
;data

ARR_PTR						.FILL	ARR
SUB_GET_STRING_3200			.FILL	x3200
SUB_IS_PALINDROME_3400		.FILL 	x3400
START_PROMPT				.STRINGZ	"The string \""
PROMPT_NO					.STRINGZ	"\" IS NOT a Palindrome"
PROMPT_YES					.STRINGZ	"\" IS a Palindrome"
NEWLINE						.STRINGZ	"\n"
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
;			END OF SUB ROUTINE 3200
;==================================================

;==================================================
;Subroutine: SUB_IS_PALINDROME_3400
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1) is
;					a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;==================================================
.ORIG x3400

;instructions
ST R0,BACKUP_R0_3400
ST R1,BACKUP_R1_3400
ST R2,BACKUP_R2_3400
ST R3,BACKUP_R3_3400
ST R7,BACKUP_R7_3400

LD R6,SUB_TO_UPPER_3600
JSRR R6

LOOP_3400
	LDR R2,R1,#0
	ADD R4,R1,R5
	ADD R4,R4,#-1
	LDR R3,R4,#0
	NOT R3,R3
	ADD R3,R3,#1
	
	ADD R2,R2,R3
		BRz Next_Spot
		BRnp NOT_PALIN
	
	NOT_PALIN
		AND R4,R4,#0
		ADD R2,R2,#0
		BRnp FINISH_3400
		
	Next_Spot
		ADD R1,R1,#1
		ADD R0,R1,R5
		ADD R0,R0,#-1
		NOT R0,R0
		ADD R0,R0,#1
		ADD R0,R0,R5
		BRz LOOP_3400
		BRnp DONE_3400
	
	DONE_3400
	AND R4,R4,#0
	ADD R4,R4,#1
	
FINISH_3400
END_LOOP_3400
	
LD R0,BACKUP_R0_3400
LD R1,BACKUP_R1_3400
LD R2,BACKUP_R2_3400
LD R3,BACKUP_R3_3400
LD R7,BACKUP_R7_3400


RET
;data
SUB_TO_UPPER_3600			.FILL	x3600
BACKUP_R0_3400				.BLKW	#1
BACKUP_R1_3400				.BLKW	#1
BACKUP_R2_3400				.BLKW	#1
BACKUP_R3_3400				.BLKW	#1
BACKUP_R7_3400				.BLKW	#1
;==================================================
;			END OF SUB ROUTINE 3400
;==================================================
;==================================================
; Subroutine: SUB_TO_UPPER_3600
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case ​ in-place
;
;i.e. the upper-case string has replaced the original string
; No return value, no output (but R1 still contains the array address, unchanged).
;==================================================
.ORIG x3600

;instructions
ST R0,BACKUP_R0_3600
ST R1,BACKUP_R1_3600
ST R2,BACKUP_R2_3600
ST R3,BACKUP_R3_3600
ST R4,BACKUP_R4_3600
ST R7,BACKUP_R7_3600

LD R3,CONVERTER
AND R4,R4,#0

LOOP_3600
	LDR R2,R1,#0
	AND R2,R2,R3
	STR R2,R1,#0
	ADD R4,R4,#-1
	ADD R1,R1,#1
	ADD R0,R4,R5
	BRnp LOOP_3600
END_LOOP_3600

LD R0,BACKUP_R0_3600
LD R1,BACKUP_R1_3600
LD R2,BACKUP_R2_3600
LD R3,BACKUP_R3_3600
LD R4,BACKUP_R4_3600
LD R7,BACKUP_R7_3600
RET

;data
BACKUP_R0_3600				.BLKW	#1
BACKUP_R1_3600				.BLKW	#1
BACKUP_R2_3600				.BLKW	#1
BACKUP_R3_3600				.BLKW	#1
BACKUP_R4_3600				.BLKW	#1
BACKUP_R7_3600				.BLKW	#1
CONVERTER					.FILL	x005F
;==================================================
;			END OF SUB ROUTINE 3600
;==================================================


.END
