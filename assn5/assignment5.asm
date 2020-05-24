;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 24
; TA: David Feng
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

MENU_LOOP
	LD R6,MENU
	JSRR R6
	
	ADD R2,R1,#0
	ADD R2,R2,#-1
	BRz ONE
	
	ADD R2,R1,#0
	ADD R2,R2,#-2
	BRz TWO
	
	ADD R2,R1,#0
	ADD R2,R2,#-3
	BRz THREE
	
	ADD R2,R1,#0
	ADD R2,R2,#-4
	BRz FOUR
	
	ADD R2,R1,#0
	ADD R2,R2,#-5
	BRz FIVE
	
	ADD R2,R1,#0
	ADD R2,R2,#-6
	BRz SIX
	
	ADD R2,R1,#0
	ADD R2,R2,#-7
	BRz SEVEN
	
	BRnzp SEVEN
	
	ONE
		LD R6,ALL_MACHINES_BUSY
		JSRR R6
		ADD R2,R2,#0
		BRz ALL_NOT_BUSY
		BRnp ALL_BUSY
		
		ALL_BUSY
			LEA R0,allbusy
			PUTS
			BRnzp MENU_LOOP
			
		ALL_NOT_BUSY
			LEA R0,allnotbusy
			PUTS
			BRnzp MENU_LOOP
			
	TWO
		LD R6,ALL_MACHINES_FREE
		JSRR R6
		ADD R2,R2,#0
		BRz ALL_NOT_FREE
		BRnp ALL_FREE
		
		ALL_FREE
			LEA R0,allfree
			PUTS
			BRnzp MENU_LOOP
			
		ALL_NOT_FREE
			LEA R0,allnotfree
			PUTS
			BRnzp MENU_LOOP
			
		THREE
			LD R6,NUM_BUSY_MACHINES
			JSRR R6
			
			LEA R0,busymachine1
			PUTS
			
			LD R6,PRINT_NUM
			JSRR R6
			
			LEA R0,busymachine2
			PUTS
			BRnzp MENU_LOOP
			
		FOUR
			LD R6,NUM_FREE_MACHINES
			JSRR R6
			
			LEA R0,freemachine1
			PUTS
			
			LD R6,PRINT_NUM
			JSRR R6
			
			LEA R0,freemachine2
			PUTS
			BRnzp MENU_LOOP
			
		FIVE
			LD R6,GET_MACHINE_NUM	
			JSRR R6
			
			LD R6,MACHINE_STATUS
			JSRR R6
			
			LEA R0,status1
			PUTS
			
			ST R2,RESULT
			ADD R2,R1,#0
			
			LD R6,PRINT_NUM
			JSRR R6
			
			LD R2,RESULT
			BRp STATUS_FREE
			BRnz STATUS_BUSY
			
			STATUS_BUSY
				LEA R0,status2
				PUTS
				BRnzp MENU_LOOP
				
			STATUS_FREE
				LEA R0,status3
				PUTS
				BRnzp MENU_LOOP
				
			SIX
				LD R6,FIRST_FREE
				JSRR R6
				
				ADD R0,R2,#-16
				BRz NONE_FREE
				BRnp FREE
				
				FREE
					LEA R0,firstfree1
					PUTS
					
					LD R6,PRINT_NUM
					JSRR R6
					
					LEA R0,newline
					PUTS
					BRnzp MENU_LOOP
					
				NONE_FREE
					LEA	R0,firstfree2
					PUTS
					BRnzp MENU_LOOP
					
			SEVEN
				LEA R0,goodbye
				PUTS
	
HALT
;---------------	
;Data
;---------------
;Subroutine pointers

MENU					.FILL x3200
ALL_MACHINES_BUSY		.FILL x3400
ALL_MACHINES_FREE		.FILL x3600
NUM_BUSY_MACHINES		.FILL x3800
NUM_FREE_MACHINES		.FILL x4000
MACHINE_STATUS			.FILL x4200
FIRST_FREE				.FILL x4400
GET_MACHINE_NUM			.FILL x4600
PRINT_NUM				.FILL x4800

;Other data 
newline 		.STRINGZ "\n"
RESULT		 	.BLKW #1
ASCII			.FILL #48

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3200
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
ST R0, BACKUP_R0_3200
ST R2, BACKUP_R2_3200
ST R7, BACKUP_R7_3200
;HINT back up 

