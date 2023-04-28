# Autor: Margarita Banca Escobar Alonso
# Fecha ultima modificacion: 

size = 4     # bytes que ocupa cada elemento
maxdim = 40  # dimension maxima que puede tener un vector
    .data
v1:         .space 160
v2:         .space 160 
n1:         .word 0 # numero eltos vector 1. Inicialmente suponemos vacios
n2:         .word 0 # numero eltos vector 2. Inicialmente suponemos vacios
space:      .asciiz " "
newline:    .asciiz "\n"
title:      .asciiz "\nPractica 4 de Principios de Computadores. Subrutinas.\n"
menu:       .ascii  "\n(1) Cambiar dimension de un vector\n(2) Cambiar un elemento de un vector\n"
            .ascii  "(3) Invertir un vector\n(4) Calcular el producto escalar de dos vectores\n"
            .asciiz "(0) Salir\n\nElija opcion: ";
cabvec:     .asciiz "\nVector con dimension "
error_op:   .asciiz "\nError: opcion incorrecta.\n"
elige_vec:  .asciiz "\nElija vector para realizar la operacion (1) para v1 (2) para v2: "
elige_elto: .asciiz "\nElija el indice del elemento a cambiar: "
newval:     .asciiz "\nIntroduce nuevo valor para el elemento elegido: "
newdim:     .asciiz "\nIntroduzca nueva dimension para el vector (1-40): "
error_dim:  .asciiz "\nError: Dimension incorrecta.\n"
error_ind:  .asciiz "\nError: Indice incorrecto.\n"
error_d_dim:    .asciiz "\nError: Los vectores tienen distinta dimension.\n"
msg_prodesc:    .asciiz "\nEl producto escalar de los vectores es: "
msg_fin:    .asciiz "\nFIN DEL PROGRAMA."


    .text

# enteros = $a0-a3,flotantes = $t12-$t15, $sp == usar la pila(stack pointer), valor de retorno $v0,$v1 $f0,$f3
# 
# $a0 =
# $a1 =
# $a2 =
# $a3 = 

#void print_vect(float* vector,int size, std::string espacio = " "){


print_vec:

    # move $a0,$s0 # --> v1
    # move $a1,$s2 # --> n1

        add $sp,$sp,-24
        sw $s0, 0($sp)
        sw $s1, 4($sp)
        sw $s2, 8($sp)
        sw $s3, 12($sp)
        sw $s4, 16($sp)
        sw $ra, 20($sp)

        move $s0,$a0
        move $s1,$a1
        move $s2,$a2

        move $s3, $zero
    # for(int i = 0, i < size, i++){
    for_print_vec:
        bge $s3, $s1, print_vec_fin

    #std::cout << v[i] << espacio;
        mul $s4, $s3, 4 # i
        add $s4, $s4, $s0 # v[i]
        l.s $f12, 0($s4)

        li $v0, 2
        syscall

        li $v0, 4
        move $a0, $s2
        syscall

        add $s3,$s3,1
        j for_print_vec
        #}
    #}
        lw $s0, 0($sp)
        lw $s1, 4($sp)
        lw $s2, 8($sp)
        lw $s3, 12($sp)
        lw $s4, 16($sp)
        lw $ra, 20($sp)
        add $sp, $sp, 24

    print_vec_fin:

        jr $ra

#void change_elto(float* vector, int position, float val){

change_elto:
    #    move $a0,$s1    v1/v2
    #    move $a1,$s6  posicion
    #    move $a2,$s7   val

        #v[position] = val;
        move $t0, $a0
        move $t1, $a1
        mov.s $f4, $f12


        mul $t2, $t1, 4 # pos
        add $t2, $t2, $t0 # v[pos]
        s.s $f4, 0($t2)

    #}
        jr $ra

    change_elto_fin:
        
    
#void swap(float* vector, int pos1, int pos2){

swap:
    #$a0 --> direccion vector
    #$a1 --> primer elemetno
    #$a2 --> segundo element

        move $t0, $a0
        move $t1, $a1
        move $t2, $a2
        #float aux = v[pos1];
            mul $t3,$t1,4
            add $t3, $t3, $t0
            l.s $f4,0($t3)

        #v[pos1] = v[pos2];
            mul $t4,$t2,4
            add $t4, $t4, $t0
            l.s $f6,0($t4)

            s.s $f6,0($t3)

        #v[pos2] = aux; 
            s.s $f4,0($t4)
            
    #}
        jr $ra

    swap_fin:
  

#void mirror(float* vector, int size){

