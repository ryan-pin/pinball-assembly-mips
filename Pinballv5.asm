.data
#pixel 4 por 4
#largura 512px // 128 unidades graficas L
#altura 256 px // 64 unidades graficas  A
# (512/4) * (256/4) = 8192*4 = 32768 areas na tela

#Bola salva no reg 8

#Primeiro pixel ultima linha = 32256

#Ultimo pixel ultima linha = 32764

#achar uma unidade grafica = (linha onde sera usado * qtd de Linhas + coluna) * 4

#registrador 17 verifica os comandos do teclado

#Comandos de A/D/P(play) no registrador 15, T termina o programa
# A = move a barra Esquerda // D move a barra Direita // P joga a bola
#COR ROXA REG 10 // COR PRETA REG 12 // COR CINZA REG 13

color:		.word 0x007a39db #roxo
cinza:		.word 0x00aea6ba
preto:		.word 0x00000000
yellow:		.word 0x00dead1b

.text
main:
	lui $9, 0x1001 #endereço padrao
	addi $8, $0, 384 #128 * 3 (3 linhas)
	
	lw $10, color #cor roxa
	
	lw $12, preto #cor preta
	
	lw $13, cinza #cor cinza
	
	lw $14, yellow #cor amarelo
	
	addi $11, $0 64 #altura
	
	addi $16, $0, 26604
	#addi $16, $0, 7240
	
	#addi $16, $0, 0x100167EC #endereço inicial da bola
	addi $19, $0, 0x10017CD0 #endereço inicial da barra1 <<
	addi $21, $0, 0x10017D30 #endereço inicial da barra2 >>
	
#bola: 
	#lui $9, 0x1001
	#add $9, $9, $16
	#sw $10, 0($9)#BOLA
	

horizontal:   
	beq $8, $0, reset1 #laço pra pintar as linhas horizontais em cima e em baixo
        sw $10, 0($9)      #guarda a tela
        sw $10, 32768($9)   #guarda uma copia da tela
        
        sw $10, 31232($9) #pinta as 3 ultimas linhas
        sw $10, 64000($9) #COPIA as 3 ultimas linhas
      
        addi $9, $9, 4 #pula pro prox pixel
        addi $8, $8, -1 # -1 repetição
        
        sw $12, 32752($9)
        sw $12, 32748($9)
        
        jal horizontal

reset1:	lui $9, 0x1001       #reseta endereço      

vertical: 
	beq $11, $0, reset2 #laço para pintar as linhas verticais na direita e esquerda

	sw $10, 0($9) #linha na esquerda
	sw $10, 4($9)
	sw $10, 8($9)
	sw $10, 508($9) #linha na direita
	sw $10, 504($9)
	sw $10, 500($9)
	
	sw $10, 32768($9) #COPIA LINHAS
	sw $10, 32772($9)
	sw $10, 32776($9)
	sw $10, 33276($9) #linha na direita
	sw $10, 33272($9)
	sw $10, 33268($9)
	
	sw $12 320000($9)

	addi $9, $9, 512 #pula pro prox pixel pra baixo
	
	
	addi $11, $11, -1
	jal vertical
	
reset2:	addi $11, $0, 6 #loop 3x
	lui $9, 0x1001  #reseta endereço   

corPreta: 
	beq $11, 0, reset3
	
	sw $12, 32268($9) #buraco esquerda
	sw $12, 32272($9) #buraco esquerda
	sw $12, 32276($9) #buraco esquerda

	sw $12, 32464($9)#buraco no meio
	sw $12, 32468($9)#buraco no meio
	sw $12, 32472($9)#buraco no meio
	sw $12, 32476($9)#buraco no meio
	sw $12, 32480($9)#buraco no meio
	sw $12, 32484($9)#buraco no meio
	sw $12, 32488($9)#buraco no meio
	sw $12, 32492($9)#buraco no meio
	sw $12, 32496($9)#buraco no meio
	sw $12, 32500($9)#buraco no meio
	sw $12, 32504($9)#buraco no meio
	sw $12, 32508($9)#buraco no meio
	sw $12, 32512($9)#buraco no meio
	sw $12, 32516($9)#buraco no meio			
	sw $12, 32520($9)#buraco no meio
	sw $12, 32524($9)#buraco no meio
	sw $12, 32528($9)#buraco no meio
	sw $12, 32532($9)#buraco no meio
	sw $12, 32536($9)#buraco no meio
	sw $12, 32540($9)#buraco no meio
	sw $12, 32544($9)#buraco no meio
	sw $12, 32548($9)#buraco no meio
	sw $12, 32552($9)#buraco no meio
	sw $12, 32556($9)#buraco no meio
	sw $12, 32560($9)#buraco no meio

												
	sw $13, 32744($9) # linha da esquerda     
        sw $13, 32748($9) #linha do meio
        sw $13, 32752($9) #linha mais a direita
        
        sw $14, 29676($9)#linha amarela

        
        addi $9, $9, -512 #prox pixel pra cima

	addi $11, $11, -1
	
	jal corPreta
	
