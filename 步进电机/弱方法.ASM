ORG 0000H
START: 	MOV DPTR,#TAB1
MOV R0,#00H
MOV P2,R0
LOO:  JNB P0.0,NEXT
       JNB P0.1,NEXT1
		SJMP LOO
	  NEXT:
	  MOV R1,#1
	  MOV A,R1
	  MOVC A,@A+DPTR
	  MOV P2,A
	  LCALL DELAY
	  SJMP KEY
	  NEXT1:
	
	  MOV R1,#8
	  MOV A,R1
	  MOVC A,@A+DPTR
	  MOV P2,A
	   LCALL DELAY
	   	  SJMP KEY
	 KEY:  
	 JB P0.0,NR1
	 INC R1
	 CJNE R1,#9,LOOPP
	 MOV R1,#1
	 LOOPP:MOV A,R1
	 MOVC A,@A+DPTR
	 MOV P2,A
	 LCALL DELAY
	 SJMP KEY
	 NR1:JB P0.1,KEY
	 DEC R1
	 CJNE R1,#0,LOOPN
	 MOV R1,#8
	 LOOPN:MOV A,R1
	 MOVC A,@A+DPTR
	 MOV P2,A
	 LCALL DELAY
	 SJMP KEY






	 DELAY:MOV R6,#20
	 DD1:MOV R5,#248
	DD2:MOV R7,#70
	   DJNZ R7,$
	   DJNZ R5,DD2
	   DJNZ R6,DD1
	   RET




TAB1:DB 00H,02H,06H,04H,0CH,08H,09H,01H,03H
END