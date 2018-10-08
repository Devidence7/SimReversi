.global patron_volteo_arm_arm

.equ 	DIM,	0x08

patron_volteo_arm_arm:
@Prologo
MOV IP,SP
STMDB sp!, {r4-r10,FP,IP,LR,PC}
SUB FP,IP,#4

mov r4, r0			@r4=tablero
mov r5, r1			@r5=*longitud
mov r6, r2			@r6=FA
mov r7, r3			@r7=CA

@cargar los parametros r4-r6 con lo argumentos restantes
ldr r8, [IP]		@r8=SF
ldr r9, [IP, #4]	@r9=SC
ldr r10, [IP, #8]	@r10=color

add r6, r6, r8		@FA = FA + SF
add r7, r7, r9		@CA = CA + SC

@nos quedamos solo con los 8 primeros bits [0-255]
and r6, r6, #0xFF
and r7, r7, #0xFF

@funcion incrustada ficha_valida

cmp r6, #DIM
bge pos_invalida	@if NOT (FA<DIM)
cmp r6, #0
blt pos_invalida	@if NOT (FA>=0)
cmp r7, #DIM
bge pos_invalida	@if NOT (CA<DIM)
cmp r7, #0
blt pos_invalida	@if NOT (CA>=0)

@falta ultima parte del if y su contenido


@fin de funcion incrustada ficha_valida

@cmp r3, #1			@posicion_valida==1?
@bne	pos_invalida
cmp r0, r10			@casilla==color?
beq casilla_igual_color
mov r5, r0

@(posicion_valida == 1) && (casilla != color)
ldr r0, [r5]
add r0, r0, #1
str r0, [r5]
@mover a r0-r3 los parametros correspondientes
mov r0, r4	@tablero
mov r1, r5	@*longitud
mov r2, r6	@FA
mov r3, r7	@CA
bl patron_volteo_arm_c
bl fin_patron_volteo_arm_c

patron_encontrado:
mov r0, #1	@la funcion devuelve 1 (patron encontrado)
bl fin_patron_volteo_arm_c

casilla_igual_color:
@(posicion_valida == 1) && (casilla == color)
cmp r5, #0
bne patron_encontrado

pos_invalida:
@(posicion_valida != 1)
mov r0, #0			@la funcion devuelve 0 (patron no encontrado)

fin_patron_volteo_arm_c:
@Epilogo
SUB SP, FP, #40
LDMIA SP, {r4-r10,FP,SP,PC}

@Fin
.end
#        END