reset3: addi $11, $0, 48 #loop abaixo 50x
	lui $9, 0x1001  #reseta endereço 

linharoxa: beq $11, $0, reset4
	
	sw $10, 32280($9)#linha roxa <<<
	sw $10, 32284($9)#linha roxa
	sw $10, 32288($9)#linha roxa

	sw $10, 32740($9)#linha roxa >>>
	sw $10, 32736($9)#linha roxa >>>
	sw $10, 32732($9)#linha roxa >>>
	
	addi $9, $9, -512 #prox pixel pra cima
	
	addi $11, $11, -1
	
	jal linharoxa

reset4: addi $11, $0, 12 #loop abaixo 12x
	lui $9, 0x1001  #reseta endereço 

linhashorizont:
	beq $11, $0, reset5

	sw $10, 30756($9) #primeira linha da esquerda BAIXO
	sw $10, 30244($9)
	sw $10, 29732($9)	

	sw $10, 31148($9) #primeira linha da direita
	sw $10, 30636($9) 
	sw $10, 30124($9)

	sw $10, 11500($9)#LINHA BAIXO QUADRADO	CIMA
	sw $10, 10988($9)
	sw $10, 10476($9)
	
	sw $10, 7404($9)#LINHA CIMA QUADRADO	CIMA
	sw $10, 6892($9)
	sw $10, 6380($9)
			
	sw $10, 16620($9)#LINHA ROXA NO MEIO DA TELA	
	sw $10, 17132($9)
	sw $10, 17644($9)
	
	#QUADRADO DE BAIXO DIREITA
	sw $10, 17760($9) #linha horizontal CIMA >>
	sw $10, 18272($9) #linha horizontal CIMA >>
	sw $10, 18784($9) #linha horizontal CIMA >>
	
	sw $10, 21856($9) #linha horizontal BAIXO >>
	sw $10, 22368($9) #linha horizontal BAIXO >>
	sw $10, 22880($9) #linha horizontal BAIXO >>
	
	#QUADRADO DE BAIXO ESQUERDA
	sw $10, 17528($9) #linha horizontal CIMA <<
	sw $10, 18040($9) #linha horizontal CIMA <<
	sw $10, 18552($9) #linha horizontal CIMA <<

	sw $10, 21624($9) #linha horizontal BAIXO <<
	sw $10, 22136($9) #linha horizontal BAIXO <<
	sw $10, 22648($9) #linha horizontal BAIXO <<
		
				
	addi $9, $9, 4 #prox pixel pro lado
	
	addi $11, $11, -1
	
	j linhashorizont

reset5: addi $11, $0, 11 #loop abaixo 11x
	lui $9, 0x1001  #reseta endereço 
	
linhavert:
	beq $11, $0, reset6
	
	#LINHA VERTICAL CIMA <<
	sw $10, 6300($9) #linha vertical dire << CIMA
	sw $10, 6304($9) #linha vertical dire
	sw $10, 6308($9) #linha vertical dire 
	
	sw $10, 6272($9) #linha vertical esq <<
	sw $10, 6268($9) #linha vertical esq
	sw $10, 6264($9) #linha vertical esq
										
	#QUADRADO
	sw $10, 6380($9) #linha vertical quadrado <<
	sw $10, 6384($9) #linha vertical quadrado
	sw $10, 6388($9) #linha vertical quadrado 
	
	sw $10, 6416($9) #linha vertical quadrado >>>
	sw $10, 6420($9) #linha vertical quadrado
	sw $10, 6424($9) #linha vertical quadrado
	
	#LINHA VERTICAL CIMA >>
	sw $10, 6496($9) #linha vertical esq >>
	sw $10, 6500($9) #linha vertical esq >>
	sw $10, 6504($9) #linha vertical esq >>
	
	sw $10, 6540($9) #linha vertical dire >> CIMA
	sw $10, 6536($9) #linha vertical dire >>
	sw $10, 6532($9) #linha vertical dire >>
		
	#LINHA VERTICAL BAIXO <<
	sw $10, 17564($9) #linha vertical dire << BAIXO
	sw $10, 17568($9) #linha vertical dire << BAIXO
	sw $10, 17572($9) #linha vertical dire << BAIXO
	
	sw $10, 17536($9) #linha vertical esq << BAIXO
	sw $10, 17532($9) #linha vertical esq <<
	sw $10, 17528($9) #linha vertical esq <<
	
	#LINHA VERTICAL BAIXO >>
	sw $10, 17760($9) #linha vertical esq >>
	sw $10, 17764($9) #linha vertical esq >>
	sw $10, 17768($9) #linha vertical esq >>
	
	sw $10, 17804($9) #linha vertical esq >>
	sw $10, 17800($9) #linha vertical esq >>
	sw $10, 17796($9) #linha vertical esq >>
	

	addi $9, $9, 512 #prox pixel pra baixo
	
	addi $11, $11, -1
	
	j linhavert
	
