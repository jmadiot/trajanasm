	;CONSTANTES
		
		;TOPLEFT
			ldl 0
			ldh 0x20
			mv2reg r5
	
	
	;ROUTINES
	jmri main
		
		;ROUTINE PLOT
			plot:
				ldl 80
				mul r2
				add r1
				add r5
				wr r3
				
				rts
	


	;PROGRAMME PRINCIPAL
	main:
		
		
		;UTILISATION DE PLOT
			; 'O' en (29, 15)
				ldl 15
				mv2reg r3
				ldl 29
				mv2reg r1
				ldl 15
				mv2reg r2
			;Appel
				jmrisp plot

			; 'K' en (30, 15)
				ldl 11
				mv2reg r3
				ldl 30
				mv2reg r1
				ldl 15
				mv2reg r2
			;Appel
				jmrisp plot
