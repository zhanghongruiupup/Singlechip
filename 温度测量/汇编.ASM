DQ BIT P3.0
FLAG1 BIT 00H
SIGN BIT 01H
MSB EQU 30H
LSB  EQU 31H
ZHENGSHU EQU 32H
XIAOSHU EQU 33H
FUHAO EQU 34H
DANWEI EQU 35H
LED100 EQU 36H
LED10 EQU 37H
LED1 EQU 38H
LED  EQU 39H
ORG 0000H
MAIN:LCALL CSH
     LCALL ZH
	 LCALL SJ
	 LCALL SC
	 LCALL XS
	 SJMP MAIN


CSH:SETB DQ
NOP
    CLR DQ
	MOV R1,#3
D1:	MOV R0,#107
	DJNZ R0,$
	DJNZ R1,D1
   SETB DQ
 
   MOV R0,#25H
 TSR2:JNB DQ,TSR3
 DJNZ R0,TSR2
 LJMP TSR4
 TSR3:SETB FLAG1
 LJMP TSR5
 TSR4:CLR FLAG1
 LJMP TSR6
 TSR5:MOV R0,#117
 DJNZ R0,$
 TSR6:SETB DQ
 RET


	ZH:	
	LCALL CSH
	JB FLAG1,TTS
	RET
	 TTS:MOV A,#0CCH
	 LCALL WRITE
	 MOV A,#44H
	 LCALL WRITE
	 LCALL DELAY
	 LCALL CSH
	 MOV A,#0CCH
	 LCALL WRITE
	 	 MOV A,#0BEH
	 LCALL WRITE
	 LCALL READ
	 RET

	 WRITE:MOV R2,#8
      CLR C
	       SETB DQ
	WR1:  
	      CLR DQ
	
		   MOV R3,#8
		   DJNZ R3,$
		 RRC A
		 MOV DQ,C
		 MOV R3,#23
		 DJNZ R3,$
		SETB DQ
	
		DJNZ R2,WR1
		SETB DQ
		 RET

	 READ:
	 MOV R4,#2
	 MOV R1,#31H
	  LOO1:MOV R2,#8
	LOO:  CLR C
	SETB DQ
	
	 CLR DQ

	 SETB DQ
  MOV R3,#6
	RE: 	 DJNZ R3,RE
	 MOV C,DQ
	 MOV R3,#23
	 DJNZ R3,$
	 RRC A
	 DJNZ R2,LOO
	 MOV @R1,A
		 DEC R1
		 DJNZ R4,LOO1
		 RET

 SJ: CLR C
CLR SIGN
 MOV A,MSB
 RLC A
 JC NEG
 LJMP PR
NEG:  CLR C
 SETB SIGN
    MOV A,LSB
    CPL A
	ADD A,#1
	MOV LSB,A
	MOV A,MSB
	CPL A
	ADDC A,#0
	MOV MSB,A
 PR:
        MOV A,LSB
        ANL A,#0FH
		MOV XIAOSHU,A
		MOV A,MSB
		SWAP A
		ANL A,#0F0H
		MOV ZHENGSHU,A
		MOV A,LSB
		SWAP A
		ANL A,#0FH
		MOV R0,ZHENGSHU
		ORL A,R0
		MOV ZHENGSHU,A
		RET
		
		SC:	MOV DPTR,#TAB
		     JB SIGN,S_NEG
           MOV FUHAO,#00H
           SJMP S_INT
	   S_NEG: MOV FUHAO,#40H
			S_INT:MOV A,ZHENGSHU
				MOV B,#100
				DIV AB
				MOVC A,@A+DPTR
				MOV LED100,A
				MOV A,B
				MOV B,#10
				DIV AB
				MOVC A,@A+DPTR
				MOV LED10,A
				MOV A,B
			
				MOVC A,@A+DPTR
					ORL A,#80H
				MOV LED1,A
				MOV DPTR,#SWITCH
				MOV A,XIAOSHU
				MOV B,XIAOSHU
				ADD A,B
				JMP @A+DPTR
			   SWITCH:AJMP K0
			   AJMP K1
			   AJMP K2
			   AJMP K3
			   AJMP K4
			   AJMP K5
			   AJMP K6
			   AJMP K7
			   AJMP K8
			   AJMP K9
			   AJMP K10
			   AJMP K11
			   AJMP K12
			   AJMP K13
			   AJMP K14
			   AJMP K15
			 

			   K0:MOV LED,#3FH
			  AJMP RETURN
			   K1:MOV LED,#06H
			   AJMP RETURN
			   K2:MOV LED,#06H
			    AJMP RETURN
			   K3:MOV LED,#5BH
			    AJMP RETURN
			   K4:MOV LED,#4FH
			    AJMP RETURN
			   K5:MOV LED,#4FH
			    AJMP RETURN
			   K6:MOV LED,#66H
			   AJMP RETURN
			   K7:MOV LED,#66H
			  AJMP RETURN
			   K8:MOV LED,#60H
			    AJMP RETURN
			   K9:MOV LED,#70H
			    AJMP RETURN
			   K10:MOV LED,#70H
			  AJMP RETURN
			   K11:MOV LED,#07H
			   AJMP RETURN
			   K12:MOV LED,#7FH
			   AJMP RETURN
			   K13:MOV LED,#7FH
			    AJMP RETURN
			   K14:MOV LED,#6FH
			    AJMP RETURN
			   K15:MOV LED,#6FH
			    AJMP RETURN
			   RETURN:MOV DANWEI,#39H
			   RET

				XS:	 MOV P2,#0FFH
				CLR P2.0
				
				MOV P0,FUHAO
				   
						LCALL DELAY
						SETB P2.0
						CLR P2.1
					
						MOV P0,LED100
					
							LCALL DELAY
							 	SETB P2.1
						CLR P2.2
					
								MOV P0,LED10
					
							LCALL DELAY
								SETB P2.2
						CLR P2.3
					
							MOV P0,LED1
						
							LCALL DELAY
								SETB P2.3
						CLR P2.4
					
								    MOV P0,LED
							
							LCALL DELAY
							 	SETB P2.4
						CLR P2.5
						      MOV P0,DANWEI
							  LCALL DELAY
							  SETB P2.5
							RET
				DELAY:MOV R5,#5
				 	N1:  MOV R6,#248
				
					DJNZ R6,$
					DJNZ R5,N1
				
					RET

					TAB:DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH
					END