reset6: addi $11, $0, 8 #loop abaixo 8x
	lui $9, 0x1001  #reseta endereço 
	
barra1: #barra esquerda
	beq $11, $0, reset7	
	
	sw $13, 0($19) #BARRA
	
	addi $19, $19, 4 #prox pixel do lado >>
	
	addi $11, $11, -1
	
	j barra1
	
reset7: addi $11, $0, 8 #loop abaixo 8x
	lui $9, 0x1001  #reseta endereço 

barra2: #barra direita
	beq $11, $0, reset8
	
	sw $13, 0($21) #BARRA
	
	addi $21, $21, -4 #prox pixel do lado <<
	
	addi $11, $11, -1
	
	j barra2

reset8: addi $11, $0, 6 #loop abaixo 6x
	lui $9, 0x1001  #reseta endereço 
	
escadinha: #quadrado em cima
	beq $11, $0, reset9
	
	#LINHAS DE CIMA
	sw $10 1536($9)
	sw $10 2048($9)
	sw $10 2560($9)
	
	sw $10 2024($9)
	sw $10 2536($9)
	sw $10 3048($9)

	
	addi $9, $9, 4
	
	addi $11, $11, -1
	
	j escadinha
	
reset9: addi $11, $0, 8 #loop abaixo 8x
	lui $9, 0x1001  #reseta endereço 
	
linhahorizont2: #escadinha esquerda
	beq $11, $0, reset10

	sw $10, 29220($9) #primeira linha da esquerda
	sw $10, 28708($9)
	sw $10, 28196($9)	

	sw $10, 29628($9) #primeira linha da direita
	sw $10, 29116($9) 
	sw $10, 28604($9)
	
	addi $9, $9, 4 #prox pixel
	
	addi $11, $11, -1
	
	j linhahorizont2

reset10: addi $11, $0, 4 #loop abaixo 4x
	lui $9, 0x1001  #reseta endereço ,
	
linhahorizont3: #escadinha direita
	beq $11, $0, reset11

	sw $10, 27684($9) #primeira linha da esquerda
	sw $10, 27172($9)
	sw $10, 26660($9)	

	sw $10, 28108($9) #primeira linha da direita
	sw $10, 27596($9) 
	sw $10, 27084($9)
	
	addi $9, $9, 4 #prox pixel
	
	addi $11, $11, -1
	
	j linhahorizont3

reset11: addi $11, $0, 8 #loop abaixo 2x
	lui $9, 0x1001  #reseta endereço 

	addi $7, $0, -512 # MOVIMENTO DA BOLA PRA CIMA
			
branco:
	bne $0, $0 fimTela
	
	addi $6, $0, 1

	lui $17, 0xffff #verifica se alguma tecla foi digitada
			#prox endereço (+4) verifica QUAL tecla foi digitada
	
	lw $18, 4($17)
	
cont2:	
	jal bola

#!!PONTO BRANCO GIRA DIREITA BAIXO
	#APAGA ESQUERDA
	sw $12 14768($9)
	sw $12 14256($9)
	#LIGA BAIXO
	sw $13 15284($9) 
	sw $13 15288($9) #direita
	jal delay

	#LIGA DIREITA	
	sw $13 14780($9)
	sw $13 14268($9)
	jal delay

	#APAGA BAIXO
	sw $12 15284($9) #direita #baixo
	sw $12 15288($9) #direita
	#LIGA CIMA	
	sw $13 13748($9) #direita cima
	sw $13 13752($9) #direita
	jal delay
	#APAGA DIREITA
	sw $12 14780($9)
	sw $12 14268($9)

	#LIGA ESQUERDA
	sw $13 14768($9)
	sw $13 14256($9)
	jal delay
	#APAGA CIMA
	sw $12 13748($9) #direita cima
	sw $12 13752($9) #direita
	#FIM QUADRADO DIREITA
	
