Demostración (código MIPS):

Igual (=) y distinto (≠): ya están soportadas por hardware:

# if (rs == rt) goto L
beq $rs, $rt, L

# if (rs != rt) goto L
bne $rs, $rt, L


Menor que (rs < rt) usando slt:

# if (rs < rt) goto L
slt $at, $rs, $rt    # $at = 1 si rs < rt, else 0
bne $at, $zero, L


Mayor que (rs > rt) equivalencia rt < rs:

# if (rs > rt) goto L
slt $at, $rt, $rs
bne $at, $zero, L


Menor o igual (rs <= rt) ≡ not (rs > rt):

# if (rs <= rt) goto L
slt $at, $rt, $rs    # $at = 1 si rt < rs (i.e., rs > rt)
beq $at, $zero, L    # si no(rt < rs) => rs <= rt => salto


Mayor o igual (rs >= rt) ≡ not (rs < rt):

# if (rs >= rt) goto L
slt $at, $rs, $rt    # $at = 1 si rs < rt
beq $at, $zero, L    # si no(rs < rt) => rs >= rt => salto


Comparaciones con cero (blez, bgez, bltz) se obtienen con beq + bltz o slt:

# if (rs <= 0) goto L    (blez)
beq $rs, $zero, L
bltz $rs, L

# if (rs >= 0) goto L    (bgez)
bltz $rs, skip
j L
skip:


Conclusión: con slt, beq, bne y bltz (instrucciones disponibles por hardware) se implementan por software todas las comparaciones solicitadas. Por tanto no se requiere modificar la lógica de la CPU.
