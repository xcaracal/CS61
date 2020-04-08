;=================================================
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: 24 
; TA: David Feng
; 
;=================================================

.orig x3000

	;--------------------
	;Instructions
	;--------------------
	lea R0,msg_to_print
	puts
	halt
	
	;--------------------
	;Local Data
	;--------------------
	msg_to_print .stringz "Hello World!!!\n"
	
.end