START_MENU
	LD R0,Menu_string_addr
	PUTS
	
	GETC
	OUT
	ADD R2,R0,#0
	
	LEA R0,NEWLINE_3200
	PUTS
	
	CHECK_MORE_ONE
		LD R0,NEG_48
		ADD R1,R0,R2
		BRn ERROR_MSG_3200
		
	CHECK_LESS_SEVEN
		LD R0,NEG_55
		ADD R1,R0,R2
		BRp ERROR_MSG_3200
		
	BRnzp END_3200
	
	ERROR_MSG_3200
		LEA R0,Error_msg_1
		PUTS
		BRnzp START_MENU
		
	END_3200
	ADD R1,R2,#0
	LD R0,ASCII_BACK
	ADD R1,R1,R0

;HINT Restore
LD R0, BACKUP_R0_3200
LD R2, BACKUP_R2_3200
LD R7, BACKUP_R7_3200
RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
BACKUP_R0_3200	  .BLKW #1
BACKUP_R2_3200	  .BLKW #1
BACKUP_R7_3200	  .BLKW #1
ASCII_BACK		  .FILL #-48
NEG_48			  .FILL #-49
NEG_55			  .FILL #-55
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
NEWLINE_3200			  .STRINGZ "\n"
Menu_string_addr  .FILL x6400

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3400
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
ST R0,BACKUP_R0_3400
ST R1,BACKUP_R1_3400
ST R3,BACKUP_R3_3400
ST R4,BACKUP_R4_3400
ST R7,BACKUP_R7_3400
;HINT back up 

AND R2,R2,#0

LD R4,BUSYNESS_ADDR_ALL_MACHINES_BUSY
LDR R1,R4,#0
LD R3,BIT_16_3400

LOOP_3400
	ADD R1,R1,#0
	
	BRn END_3400
	
	ADD R1,R1,R1
	ADD R3,R3,#-1
	BRp LOOP_3400
	
	ADD R2,R2,#1
END_3400

;HINT Restore
LD R0,BACKUP_R0_3400
LD R1,BACKUP_R1_3400
LD R3,BACKUP_R3_3400
LD R4,BACKUP_R4_3400
LD R7,BACKUP_R7_3400
RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BACKUP_R0_3400					.BLKW #1
BACKUP_R1_3400					.BLKW #1
BACKUP_R3_3400					.BLKW #1
BACKUP_R4_3400					.BLKW #1
BACKUP_R7_3400					.BLKW #1
BIT_16_3400						.FILL #16	
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB200

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3600
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
ST R0,BACKUP_R0_3600
ST R1,BACKUP_R1_3600
ST R3,BACKUP_R3_3600
ST R4,BACKUP_R4_3600
ST R7,BACKUP_R7_3600
;HINT back up 

AND R2,R2,#0

LD R4,BUSYNESS_ADDR_ALL_MACHINES_FREE
LDR R1,R4,#0
LD R3,BIT_16_3600

LOOP_3600
	ADD R1,R1,#0
	
	BRzp END_3600
	
	ADD R1,R1,R1
	ADD R3,R3,#-1
	BRp LOOP_3600
	
	ADD R2,R2,#1
END_3600

;HINT Restore
LD R0,BACKUP_R0_3600
LD R1,BACKUP_R1_3600
LD R3,BACKUP_R3_3600
LD R4,BACKUP_R4_3600
LD R7,BACKUP_R7_3600
RET
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BACKUP_R0_3600					.BLKW #1
BACKUP_R1_3600					.BLKW #1
BACKUP_R3_3600					.BLKW #1
BACKUP_R4_3600					.BLKW #1
BACKUP_R7_3600					.BLKW #1
BIT_16_3600						.FILL #16	
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB200

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3800
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
ST R7,BACKUP_R7_3800
;HINT back up 

AND R1,R1,#0

LD R4,BUSYNESS_ADDR_NUM_BUSY_MACHINES
LDR R2,R4,#0
LD R3,BIT_16_3800

LOOP_3800
	ADD R2,R2,#0
	BRzp INCRE_3800
	BRn CHECK_NUM_3800
	
	INCRE_3800
		ADD R1,R1,#1
		BRnzp CHECK_NUM_3800
	
	CHECK_NUM_3800
		ADD R2,R2,R2
		ADD R3,R3,#-1
		BRp LOOP_3800
		BRnzp END_3800
		
END_3800