mirror:
    #   move $a0,$s0
    #   move $a1,$s2

        add $sp,$sp,-4
        sw $ra, 0($sp)

        
        #if(size == 0 || size == 1){
    if_mirror_size:
        beqz $a1,mirror_return
        beq $a1,1,mirror_return
        #}
    continue_mirror:
        #swap(v,0,size-1);
        add $sp $sp -12
        sw $ra, 8($sp)
        sw $a0, 4($sp)
        sw $a1, 0($sp)

        move $t0, $a1

        move $a0,$a0
        li $a1,0
        add $a2,$t0, -1
        jal swap

        lw $a1, 0($sp)
        lw $a0, 4($sp)    
        lw $ra, 8($sp)
        add $sp, $sp 12

        #mirror(v+1,size-2);

        add $a0,$a0,4
        add $a1,$a1, -2
        jal mirror

        lw $ra, 0($sp)
        add $sp, $sp, 4

    mirror_return:
        jr $ra
    mirror_fin:

#}

#float mult_add(float pos1, float pos2, float result){

#}

mult_add:

        #return pos1*pos2+result;

        mul.s $f4,$f12,$f13 
        add.s $f14,$f14,$f4
        mov.s $f0,$f14

        jr $ra

    mult_add_fin:

#float prod_esc(float* v1, float* v2, int size){

prod_esc:

        #    move $a0,$s0
        #    move $a1,$s1
        #    move $a2,$s3

    #if (size == 0){
    if_prod_esc:
        li.s $f0,0.0
        beqz $a1,end_if
        #}
        continue_prod_esc:
            #float result = 0;
            li.s $f3,0.0
            li $s3,0
            #for(int i = 0, i < size, i++){
        if_prod_esc2:
            bge $s3,$a2,end_if

            add $sp $sp -20
            sw $a2, 16($sp)
            sw $s3, 12($sp)
            sw $ra, 8($sp)
            sw $a0, 4($sp)
            sw $a1, 0($sp)


                #result = mult_add(v1[i],v2[i],result);
            #}
            l.s $f12,0($a0)
            l.s $f13,0($a1)
            mov.s $f14,$f4
            jal mult_add
            mov.s $f4, $f0

            lw $a2, 16($sp)
            lw $s3, 12($sp)
            lw $ra, 8($sp)
            lw $a0, 4($sp)
            lw $a1, 0($sp)
            add $sp, $sp 20

            add $s3,$s3,1
            j if_prod_esc2
            #return result;
        end_if:
            mov.s $f0, $f4
            jr $ra

        #} 

    prod_esc_fin:


#int main(void){
#

main:


    #$s0 --> v1
    #$s1 --> v2
    #$s2 -->  n1
    #$s3 -->  n2
    #$s4 --> opcion
    #$s5 -->
    #
    #
    #    std::cout << "Practica 4 de Principios de Computadores. Subrutinas." << std::endl;
    # empezamos el programa
        li $v0,4
        la $a0,title
        syscall

    #    float v1[40], v2[40];
        la $s0, v1
        la $s1, v2
    #    int n1{0}, n2{0};
        lw $s2, n1
        lw $s3, n2
    #    for(int i{0}; i < 40; i++){
        move $t1, $zero

for1:
    bge $t1, 40, fin_for1
    #        v1[i] = i + 10;

        mul $t2, $t1, 4
        add $t2, $t2, $s0
        add $t3, $t1,10

        mtc1 $t3, $f4
        cvt.s.w $f4, $f4
        s.s $f4, 0($t2)

    #        n1++;
        add $t6, $t1, 1
        move $s2, $t6
        sw $s2, n1

        add $t1, $t1, 1
        j for1
    #        v2[i] = 40 -i;
fin_for1:

    move $t1, $zero

for2:
    bge $t1, 40, while

    mul $t4, $t1, 4
    add $t4, $t4, $s1
    li $t8, 40
    sub $t5, $t8, $t1

    mtc1 $t5, $f5
    cvt.s.w $f5, $f5
    s.s $f5, 0($t4)
    #    }
    add $t6, $t1, 1
    move $s3, $t6 
    sw $s3, n2

    add $t1, $t1, 1
    j for2
    #    while(option != 0){
