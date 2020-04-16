;=================================================
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
	;----------------------------
	;Instructions
	;----------------------------
	;gets value at DEC_65
	LD R5, DATA_PTR
	
	;Moves one mem location down to get HEX_4;
	ADD R6,R5,#1
	
	LDR R3,R5,#0
	LDR R4,R6,#0
	
	;ADD ONE TO THE THING IN MEMORY
	ADD R3,R3,#1
	ADD R4,R4,#1
	
	STR R3,R5,#0
	STR R4,R6,#0
	
	Halt
	;----------------------------
	;Data
	;----------------------------
	
	;One Pointer that points to start of remote data
	DATA_PTR .FILL x4000
		;; Remote Data
		.orig x4000
	DEC_65 .FILL #65
	HEX_41 .FILL x41
	
.end
