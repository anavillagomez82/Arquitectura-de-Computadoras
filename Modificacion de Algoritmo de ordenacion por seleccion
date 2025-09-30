        .data
array:  .word 7, 2, 9, 4, 5
n:      .word 5
msg:    .asciiz "Arreglo ordenado inverso:\n"

        .text
        .globl main

main:
        lw   $t0, n
        la   $t1, array
        addi $t2, $zero, 0   # i = 0

outer_loop:
        beq  $t2, $t0, end

        # Llamar a min
        add  $a0, $t1, $zero
        add  $a1, $t0, $zero
        add  $a2, $t2, $zero
        jal  min

        # Intercambiar array[i] con array[v1]
        mul  $t3, $t2, 4
        add  $t3, $t3, $t1
        lw   $t4, 0($t3)

        mul  $t5, $v1, 4
        add  $t5, $t5, $t1
        lw   $t6, 0($t5)

        sw   $t6, 0($t3)
        sw   $t4, 0($t5)

        addi $t2, $t2, 1
        j outer_loop

end:
        li   $v0, 4
        la   $a0, msg
        syscall

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

# Procedimiento min

min:
        add  $t0, $a2, $zero
        add  $v1, $a2, $zero
        mul  $t1, $t0, 4
        add  $t1, $t1, $a0
        lw   $v0, 0($t1)

min_loop:
        addi $t0, $t0, 1
        beq  $t0, $a1, min_end
        mul  $t1, $t0, 4
        add  $t1, $t1, $a0
        lw   $t2, 0($t1)
        slt  $t3, $t2, $v0   # aquí la comparación cambia
        beq  $t3, $zero, min_loop
        add  $v0, $t2, $zero
        add  $v1, $t0, $zero
        j min_loop

min_end:
        jr $ra