;HINT Restore
LD R7,BACKUP_R7_3800
RET
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BACKUP_R7_3800					.BLKW #1
BIT_16_3800						.FILL #16	
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB200


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4000
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
ST R7,BACKUP_R7_4000
;HINT back up 

AND R2,R2,#0

LD R4,BUSYNESS_ADDR_NUM_FREE_MACHINES
LDR R1,R4,#0
LD R3,BIT_16_4000

LOOP_4000
	ADD R1,R1,#0
	BRn INCRE_4000
	BRzp CHECK_NUM_4000
	
	INCRE_4000
		ADD R2,R2,#1
		BRnzp CHECK_NUM_4000
	
	CHECK_NUM_4000
		ADD R1,R1,R1
		ADD R3,R3,#-1
		BRp LOOP_4000
		BRnzp END_4000
		
END_4000
	ADD R1,R2,#0

;HINT Restore
LD R7,BACKUP_R7_4000
RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BACKUP_R7_4000					.BLKW #1
BIT_16_4000						.FILL #16	
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB200


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4200
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
ST R1,BACKUP_R1_4200
ST R4,BACKUP_R4_4200
ST R5,BACKUP_R5_4200
ST R7,BACKUP_R7_4200
;HINT back up 

ADD R6,R1,#0
NOT R6,R6
ADD R6,R6,#1
LD R4,CTR_15
ADD R4,R4,R6

LD R5,BUSYNESS_ADDR_MACHINE_STATUS
LDR R2,R5,#0

IF_ZERO_SKIP_4200
	ADD R4,R4,#0
	BRz CURR_STATUS_4200

NEXT_SPOT_4200
	ADD R2,R2,R2
	ADD R4,R4,#-1
	BRp NEXT_SPOT_4200

CURR_STATUS_4200
	ADD R2,R2,#0
	BRzp BUSY_4200
	AND R2,R2,#0
	ADD R2,R2,#1
	BRnzp END_4200
	
	BUSY_4200
		AND R2,R2,#0
	
END_4200
;HINT Restore
LD R1,BACKUP_R1_4200
LD R4,BACKUP_R4_4200
LD R5,BACKUP_R5_4200
LD R7,BACKUP_R7_4200
RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BACKUP_R1_4200				.BLKW #1
BACKUP_R4_4200				.BLKW #1
BACKUP_R5_4200				.BLKW #1
BACKUP_R7_4200				.BLKW #1
CTR_15						.FILL #15
BUSYNESS_ADDR_MACHINE_STATUS .Fill xB200

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4400
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
ST R7,BACKUP_R7_4400
;HINT back up 

LD R4,BUSYNESS_ADDR_FIRST_FREE
LDR R1,R4,#0
LD R3,NUM_15
AND R2,R2,#0 ;change later

LOOP_4400
	ADD R3,R3,#0
	BRz CHECKER
	ADD R1,R1,R1
	ADD R3,R3,#-1
	BRp LOOP_4400
	
	CHECKER
		ADD R1,R1,#0
		BRn END_4400
		LD R3,NUM_15
		ADD R2,R2,#1
		
		NOT R5,R2
		ADD R5,R5,#1
		
		ADD R3,R3,R5
		ADD R5,R2,#-16
		BRz END_4400
		
		LDR R1,R4,#0
		
		BRnzp LOOP_4400
		
	END_4400
	ADD R1,R2,#0
;HINT Restore
LD R7,BACKUP_R7_4400
RET
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
NUM_15					 .FILL #15
BACKUP_R7_4400			 .BLKW #1
BUSYNESS_ADDR_FIRST_FREE .Fill xB200

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4600
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R0,BACKUP_R0_4600
ST R2,BACKUP_R2_4600
ST R4,BACKUP_R4_4600
ST R6,BACKUP_R6_4600
ST R7,BACKUP_R7_4600

