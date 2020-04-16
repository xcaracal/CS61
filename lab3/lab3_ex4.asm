;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
;----------------------
;Instructions
;----------------------
;R1 HOLDS POINTER MEM TO BEGINING OF ARRAY
LD R1, DATA_PTR

DO_WHILE_LOOP
	;INPUT AND DISPLAY
	GETC
	OUT
	;STR AT R1 ARRAY PTR
	STR R0,R1,#0
	;MOVE PTR DOWN A MEM LOCATION
	ADD R1,R1,#1
	;If it is zero then it means that /n has been put in = endloop
	ADD R0,R0,#-10
	BRnp DO_WHILE_LOOP
END_DO_WHILE_LOOP

;LOAD EVERYTHING AGAIN
LD R1, DATA_PTR

DO_WHILE_LOOP2
	LDR R0,R1,#0
	OUT
	ADD R1,R1,#1
	ADD R0,R0,#-10
	BRnp DO_WHILE_LOOP2
END_DO_WHILE_LOOP2

halt
;----------------------
;Data
;----------------------
DATA_PTR .FILL x4000
NEWLINE	 .FILL x0A		;JUST HELPS HOLD NEWLINE IN MEM

.end