#PONTO BRANCO GIRA ESQUERDA <<		

	#APAGA ESQUERDA
	sw $12 14404($9)
	sw $12 13892($9)
	#!!LIGA BAIXO
	sw $13 14920($9)
	sw $13 14924($9)
	jal delay

	#LIGA DIREITA
	sw $13 14416($9)
	sw $13 13904($9)
	jal delay
	#APAGA BAIXO
	sw $12 14920($9)
	sw $12 14924($9)
		
	#LIGA CIMA
	sw $13 13384($9) #esquerda CIMA
	sw $13 13388($9) #esquerda
	jal delay
	#APAGA DIREITA
	sw $12 14416($9)
	sw $12 13904($9)
	#APAGA CIMA 
	sw $12 13384($9) #esquerda CIMA
	sw $12 13388($9) #esquerda
	#LIGA ESQUERDA
	sw $13 14404($9)
	sw $13 13892($9)
	jal delay
	#FIM QUADRADO ESQUERDA
	
	
	addi $15, $0, 'a'
	beq $18, $15, apagadorbarra1

	addi $15, $0, 'd'
	beq $18, $15, apagadorbarra2
	
	jal bola

	
	beq $23, $0, movimento
	#colisao
	beq $23, 1, batecima
	beq $23, 2, batebaixo
	beq $23, 3, bateesquerda
	beq $23, 4, batedireita
	beq $23, 5, batediagcimaesq
	beq $23, 6, batediagbaixoesq
	beq $23, 7, batediagcimadireit
	beq $23, 8, batediagbaixodireit
	
	addi $15, $0, 't' #adiciona T
	beq $18, $15, fimTela #veficia se o T foi apertado, se sim, termina o jogo
	addi $15, $0, 'p'
	beq $6, 1, cont2
	beq $18, $15, start #verifica se a tecla foi P, se sim, a bola se move
	
	

continue:
	add $23, $0, $0
movimento: 
	jal deletebola
	add $16, $16, $7
	jal bola
	
	addi $15, $0, 't' #adiciona T
	beq $18, $15, fimTela #veficia se o T foi apertado, se sim, termina o jogo
	addi $15, $0, 'p'
	beq $6, 1, cont2
	beq $18, $15, start #verifica se a tecla foi P, se sim, a bola se move
	
	j branco
	#FIM LOOP

			
start:
	addi $6, $0, 1
	j branco
	
batecima:
	addi $5, $0, 2 #1
	addi $2, $0, 42 #num aleatorio de 0 a 1
	syscall
	beq $4, $0, cima2
	
	addi $7, $0, 508
	j continue
cima2:
	addi $7, $0, 516	
	j continue
batebaixo:	
	addi $5, $0, 2 #1
	addi $2, $0, 42 #num aleatorio de 0 a 1
	syscall
	beq $4, $0, baixo2
	
	addi $7, $0, -516
	j continue
baixo2:
	addi $7, $0, -508		
	j continue
	
bateesquerda:
	addi $5, $0, 2 #1
	addi $2, $0, 42 #num aleatorio de 0 a 1
	syscall
	beq $4, $0, esquerda2

	addi $7, $0, 516
	
	j continue
	
esquerda2:
	addi $7, $0, -516
	
batedireita:	
	addi $5, $0, 2 #1
	addi $2, $0, 42 #num aleatorio de 0 a 1
	syscall
	beq $4, $0, direita2
	addi $7, $0, -508
	
	j continue
	
direita2:
	addi $7, $0, 508
	
	j continue
	
#DIAGONAIS

batediagcimaesq:
	addi $7, $0, 516
	
	j continue
	
batediagbaixoesq:
	addi $7, $0, -516
	
	j continue
	
batediagcimadireit:
	addi $7, $0, 508
	
	j continue
	
batediagbaixodireit:
	addi $7, $0, -508
	
	j continue
	
bola: 
	add $3, $31, $0
	lui $8, 0x1001
	add $8, $8, $16
	
	jal colisaobola
	sw $10, 0($8)#BOLA

	add $31, $3, $0
	jr $31
				

deletebola:
	add $3, $31, $0
	lui $8, 0x1001
	add $8, $8, $16
	sw $12, 0($8)#BOLA
	add $31, $3, $0
	jr $31

movebolacima:
	jal deletebola
	addi $16, $16 -512
	jal bola
	
	j branco

apagadorbarra1:
	addi $11, $0, 8
apagabarra1: #move barra esquerda
	beq $11, $0, movebarra1
	
	sw $12, 0($19) #BARRA	
	addi $19, $19, -4 #prox pixel do lado >>	
	addi $11, $11, -1
	
	j apagabarra1