RESTART
; output intro prompt
LEA R0,introPromptPtr
PUTS		
; Set up flags, counters, accumulators as needed
AND R1,R1,#0
AND R5,R5,#0
LD R4,COUNTER_MAX ;COUNTER
; Get first character, test for '\n', '+', '-', digit/non-digit: 	

	GETC
	LD R2,NEWLINE_CHECK					;CHECKS I FIRST INPUT IS NEWLINE,IF SO SKIP TO END
	ADD R3,R0,R2
	BRz ERROR

	LD R2,POSITIVE_CHECK				;CHECKS IF POSITIVE,IF SO SET POS FLAG
	ADD R3,R0,R2
	BRz POS_FLAG

	LD R2,NEGATIVE_CHECK				;CHECKS IF NEGATIVE<IF SO SET NEG FLAG
	ADD R3,R0,R2
	BRz ERROR
	
	LD R6,SUB_ERROR_FLAG_3200			;RUNS ERROR FLAG SUBROUTINE IF CHAR IS INPUTTED
	JSRR R6
	ADD R3,R3,#0
	BRp ERROR
	
	BRnzp NUM_START						;MEANS ITS A NUMBER SO START IN LOOP WITHOUT ASKING FOR ANOTHER INPUT
	
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
				
				LEA R0,errorMessagePtr
				PUTS
				
				BRnzp RESTART
				
			ERROR_NUM
				LEA R0,NEWLINE
				PUTS
			
				LEA R0,NEWLINE
				PUTS
				
				LEA R0,errorMessagePtr
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
	
	FINISH_CHECK	
		LD R0,NEG_15_4600				;CHECKS IF ITS NEGATIVE TO CHANGE IT
		ADD R0,R0,R1
		BRp ERROR_NUM
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
	
	LD R0,BACKUP_R0_4600
	LD R2,BACKUP_R2_4600
	LD R4,BACKUP_R4_4600
	LD R6,BACKUP_R6_4600
	LD R7,BACKUP_R7_4600
						
RET
;--------------------------------
;Data for subroutine Get input
;--------------------------------
BACKUP_R0_4600		.BLKW #1
BACKUP_R2_4600		.BLKW #1
BACKUP_R4_4600		.BLKW #1
BACKUP_R6_4600		.BLKW #1
BACKUP_R7_4600		.BLKW #1
NEG_15_4600			.FILL #-15
SUB_ERROR_FLAG_3200	.FILL x5000
NEWLINE				.STRINGZ "\n"
MIN					.FILL #-48
NEWLINE_CHECK		.FILL #-10
POSITIVE_CHECK		.FILL #-43
NEGATIVE_CHECK		.FILL #-45
COUNTER_MAX			.FILL x5
FIRST_NUM			.FILL #-5
ARR_PTR				.FILL ARR
;--------------------------------
;Data for subroutine Get input
;--------------------------------
introPromptPtr .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
errorMessagePtr.STRINGZ "ERROR INVALID INPUT\n"



;------------
; Remote data
;------------
					.ORIG x5200
ARR					.BLKW		#6		


;==============================================================================
;SUBROUTINE:SUB_ERROR_FLAG_3200
;PARAMETER(R0):CHECK IF ITS A NUMBER
;POST CONDITION: IF ASCII 48 >= X <= 57 IT IS A NUMBER< ERROR OTHERWISE
;RETURN(R3) FLAGS WHETHER IT IS AN ERROR OR NOT TO PRIONT THE ERROR OR RESTART OR NOT
;=============================================================================
.ORIG x5200

;instructions
ST R2,BACKUP_R2_5200
ST R7,BACKUP_R7_5200

		LD R2,MIN_5200
		ADD R3,R0,R2
		BRn PROBLEM_YES
			
		LD R2,MAX_5200
		ADD R3,R0,R2
		BRp PROBLEM_YES
		BRnz PROBLEM_NO

PROBLEM_YES
AND R3,R3,#0
ADD R3,R3,#1
BRnzp END_5200

PROBLEM_NO
AND R3,R3,#0
ADD R3,R3,#-1

END_5200

LD R2,BACKUP_R2_5200
LD R7,BACKUP_R7_5200
RET
;data
BACKUP_R2_5200			.BLKW	#1
BACKUP_R7_5200			.BLKW	#1
MIN_5200					.FILL #-48
MAX_5200					.FILL #-57
;---------------
; END of PROGRAM
;---------------

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4800
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R1,BACKUP_R1_4800
ST R4,BACKUP_R4_4800
ST R5,BACKUP_R5_4800
ST R7,BACKUP_R7_4800

LD R4,Two
LD R6,SUB_SUB_OUTPUT_PLACE
JSRR R6

LD R4,One
LD R6,LAST_OUTPUT
JSRR R6

LD R1,BACKUP_R1_4800
LD R4,BACKUP_R4_4800
LD R5,BACKUP_R5_4800
LD R7,BACKUP_R7_4800

