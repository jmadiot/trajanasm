	
	;r12 = début de la fonction
		ldl 5
		mv2reg r12
		ldlline
		ldhline
		add r12
		mv2reg r12
	;r12 pointe sur la ligne qui suit la prochaine


	jmri main
	;DEBUT DES PROCEDURES
	
		;PROCEDURE PRINT_INT :
		; r99 = entier à écrire.   (r99 sera détruit)
		; r98 = adresse où écrire. r98 sera actualisé.
		
			;ANCIEN CORPS
				;ldl 27
				;add r99
				;mv2reg r99
				;mv2acc r98
				;wrinc r99
				;mv2reg r98
				

			;INTERFACAGE :
			
				mv2acc r99
				mv2reg r20
			
			
			;CORPS DE PRINT_INT
				
				;affiche r20 à r1, r2
	
				;REGISTRES INTERNES
	
					;r21 : = caractère '0' - 1 ?
						ldl 26
						mv2reg r21
		
					;constantes 0, 1, 10, 100, 1000, 10 000
						ldl 0
						mv2reg r22
						ldl 1
						mv2reg r23
						ldl 10
						mv2reg r24
						ldl 100
						mv2reg r25
						ldl -24
						ldh 3
						mv2reg r26
						ldl 16
						ldh 39
						mv2reg r27
		
					;NOMBRE DE CHIFFRES ?
			 
						;n<10000?
							mv2acc r20
							!s sub r27
							?p GE jmri affiche5 

						;n<1000?
							mv2acc r20
							!s sub r26
							?p GE jmri affiche4

						;n<100?
							mv2acc r20
							!s sub r25
							?p GE jmri affiche3

						;n<10?	
							mv2acc r20
							!s sub r24
							?p GE jmri affiche2

						;n<10.
							jmri affiche1
	
	

					;AFFICHE LES DIZAINES DE MILLIERS
						;r21 = 26 + [r20 / 10000]
							affiche5:
							;r21++
								mv2acc r21
								add r23
								mv2reg r21

							;r20 <- r20 - 10000
								mv2acc r20
								!s sub r27
								mv2reg r20

							?p GE jmri affiche5
			
							;ET MERDE, r20 est négatif maintenant !
								mv2acc r20
								add r27
								mv2reg r20
	
						;AFFICHE r21
							mv2acc r98
							wrinc r21
							mv2reg r98
			
						;REINITIALISE r21
							ldl 26
							mv2reg r21

					;PAREIL POUR LES MILLIERS
							affiche4:
								mv2acc r21
								add r23
								mv2reg r21
								mv2acc r20
								!s sub r26
								mv2reg r20
							?p GE jmri affiche4
								mv2acc r20
								add r26
								mv2reg r20
							mv2acc r98
							wrinc r21
							mv2reg r98
				
							ldl 26
							mv2reg r21
		
					;LES CENTAINES
							affiche3:
								mv2acc r21
								add r23
								mv2reg r21
								mv2acc r20
								!s sub r25
								mv2reg r20
							?p GE jmri affiche3
								mv2acc r20
								add r25
								mv2reg r20
							mv2acc r98
							wrinc r21
							mv2reg r98
				
							ldl 26
							mv2reg r21
			
					;LES DIZAINES
							affiche2:
								mv2acc r21
								add r23
								mv2reg r21
								mv2acc r20
								!s sub r24
								mv2reg r20
							?p GE jmri affiche2
								mv2acc r20
								add r24
								mv2reg r20
							mv2acc r98
							wrinc r21
							mv2reg r98
				
							ldl 26
							mv2reg r21
			
					;LES UNITES
							affiche1:
								mv2acc r21
								add r23
								mv2reg r21
								mv2acc r20
								!s sub r23
								mv2reg r20
							?p GE jmri affiche1
								mv2acc r20
								add r23
								mv2reg r20
							mv2acc r98
							wrinc r21
					
					;UPDATE r98
						mv2reg r98
				

			;RETOUR VERS r13 
				jmp r13





	;FIN DES PROCEDURES, DEBUT DE LA FONCTION PRINCIPALE
	main:

	;TOPLEFT adresse du haut à gauche
		ldl 0
		ldh 0x20
		mv2reg r98
	
	;REGISTERS used :
	
		;r99 = the number or the caracter which will be printed
		
		;r98 = adress where the caracters will be printed
	
		;r100=0, r100=1, r48=-1
			ldl 1
			mv2reg r101

			clr r100

			ldl -1
			ldh -1
			mv2reg r48
	
		;r50 = caractère '0'
			ldl 27
			mv2reg r50
	
		;caractères +, -, x, ^
			ldl 49
			mv2reg r51
			ldl 46
			mv2reg r49
			ldl 24
			mv2reg r52
			ldl 50
			mv2reg r53
	
		;caractères n,p,space,z
			ldl 14
			mv2reg r55
			ldl 16
			mv2reg r56
			ldl 37
			mv2reg r57
			ldl 26
			mv2reg r58
	
	
	
	;POLYNOME
	
		;polynome : 7x^3-5x^2+9x+1   ;TODO update
	
		;DEGRE dans r4
			ldl 6
			mv2reg r4
		
		;COEFFICIENT
			;a0 puis a1 puis a2 puis a3 ...
			ldl 1
			mv2reg r80
			ldl 67
			mv2reg r81
			ldl -67
			ldh -1
			mv2reg r82
			ldl 7
			mv2reg r83
			ldl 9
			mv2reg r84
			ldl -5
			ldh -1
			mv2reg r85
			ldl -8
			ldh -1
			mv2reg r86
		
		;POINTEUR dans r5
			ldl 0x50
			mv2reg r5
			wrinc r80
			wrinc r81
			wrinc r82
			wrinc r83
			wrinc r84
			wrinc r85
			wrinc r86
		
		;MEILLEURE METHODE POUR MODIFIER LE POLYNOME (DEBUGGING)
			ldl 5
			mv2reg r5
			ldlline
			ldhline
			add r5
			mv2reg r5
			jmri skip
				;datasigned 4 67 -4567 0 15419 -5 2 0 0 0 0 0 0 0 0 -25
				datasigned 4 -3 -1 1
			skip:
			ldl 3
			mv2reg r4
			ldl 5
			mv2reg r6
	
	
	;FIRST PLUS : REGISTER USED r8 = 2 au premier parcours et 1 aux suivants.
		ldl 2
		mv2reg r8
	
	;DEGRE r4->r7
		mv2acc r4
		mv2reg r7
	
	
	;AFFICHAGE

		;BOUCLE PRINCIPALE	
		boucle:
	
			;r90 <- mem[r5+r7]
				mv2acc r7
				add r5
				rd r90
	
			;r91 <- abs(r90)
				;if(r91<0)
					mv2acc r90
					!s add r100
				;then r91 <- -r90
					?p LT mul r48
					mv2reg r91
			
			;ECRITURE DU SIGNE
				mv2acc r98
				
				;MOINS
					?p LT wrinc r49
				
				;PLUS : est sauté systématiquement au premier parcours
					jmr r8
					?p GT wrinc r51
					
				;FIRST PLUS
					mv2reg r98
					ldl 1
					mv2reg r8
					mv2acc r98
				

			;DECISION : Affichage ou non du coefficient : coefficient!=1 ou exposant=0:
				;if r91<>0
				?p EQ jmri skip3
					mv2reg r98
					mv2acc r91
					!s sub r101
					?p NE jmri skip4
							;actualiser les flags pour (NOT r7)
							mv2acc r7
							!s add r100
							ldl 1
							?p EQ jmri skip5
								ldl 0
							skip5:
							!s add r100
					skip4:
					mv2acc r98
				skip3:
		
			;AFFICHAGE D'UN ENTIER : COEFFICIENT
				;r99 <- nombre
					mv2acc r91
					;add r50
					mv2reg r99
			
				mv2acc r98
	
				;APPEL DE LA PROCEDURE PRINT_INT
			
					;PREPARATION AU FAUX RTS
						ldl 5
						mv2reg r13
						ldlline
						ldhline
						add r13
						mv2reg r13
				
					;GO !
						?p NE jmp r12
				
					;VIEIL AFFICHAGE
						;?p NE wrinc r99
						;mv2reg r98

			;AFFICHAGE DU X ?  si r7<>0
				mv2acc r90
				!s add r100
				mv2acc r7
				?p EQ jmri skip6
				!s add r100
				skip6:
			
				;AFFICHAGE DE X
					mv2acc r98
					?p NE wrinc r52

			;AFFICHAGE DE L'EXPOSANT
		
				;Si on affiche déjà pas le X, pas question pour l'exposant.
					?p EQ jmri skip2
						;SINON est-ce que r7-1 est nul ? 
							mv2reg r98
							mv2acc r7
							!s sub r101
							mv2acc r98
					skip2:
		
				;AFFICHE LE CARET ^
					?p NE wrinc r53
		
				;AFFICHAGE D'UN ENTIER : EXPOSANT
					mv2reg r98
				
					mv2acc r7
					mv2reg r99
				
					;APPEL DE LA PROCEDURE PRINT_INT
			
						;PREPARATION AU FAUX RTS
							ldl 5
							mv2reg r13
							ldlline
							ldhline
							add r13
							mv2reg r13
				
						;GO !
							?p NE jmp r12
							
							
						;VIEIL AFFICHAGE
							;mv2acc r98
							;?p NE wrinc r99
							;mv2reg r98
				
			;;DEBUGGING : séparateur
			;	ldl 39
			;	mv2reg r99
			;	mv2acc r98
			;	wrinc r99
			;	wrinc r99
			;	wrinc r99
			;	;sic
			;	mv2acc r98
			;	mv2reg r98

	
			;GESTION DE LA BOUCLE
				;r7--, et arrêt si r7<=0 (sinon r7 devient -1)
					mv2acc r7
					!s add r100
					sub r101
					mv2reg r7
	
	?p NE jmri boucle



	
	;EVALUATION
		;CARACTERES
			ldl 44
			mv2reg r70
			ldl 45
			mv2reg r71
			ldl 47
			mv2reg r72
			ldl 37
			mv2reg r73
		
		;AFFICHE LE POINT EN LEQUEL LE POLYNOME EST EVALUE. sous la forme : " [r6]="
			;AFFICHE " ["
				mv2acc r98
				wrinc r73
				wrinc r70
				mv2reg r98
			
			;AFFICHE L'ENTIER
				mv2acc r6
				mv2reg r99
				;ADDRESS TO RETURN
					ldl 5
					mv2reg r13
					ldlline
					ldhline
					add r13
					mv2reg r13
				;GO
					jmp r12
			
			;AFFICHE "]="
					mv2acc r98
					wrinc r71
					wrinc r73
					wrinc r72
					wrinc r73
					mv2reg r98
		
		;r9=resultat
			ldl 0
			mv2reg r9
		
		;r7=degre
			mv2acc r4
			mv2reg r7
	
	
	
		eval:
			
			;r90 <- mem[r5+r7]
				mv2acc r7
				add r5
				rd r90
			
			mv2acc r9
			!s add r90
			?p OV jmri overflow
			!s mul r6
			?p OV jmri overflow
			mv2reg r9
			
			;GESTION DE LA BOUCLE
				;r7--, et arrêt si r7<=0 (sinon r7 devient -1)
					mv2acc r7
					!s add r100
					sub r101
					mv2reg r7
	
		?p NE jmri eval
	
		
		
		mv2acc r9
		mv2reg r99
		;GOANDRETURN
			ldl 5
			mv2reg r13
			ldlline
			ldhline
			add r13
			mv2reg r13
			jmp r12
		

		jmri skiperror
			overflow:
		
			ldl 5
			mv2reg r2

			ldlline
			ldhline
			add r2
			mv2reg r2
			jmri skipdata
				data 5 18 18 15 18 37 44 15 22 5 18 6 12 15 23 45 0
				;data 10 15 25 5 21 24 37 14 15 5 12 0
			skipdata:

			;r2 : tête de lecture
			;r5 : tête d'écriture

			printov:
				mv2acc r2
				rdinc r99
				mv2reg r2
				mv2acc r99
				!s add r100
				?p NE mv2acc r98
				?p NE wrinc r99
				?p NE mv2reg r98
				?p NE jmri printov
			
		skiperror:

nosegfault:
	nop
	jmri nosegfault













