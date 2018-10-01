.global patron_volteo_arm_c
@Prologo
MOV IP,SP
STMDB sp!, {r4-r10,FP,IP,LR,PC}
SUB FP,IP,#4

patron_volteo_arm_c:



@Epilogo
SUB SP, FP, #12
LDMIA SP, {r4-r10,FP,SP,PC}

@Fin
.end
#        END
