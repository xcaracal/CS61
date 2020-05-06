;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 24
; TA: David Feng
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R1
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------
RESTART
; output intro prompt
LD R0,introPromptPtr
PUTS		
; Set up flags, counters, accumulators as needed
AND R1,R1,#0
AND R5,R5,#0
LD R4,COUNTER_MAX ;COUNTER
; Get first character, test for '\n', '+', '-', digit/non-digit: 	

	GETC
	LD R2,NEWLINE_CHECK					;CHECKS I FIRST INPUT IS NEWLINE,IF SO SKIP TO END
	ADD R3,R0,R2
	BRz DONE_NEWLINE

	LD R2,POSITIVE_CHECK				;CHECKS IF POSITIVE,IF SO SET POS FLAG
	ADD R3,R0,R2
	BRz POS_FLAG

	LD R2,NEGATIVE_CHECK				;CHECKS IF NEGATIVE<IF SO SET NEG FLAG
	ADD R3,R0,R2
	BRz NEG_FLAG
	
	LD R6,SUB_ERROR_FLAG_3200			;RUNS ERROR FLAG SUBROUTINE IF CHAR IS INPUTTED
	JSRR R6
	ADD R3,R3,#0
	BRp ERROR
	
	BRnzp NUM_START						;MEANS ITS A NUMBER SO START IN LOOP WITHOUT ASKING FOR ANOTHER INPUT

	NEG_FLAG
		OUT
		ADD R5,R5,#-1
		ADD R3,R0,R2
		BRz NUM_LOOP
		
	POS_FLAG
		OUT
		ADD R5,R5,#1

	NUM_LOOP							;THIS IF FOR IF THEY PUT A NEGATIVE OR POSITIVE TO START ASKING FOR NEXT INPUT(NUMBER)
		GETC
		
		NUM_START					
		
		LD R2,NEWLINE_CHECK				;CHECKS IF NEWLINE TO FINISH CHECK
		ADD R3,R0,R2					;IF FIRST NUMBER PRINT ERROR
		BRz NEWLINE_FINISH_CHECK		;IF OTHER END AND NEWLINE
		
		LD R6,SUB_ERROR_FLAG_3200		;ERROR SUBROUTINE
		JSRR R6
		ADD R3,R3,#0
		BRp ERROR
		
		OUT								;PRINT OUT NUMBER(NO GHOST WRITING)
		
		ADD R4,R4,#0					;CHECKS IF COUNTER IS DONE THEN FINISH WITH NEWLINE
		BRz FINISH_CHECK
		
		LD R2,FIRST_NUM					;IF FIRST NUMBER(COUNTER IS AT 5 THEN DONT MULTIPLY BY TEN)
		ADD R3,R4,R2
		BRz ADD_FIRST_NUM
		BRnp CONT
		
		ADD_FIRST_NUM					;IF IT IS FIRST NUM
			LD R2,MIN
			ADD R0,R0,R2
			ADD R1,R1,R0
			ADD R4,R4,#-1
			BRzp NUM_LOOP
		
		CONT
			LD R6,SUB_ERROR_FLAG_3200	;ERROR SUBROUTINE
			JSRR R6
			ADD R3,R3,#0
			BRn NO_ERROR
			BRp ERROR
			
			ERROR
				ADD R0,R0,#0
				OUT
				
				LEA R0,NEWLINE
				PUTS
				
				LD R0,errorMessagePtr
				PUTS
				
				BRnzp RESTART
			
			NO_ERROR
			
			LD R2,MIN					;THIS MULTIPLYS BY TEN THANKS TO 2COMPLEMENT 
			ADD R0,R0,R2				;MAKES NUM CHAR TO VALUE CHAR IN BINARY
			ADD R1,R1,R1				;2X EX: (R1) CURRENTLY HOLD 5 AND (R0) 6 WE WANT 56
			ADD R6,R1,R1				;4X      SO WE MAKE IT SO 5 is now 50 to which the last line ADDS 6 to 50 stored in R1
			ADD R6,R6,R6				;8X
			ADD R1,R1,R6				;10x
			ADD R1,R0,R1
			
			ADD R4,R4,#-1				;DECREMENT LOOP
			BRp NUM_LOOP
			BRnzp FINISH_CHECK

	NEWLINE_FINISH_CHECK				;CHECKS IF NRWLINE IF FIRST NUM OR NOT FOR ERROR PURPOSES
	LD R2,FIRST_NUM
	ADD R3,R4,R2
	BRz ERROR
	
	FINISH_CHECK						;CHECKS IF ITS NEGATIVE TO CHANGE IT
		ADD R5,R5,#0
		BRzp DONE_NEWLINE
		BRn MAKE_NEG

	MAKE_NEG							;CHANGES IT TO NEGATIVE
		NOT R1,R1	
		ADD R1,R1,#1
			
	DONE_NEWLINE						;ADDS NEWLINE
		LEA R0,NEWLINE
		PUTS

	FIRST_NEWLINE
						HALT

;---------------	
; Program Data
;---------------
SUB_ERROR_FLAG_3200	.FILL x3200
NEWLINE				.STRINGZ "\n"
MIN					.FILL #-48
NEWLINE_CHECK		.FILL #-10
POSITIVE_CHECK		.FILL #-43
NEGATIVE_CHECK		.FILL #-45
COUNTER_MAX			.FILL x5
FIRST_NUM			.FILL #-5
ARR_PTR				.FILL ARR
introPromptPtr		.FILL xA800
errorMessagePtr		.FILL xA900


;------------
; Remote data
;------------
					.ORIG xA800			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xA900			; error message
					.STRINGZ	"ERROR! invalid input\n"

					.ORIG x4000
ARR					.BLKW		#6		


;==============================================================================
;SUBROUTINE:SUB_ERROR_FLAG_3200
;PARAMETER(R0):CHECK IF ITS A NUMBER
;POST CONDITION: IF ASCII 48 >= X <= 57 IT IS A NUMBER< ERROR OTHERWISE
;RETURN(R3) FLAGS WHETHER IT IS AN ERROR OR NOT TO PRIONT THE ERROR OR RESTART OR NOT
;=============================================================================
.ORIG x3200

;instructions
ST R2,BACKUP_R2_3200
ST R7,BACKUP_R7_3200

		LD R2,MIN_3200
		ADD R3,R0,R2
		BRn PROBLEM_YES
			
		LD R2,MAX_3200
		ADD R3,R0,R2
		BRp PROBLEM_YES
		BRnz PROBLEM_NO

PROBLEM_YES
AND R3,R3,#0
ADD R3,R3,#1
BRnzp END_3200

PROBLEM_NO
AND R3,R3,#0
ADD R3,R3,#-1

END_3200

LD R2,BACKUP_R2_3200
LD R7,BACKUP_R7_3200
RET
;data
BACKUP_R2_3200			.BLKW	#1
BACKUP_R7_3200			.BLKW	#1
MIN_3200					.FILL #-48
MAX_3200					.FILL #-57
;---------------
; END of PROGRAM
;---------------
					.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.


