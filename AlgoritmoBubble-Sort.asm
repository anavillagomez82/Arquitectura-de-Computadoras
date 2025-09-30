        .data
array:  .word 7, 2, 9, 4, 5
n:      .word 5
msg:    .asciiz "Arreglo ordenado (bubble-sort):\n"

        .text
        .globl main

main:
        lw   $a1, n          # tamaño
        la   $a0, array      # dirección base
        jal  bubble_sort

        # Imprimir mensaje
        li   $v0, 4
        la   $a0, msg
        syscall

        # Imprimir arreglo ordenado
        la   $t0, array
        lw   $t1, n
        addi $t2, $zero, 0

print_loop:
        beq  $t2, $t1, exit
        mul  $t3, $t2, 4
        add  $t3, $t3, $t0
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

# -------------------------
# Procedimiento bubble_sort
# Entrada:
#   a0 = base del arreglo
#   a1 = tamaño (n)
# -------------------------
bubble_sort:
        addi $sp, $sp, -8
        sw   $ra, 4($sp)
        sw   $s0, 0($sp)

        add  $s0, $a1, $zero   # n
        addi $t0, $zero, 0     # i = 0

outer_loop:
        beq  $t0, $s0, bubble_end

        addi $t1, $zero, 0     # j = 0
        add  $t2, $s0, $zero
        sub  $t2, $t2, $t0
        addi $t2, $t2, -1      # límite: n - i - 1

inner_loop:
        beq  $t1, $t2, end_inner
        # load array[j]
        mul  $t3, $t1, 4
        add  $t3, $t3, $a0
        lw   $t4, 0($t3)

        # load array[j+1]
        addi $t5, $t1, 1
        mul  $t6, $t5, 4
        add  $t6, $t6, $a0
        lw   $t7, 0($t6)

        # if array[j] > array[j+1], swap
        slt  $t8, $t7, $t4
        beq  $t8, $zero, skip_swap
        sw   $t7, 0($t3)
        sw   $t4, 0($t6)

skip_swap:
        addi $t1, $t1, 1
        j inner_loop

end_inner:
        addi $t0, $t0, 1
        j outer_loop

bubble_end:
        lw   $ra, 4($sp)
        lw   $s0, 0($sp)
        addi $sp, $sp, 8
        jr   $ra