RET
;data
BACKUP_R1_4800		.BLKW #1
BACKUP_R4_4800		.BLKW #1
BACKUP_R5_4800		.BLKW #1
BACKUP_R7_4800		.BLKW #1
SUB_SUB_OUTPUT_PLACE .FILL x5400
LAST_OUTPUT			 .FILL x5600
Two					.FILL #-10
One					.FILL #-1
NEGATIVE 	 		.FILL #45
;=================================================
;				END 3400
;=================================================

;=================================================
;Subroutine:SUB_SUB_OUTPUT_PLACE
;Parameter():takes in the numbers to printout the number
;Postcondition:Fill A number into R2
;Return Value(NA):
;=================================================
.ORIG x5400
;instructions
ST R7,BACKUP_R7_5400
ST R2,BACKUP_R2_5400
ST R3,BACKUP_R3_5400

AND R3,R3,#0
ADD R2,R1,R4
BRn DO_ZERO
BRzp FIND_NUM_PLACE


FIND_NUM_PLACE
	ADD R2,R1,#0
	LOOP
	ADD R2,R2,R4
	BRnp SKIP_THIS
	
	ADD R3,R3,#1
	ADD R1,R1,R4
	
	SKIP_THIS
	ADD R3,R3,#1
	ADD R2,R2,#0
	BRz OUTPUT
	BRzp LOOP
	
OUTPUT
	LD R0,IS_LAST_PLACE
	ADD R0,R4,R5
	BRz SKIP
	ADD R5,R5,#1
	
	ADD R3,R3,#-1
	
	SKIP
		LD R0,ASCII_5400
		ADD R0,R3,R0
		OUT
		
		NOT R2,R2
		ADD R2,R2,#1
		ADD R2,R2,R4
		NOT R2,R2
		ADD R2,R2,#1
		ADD R1,R1,#0
		BRz SKIP_HERE
		ADD R1,R2,#0
		SKIP_HERE
		BRnzp FINAL
	
DO_ZERO
	ADD R5,R5,#0
	BRnz FINAL
	LD R0,ASCII_5400
	OUT
	
FINAL

LD R7,BACKUP_R7_5400
LD R2,BACKUP_R2_5400
LD R3,BACKUP_R3_5400

RET
;data
BACKUP_R7_5400		.BLKW #1
BACKUP_R2_5400		.BLKW #1
BACKUP_R3_5400		.BLKW #1
ASCII_5400				.FILL #48
IS_LAST_PLACE		.FILL #1
;=================================================
;				END 3400
;=================================================
;=================================================
;Subroutine:LAST_OUTPUT
;Parameter():takes in the numbers to printout the number
;Postcondition:Fill A number into R2 (DIFFERENCE IS DOESNT DECREMENT)
;Return Value(NA):
;=================================================
.ORIG x5600
;instructions
ST R7,BACKUP_R7_5600
ST R2,BACKUP_R2_5600
ST R3,BACKUP_R3_5600

AND R3,R3,#0
ADD R2,R1,R4
BRn DO_ZERO_5600
BRzp FIND_NUM_PLACE_5600


FIND_NUM_PLACE_5600
	ADD R2,R1,#0
	LOOP_5600
	ADD R2,R2,R4
	BRzp SKIP_THIS_2
	
	ADD R3,R3,#-1
	
	SKIP_THIS_2
	ADD R3,R3,#1
	ADD R2,R2,#0
	BRz OUTPUT_5600
	BRzp LOOP_5600
	
OUTPUT_5600
		ADD R5,R5,#1
		LD R0,ASCII_5600
		ADD R0,R3,R0
		OUT
		
		NOT R2,R2
		ADD R2,R2,#1
		ADD R2,R2,R4
		NOT R2,R2
		ADD R2,R2,#1
		ADD R1,R2,#0
		BRnzp FINAL_5600
	
DO_ZERO_5600
	ADD R5,R5,#0
	BRn FINAL_5600
	LD R0,ASCII_5600
	OUT
	
FINAL_5600

LD R7,BACKUP_R7_5600
LD R2,BACKUP_R2_5600
LD R3,BACKUP_R3_5600

RET
;data
BACKUP_R7_5600		.BLKW #1
BACKUP_R2_5600		.BLKW #1
BACKUP_R3_5600		.BLKW #1
ASCII_5600				.FILL #48
;=================================================
;				END 5600
;=================================================
;--------------------------------
;Data for subroutine print number
;--------------------------------



.ORIG x6400
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xB200			; Remote data
BUSYNESS .FILL xABCD		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
