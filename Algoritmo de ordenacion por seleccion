        .data
array:  .word 7, 2, 9, 4, 5
n:      .word 5
msg:    .asciiz "Arreglo ordenado:\n"

        .text
        .globl main

main:
        lw   $t0, n          # tamaño del arreglo
        la   $t1, array      # dirección base del arreglo
        addi $t2, $zero, 0   # índice inicial i = 0

outer_loop:
        beq  $t2, $t0, end   # si i == n, terminar

        # Llamar a max (parámetros: base+i, n-1, i)
        add  $a0, $t1, $zero # inicio arreglo
        add  $a1, $t0, $zero # tamaño
        add  $a2, $t2, $zero # índice actual
        jal  max

        # v0 = valor máximo, v1 = índice máximo
        # Intercambiar array[i] con array[v1]
        mul  $t3, $t2, 4
        add  $t3, $t3, $t1
        lw   $t4, 0($t3)     # array[i]

        mul  $t5, $v1, 4
        add  $t5, $t5, $t1
        lw   $t6, 0($t5)     # array[v1]

        sw   $t6, 0($t3)     # array[i] = max
        sw   $t4, 0($t5)     # array[v1] = valor original de i

        addi $t2, $t2, 1     # i++
        j outer_loop

end:
        li   $v0, 4
        la   $a0, msg
        syscall

        # imprimir arreglo ordenado
        addi $t2, $zero, 0
print_loop:
        beq  $t2, $t0, exit
        mul  $t3, $t2, 4
        add  $t3, $t3, $t1
        lw   $a0, 0($t3)
        li   $v0, 1
        syscall
        li   $v0, 11
        li   $a0, 32
        syscall
        addi $t2, $t2, 1
        j print_loop

exit:
        li   $v0, 10
        syscall

# ----------------------
# Procedimiento max
# Entrada:
#   a0 = base array
#   a1 = tamaño
#   a2 = índice actual (i)
# Salida:
#   v0 = valor máximo
#   v1 = índice máximo
# ----------------------
max:
        add  $t0, $a2, $zero   # j = i
        add  $v1, $a2, $zero   # índice máximo
        mul  $t1, $t0, 4
        add  $t1, $t1, $a0
        lw   $v0, 0($t1)       # valor máximo

max_loop:
        addi $t0, $t0, 1
        beq  $t0, $a1, max_end
        mul  $t1, $t0, 4
        add  $t1, $t1, $a0
        lw   $t2, 0($t1)
        slt  $t3, $v0, $t2
        beq  $t3, $zero, max_loop
        add  $v0, $t2, $zero
        add  $v1, $t0, $zero
        j max_loop

max_end:
        jr $ra

PSEUDOCODIGO:
para i = 0 hasta n-1:
    (max_val, pos) = max(array, i, n)
    intercambiar array[i] con array[pos]
fin
imprimir array

procedimiento max(array, i, n):
    max_val = array[i]
    pos = i
    para j = i+1 hasta n-1:
        si array[j] > max_val:
            max_val = array[j]
            pos = j
    fin
    retornar (max_val, pos)


