;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 7, ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000
;instructions
LD R6,SUB_NUMBER
JSRR R6

ADD R2,R2,#1

LD R6,SUB_OUTPUT
JSRR R6

HALT
;data
SUB_NUMBER				.FILL x3200
SUB_OUTPUT				.FILL x3400
;=================================================
;Subroutine:SUB_NUMBER
;Parameter(NA):
;Postcondition:Fill A number into R2
;Return Value(R2): Any number
;=================================================
.ORIG x3200
;instructions

ST R7,BACKUP_R7_3200

LD	R2,NUMBER

LD R7,BACKUP_R7_3200

RET
;data
BACKUP_R7_3200			.BLKW #1
NUMBER					.FILL #32767
;=================================================
;				END 3200
;=================================================

;=================================================
;Subroutine:SUB_OUTPUT
;Parameter(R2):
;Postcondition: OutPuts R2
;Return Value(NA):
;=================================================
.ORIG x3400
;instructions
ST R7,BACKUP_R7_3400

ADD R0,R2,#0
BRzp NOT_NEG

LD R0,NEGATIVE
OUT
NOT R2,R2
ADD R2,R2,#1

NOT_NEG

LD R4,Five
LD R6,SUB_SUB_OUTPUT_PLACE
JSRR R6

LD R4,Four
LD R6,SUB_SUB_OUTPUT_PLACE
JSRR R6

LD R4,Three
LD R6,SUB_SUB_OUTPUT_PLACE
JSRR R6

LD R4,Two
LD R6,SUB_SUB_OUTPUT_PLACE
JSRR R6

LD R4,One
LD R6,LAST_OUTPUT
JSRR R6

LD R7,BACKUP_R7_3400

RET
;data
BACKUP_R7_3400		.BLKW #1
SUB_SUB_OUTPUT_PLACE .FILL x3600
LAST_OUTPUT			 .FILL x3800
Five				.FILL #-10000
Four				.FILL #-1000
Three				.FILL #-100
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
.ORIG x3600
;instructions
ST R7,BACKUP_R7_3600
ST R1,BACKUP_R1_3600
ST R3,BACKUP_R3_3600

AND R3,R3,#0
ADD R1,R2,R4
BRn DO_ZERO
BRzp FIND_NUM_PLACE


FIND_NUM_PLACE
	ADD R1,R2,#0
	LOOP
	ADD R1,R1,R4
	ADD R3,R3,#1
	ADD R1,R1,#0
	BRz OUTPUT
	BRzp LOOP
	
OUTPUT
	LD R0,IS_LAST_PLACE
	ADD R0,R4,R5
	BRz SKIP
	ADD R5,R5,#1
	
	ADD R3,R3,#-1
	
	SKIP
		LD R0,ASCII
		ADD R0,R3,R0
		OUT
		
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R4
		NOT R1,R1
		ADD R1,R1,#1
		ADD R2,R1,#0
		BRnzp FINAL
	
DO_ZERO
	ADD R5,R5,#0
	BRnz FINAL
	LD R0,ASCII
	OUT
	
FINAL

LD R7,BACKUP_R7_3600
LD R1,BACKUP_R1_3600
LD R3,BACKUP_R3_3600

RET
;data
BACKUP_R7_3600		.BLKW #1
BACKUP_R1_3600		.BLKW #1
BACKUP_R3_3600		.BLKW #1
ASCII				.FILL #48
IS_LAST_PLACE		.FILL #1
;=================================================
;				END 3400
;=================================================
.END

;=================================================
;Subroutine:SUB_SUB_OUTPUT_PLACE
;Parameter():takes in the numbers to printout the number
;Postcondition:Fill A number into R2 (DIFFERENCE IS DOESNT DECREMENT)
;Return Value(NA):
;=================================================
.ORIG x3800
;instructions
ST R7,BACKUP_R7_3800
ST R1,BACKUP_R1_3800
ST R3,BACKUP_R3_3800

AND R3,R3,#0
ADD R1,R2,R4
BRn DO_ZERO_3800
BRzp FIND_NUM_PLACE_3800


FIND_NUM_PLACE_3800
	ADD R1,R2,#0
	LOOP_3800
	ADD R1,R1,R4
	ADD R3,R3,#1
	ADD R1,R1,#0
	BRz OUTPUT_3800
	BRzp LOOP_3800
	
OUTPUT_3800
		ADD R5,R5,#1
		LD R0,ASCII_3800
		ADD R0,R3,R0
		OUT
		
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R4
		NOT R1,R1
		ADD R1,R1,#1
		ADD R2,R1,#0
		BRnzp FINAL_3800
	
DO_ZERO_3800
	ADD R5,R5,#0
	BRnz FINAL_3800
	LD R0,ASCII_3800
	OUT
	
FINAL_3800

LD R7,BACKUP_R7_3800
LD R1,BACKUP_R1_3800
LD R3,BACKUP_R3_3800

RET
;data
BACKUP_R7_3800		.BLKW #1
BACKUP_R1_3800		.BLKW #1
BACKUP_R3_3800		.BLKW #1
ASCII_3800				.FILL #48
;=================================================
;				END 3400
;=================================================
.END