while:
    #   int option{1};
        li $s4, 0
    #    std::cout << "Vector con dimension  " << std::setprecision(8)<< n1 << std::endl; 
        li $v0,4
        la $a0,cabvec
        syscall

        li $v0,1
        lw $a0, n1
        syscall

        li $v0,4
        la $a0,newline
        syscall

    #    print_vect(v1,n1);
        la $a0,v1 # --> v1
        lw $a1,n1 # --> n1
        la $a2, space
        jal print_vec

    #    std::cout << std::endl;
        li $v0,4
        la $a0,newline
        syscall

    #    std::cout << "Vector con dimension  "  << n2 << std::endl; 
        li $v0,4
        la $a0,cabvec
        syscall
        
        li $v0,1
        lw $a0, n2
        syscall

        li $v0,4
        la $a0,newline
        syscall
    #    print_vect(v2,n2);
        la $a0,v2 # --> v2
        lw $a1, n2 # --> n2
        la $a2, space
        jal print_vec

    #    std::cout << std::endl;
        li $v0,4
        la $a0,newline
        syscall
menuprograma:
    #    std::cout << "(1) Cambiar dimension de un vector" << std::endl;
    #	std::cout << "(2) Cambiar un elemento de un vector" << std::endl;
    #	std::cout << "(3) Invertir un vector" << std::endl;
    #	std::cout << "(4) Calcular el producto escalar de dos vectores" << std::endl;
    #	std::cout << "(0) Salir" << std::endl << std::endl;
    #   
    #	std::cout << "Introducir opción : ";

        li $v0,4
        la $a0, menu
        syscall

    #	std::cin >> option;

        li $v0,5
        syscall
        move $s4,$v0

    #    switch(option){
            beqz $s4,fin_programa       # en el caso de q se introduzca 0
            beq $s4,1,case1     # en el caso de q se introduzca 1
            beq $s4,2,case2     # en el caso de q se introduzca 2
            beq $s4,3,case3     # en el caso de q se introduzca 3
            beq $s4,4,case4     # en el caso de q se introduzca 4
            bltz $s4,default        # en el caso de q se introduzca un valor que no sea valido
            bgt $s4,4,default       # en el caso de q se introduzca un numero mayor que 4

switch:

#        case 1:{
case1:
    #            int elegir_vector{0};
        li $s5,0
    #            int dimension{0};
        li $s6,0
    #            std::cout << "Elija vector para realizar la operacion (1) para v1 (2) para v2: " << std::endl;
        li $v0,4
        la $a0, elige_vec
        syscall
    #            std::cin >> elegir_vector;
        li $v0,5
        syscall
        move $s5,$v0
    #            std::cout << "Introduzca nueva dimension para el vector (1-40):" << std::endl;
        li $v0,4
        la $a0, newdim
        syscall
    #            std::cin >> dimension;
        li $v0,5
        syscall
        move $s6,$v0

    #            if((dimension <= 0)||(dimension > 40)){
    if_case1:

        bgt $s6,40, error_case1_dim
        ble $s6,0, error_case1_dim
        j if_case1_comienzo
        
    #                std::cout << "Error: Dimension incorrecta. " <<std::endl;
    error_case1_dim:

        li $v0,4
        la $a0,error_dim
        syscall
    #                break;
        j while

    #            }
    if_case1_comienzo:
    #            if(elegir_vector == 1){
    if_case1_vector1:
        bne $s5,1,if_case1_vector2
    #                n1 = dimension;
        move $s2,$s6
        sw $s2, n1
        j fin_case1   #    }
    #            else if(elegir_vector == 2){
    if_case1_vector2:
        bne $s5,2,if_case1_vector_error
    #                n2 = dimension;
        move $s3, $s6
        sw $s3, n2
        j fin_case1
    #            }
    if_case1_vector_error:
    #            else{
    #                std::cout << "Error: opcion incorrecta." << std::endl;
    li $v0,4
    la $a0,error_op
    syscall

    j while
    #            }
    #        }
    #            break;
fin_case1:
    j while

