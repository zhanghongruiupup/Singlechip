ORG 0000H
MOV R0,#30H									;	 
MOV R3,#80H
MOV R4,#4
START:JB P1.2,NEXT                        
	   SJMP START
	   
NEXT:  MOV A,P3
       MOV R2,P3
								    	;判断是否有键按下,有键按下转到NEXT2
       CPL A
	   JNZ NEXT2
	   MOV A,#00H
	   MOV R2,#00H
	   SJMP NEXT 
NEXT2:  	
       LCALL DELAY
        MOV A,R3
       RL A
	   MOV R3,A     
      MOV R1,#00H
        MOV A,#00H                                                   ;判断是哪个键按下，比如是按键1，R1为01H
         MOV A,#0FFH
		 RRC A
        MOV A,R2
NEXT3:	 RRC A
		 INC R1
		 JNC NEXT4
		 SJMP NEXT3
 NEXT4: MOV A,#00H   												   ;显示数字
       MOV A,R1
        MOV DPTR,#TAB
	   MOVC A,@A+DPTR
	   MOV @R0,A																						;
	   MOV P0,A
	 		MOV P2,R3
			INC R0
											  ;
		DJNZ R4,NEXT

      	MOV A,30H													;判断密码正确性			  ;
     	 CJNE A,#0F9H,LOOP
		  MOV A,31H
		  CJNE A,#099H,LOOP
		  MOV A,32H
		  CJNE A,#0B0H,LOOP
		  MOV A,33H
		  CJNE A,#0A4H,LOOP
		  MOV P1,#07DH		
		 											  ;
	   TAB:DB 0C0H,0F9H,0A4H,0B0H,099H
	   DELAY:MOV R5,#40
	  D1: MOV R6,#20
	   D2:MOV R7,#248
	   DJNZ R7,$
	    DJNZ R6,D2
		 DJNZ R5,D1
	   RET
  LOOP:MOV P1,#0FEH																					;
	END	   