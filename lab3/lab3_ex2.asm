;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 3, ex 2
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
;----------------------
;Instructions
;----------------------
;R1 HOLDS POINTER MEM TO BEGINING OF ARRAY
;R2 HELPS US LOOP THROUGH ARRAY
LD R1, DATA_PTR
LD R2, COUNT

DO_WHILE_LOOP
	;INPUT AND DISPLAY
	GETC
	OUT
	
	;STR AT R1 ARRAY PTR
	STR R0,R1,#0
	;MOVE PTR DOWN A MEM LOCATION
	ADD R1,R1,#1
	;DEC COUNTER TILL HITS 0
	ADD R2,R2,#-1
	BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP

halt
;----------------------
;Data
;----------------------
DATA_PTR .FILL ARRAY
ARRAY 	 .BLKW #10
COUNT	 .FILL #10

.end