movebarra1:
	addi $19, $0, 0x10017CD0 #endereço inicial da barra1 <<
	addi $11, $0, 8 #loop abaixo 2x
	j movebarra11
movebarra11:
	beq $11, $0, delaybarra1
	sw $13, 0($19)
	addi $19, $19, -508
	addi $11, $11, -1	
	j movebarra11

delaybarra1:
	jal delay2

voltarbarra1:
	addi $11, $0, 8
voltarbarra11:
	beq $11, $0, desenhabarra1
	sw $12, 0($19)
	addi $19, $19, +508
	addi $11, $11, -1
	j voltarbarra11
		
desenhabarra1:
	addi $11, $0, 8
desenhabarra11:
	beq $11, $0, resetbarra1
	sw $13, 0($19)
	addi $19, $19, 4
	addi $11, $11, -1
	j desenhabarra11
	
resetbarra1:

	j movimento

apagadorbarra2:
	addi $11, $0, 8	
apagabarra2:
	beq $11, $0, movebarra2
	
	sw $12, 0($21) #BARRA	
	addi $21, $21, 4 #prox pixel do lado >>	
	addi $11, $11, -1
	
	j apagabarra2
	
movebarra2:
	addi $21, $0, 0x10017D30 #endereço inicial da barra1 <<
	addi $11, $0, 8 #loop abaixo 2x
movebarra22:
	beq $11, $0, delaybarra2
	sw $13, 0($21)
	addi $21, $21, -516
	addi $11, $11, -1	
	j movebarra22
			
delaybarra2:
	jal delay2
	
voltarbarra2:
	addi $11, $0, 8
voltarbarra22:
	beq $11, $0, desenhabarra2
	sw $12, 0($21)
	addi $21, $21, +516
	addi $11, $11, -1
	j voltarbarra22

desenhabarra2:
	addi $11, $0, 8
desenhabarra22:
	beq $11, $0, resetbarra2
	sw $13, 0($21)
	addi $21, $21, -4
	addi $11, $11, -1
	j desenhabarra22
	
resetbarra2:

	j movimento
	
		
			
fimTela:
	addi $2, $0, 10
	syscall
	
colisaobola:

	add $24, $0, $8
	
	addi $24, $24, -4
	lw $22, 0($24)#pixel a esquerda
	beq $22, 0x007a39db, moveboladireita
	
	addi $24, $24, -512
	lw $22, 0($24)#pixel diagonal esquerda
	beq $22, 0x007a39db, moveboladireita		

	addi $24, $24, 512
	addi $24, $24, 8
	lw $22, 0($24)#pixel a direita
	beq $22, 0x007a39db, movebolaesquerda	
	
	addi $24, $24, -512
	lw $22, 0($24)#pixel diagonal direita
	beq $22, 0x007a39db, movebolaesquerda		

	addi $24, $24, -4
	lw $22, 0($24)#pixel a cima
	beq $22, 0x007a39db, movebolabaixo
	
	addi $24, $24, 1024
	lw $22, 0($24)#pixel baixo
	beq $22, 0x007a39db, movebolacima2 #colisao com roxo
	beq $22, 0x00aea6ba, movebolacima2 #colisao com cinza(barras)
	
			
	addi $24, $24, -4
	lw $22, 0($24)#pixel diagonal baixo esquerda
	beq $22, 0x007a39db, movebolacima2 #colisao com roxo
	
	addi $24, $24, 8
	lw $22, 0($24)#pixel diagonal baixo direita
	beq $22, 0x007a39db, movebolacima2 #colisao com roxo


fimcolisao:
	jr $31
	
movebolabaixo:
	addi $23, $0, 1
	j fimcolisao
	
movebolacima2:
	addi $23, $0, 2
	j fimcolisao
	
moveboladireita:
	addi $23, $0, 3
	j fimcolisao
	
movebolaesquerda:
	addi $23, $0, 4
	j fimcolisao
	
#DIAGONAIS

moveboladiagonalesquerdacima:
	addi $23, $0, 5
	j fimcolisao	
	
moveboladiagonalesquerdabaixo:
	addi $23, $0, 6
	j fimcolisao
	
moveboladiagonaldireitacima:
	addi $23, $0, 7
	j fimcolisao
	
moveboladiagonaldireitabaixo:
	addi $23, $0, 8
	j fimcolisao
	
delay:addi $20, $0, 5000
forST:   beq $20, $0, fimST
         addi $20, $20, -1        
         j forST  

fimST:   jr $31
         
delay2:addi $20, $0, 5000
forST2:   beq $20, $0, fimST2
         addi $20, $20, -1        
         j forST2 
         
fimST2:   jr $31