#        case 2:{
case2:
    #            int elegir_vector{0};
        li $s5,0
    #            int position{0};
        li $s6,0
    #            float val{0};
        li.s  $f20,0.0
    #            std::cout << "Elija vector para realizar la operacion (1) para v1 (2) para v2: " << std::endl;

        li $v0,4
        la $a0, elige_vec
        syscall
    #            std::cin >> elegir_vector;
        li $v0,5
        syscall
        move $s5,$v0

    #            if((elegir_vector != 1)&&(elegir_vector != 2)){
    if_case2_elegir_vector:
        ble $s5,0,error_case2_opcion
        bgt $s5,2,error_case2_opcion
        j if_case2_continue

    error_case2_opcion:
        #                std::cout << "Error: opcion incorrecta." << std::endl;
            li $v0,4
            la $a0, error_op
            syscall
        #                break;
            j while
        #            }
        #
        #            std::cout << "Elija el indice del elemento a cambiar: " << std::endl;

    if_case2_continue:

        li $v0,4
        la $a0, elige_elto
        syscall
    #            std::cin >> position;
        li $v0, 5
        syscall
        move $s6, $v0

    #            if ((elegir_vector == 1 && (position <= 0 || position > n1))||(elegir_vector == 2 && (position <= 0 || position > n2))){
    case2_if:
        lw $s2, n1
        lw $s3, n2
        beq $s5,1, case2_if_vector1
        beq $s5,2, case2_if_vector2

        case2_if_vector1:
            bltz $s6, error_case2_indice
            bgt $s6, $s2 ,error_case2_indice
            j if_case2_vector1
        case2_if_vector2:
            blt $s6,0,error_case2_indice
            bgt $s6, $s3,error_case2_indice
            j if_case2_vector2

    #                std::cout << "Error: Indice incorrecto." << std::endl;

    error_case2_indice:
        li $v0,4
        la $a0,error_ind
        syscall
    #                break;
        j while
    #            }
    #
    #
    #            if(elegir_vector == 1){
    if_case2_vector1:
        #            std::cout << "Introduce nuevo valor para el elemento elegido:" << std::endl;
        li $v0,4
        la $a0, newval
        syscall
    #            std::cin >> val;
        li $v0, 6
        syscall
        mov.s $f20,$f0
    #                change_elto(v1,position-1, val);
        la $a0, v1
        sub $s6,$s6,1
        move $a1,$s6
        mov.s $f12, $f20
        jal change_elto

        j while
    #            }
    #            else if(elegir_vector == 2){
    if_case2_vector2:
        #            std::cout << "Introduce nuevo valor para el elemento elegido:" << std::endl;
        li $v0,4
        la $a0, newval
        syscall
    #            std::cin >> val;
        li $v0,6
        syscall
        mov.s $f20,$f0
    #                change_elto(v2,position-1, val);
        la $a0, v2
        sub $s6,$s6,1
        move $a1,$s6
        mov.s $f12, $f20
        jal change_elto
        j while
    #            }
    #            break;
    fin_case2:
        j while
    #        case 3:{
case3:
    #            int elegir_vector{0};
        li $s5,0
    #            std::cout << "Elija vector para realizar la operacion (1) para v1 (2) para v2: " << std::endl;
        li $v0,4
        la $a0, elige_vec
        syscall
    #            std::cin >> elegir_vector;
        li $v0,5
        syscall
        move $s5,$v0
    #            if((elegir_vector != 1)&&(elegir_vector != 2)){
    if_case3_elegir_vector:

        ble $s5,0,error_case3_opcion
        bgt $s5,2,error_case3_opcion
        j if_caso3_mirror

    error_case3_opcion:
    #                std::cout << "Error: opcion incorrecta." << std::endl;
        li $v0,4
        la $a0, error_op
        syscall
    #                break;
        j while
    #            }
    #
    if_caso3_mirror:
        beq $s5,1,if_caso3_mirror_vector1
        beq $s5,2,if_case3_elegir_vector2
    #            if(elegir_vector == 1){
    if_caso3_mirror_vector1:
    #                mirror(v1,n1);
        la $a0, v1
        lw $a1, n1
        jal mirror
        j while
    #            }+
    #            else if(elegir_vector == 2){
    if_case3_elegir_vector2:
    #                mirror(v2,n2);
        la $a0, v2
        lw $a1, n2
        jal mirror
        j while
    #            }
    #        }
    #            break;
    fin_case3:
        j while
    #        case 4:{
case4:
        lw $s2, n1
        lw $s3, n2
    #            if(n1 != n2){
        beq $s2,$s3, case4_prod_vec
    #                std::cout << "Error: Los vectores tienen distinta dimension." << std::endl;
        li $v0,4
        la $a0,error_dim
        syscall
    #                break;
        j while
    #            }
    case4_prod_vec:
    #            std::cout << "El producto escalar de los vectores es: " << prod_esc(v1,v2,n1) << std::endl;
    #        }
        li $v0,4
        la $a0,msg_prodesc
        syscall

        la $a0, v1
        la $a1, v2
        lw $a2, n1

        jal prod_esc
    #            break;
    fin_case4:
        li $v0, 2
        mov.s $f12, $f0
        syscall

        j while
#        case 0:
case0:
    j fin_programa
#            break;
default:
    #        default:{
    #            std::cout << "Error: opcion incorrecta." << std::endl;
    #        }
        li $v0,4
        la $a0,error_op
        syscall
    #            break;
        j while
    #    }
    #
#    std::cout << "FIN DEL PROGRAMA." << std::endl;
#    }
#}

# fin del programa
fin_programa:

    li $v0,4
    la $s0, msg_fin
    syscall
