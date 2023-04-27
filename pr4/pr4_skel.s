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

#void print_vect(float* vector,int size, std::string espacio = " "){
    #for(int i = 0, i < size, i++){
        #std::cout << v[i] << espacio;
    #}
#}

# enteros = $a0-a3,flotantes = $t12-$t15, $sp == usar la pila(stack pointer), valor de retorno $v0,$v1 $f0,$f3
# 
# $a0 =
# $s1 =
# $s2 =
#

print_vec:

    add $sp,$sp,-24
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $ra, 20($sp)



print_vec_fin:

#void change_elto(float* vector, int position, float val){
    #v[position] = val;
#}

change_elto:


change_elto_fin:

#void swap(float* vector, int pos1, int pos2){
    #float aux = v[pos1];
    #v[pos1] = v[pos2];
    #v[pos2] = aux; 
#}

swap:

swap_fin:

#void mirror(float* vector, int size){
    #if(size == 0 || size == 1){
        #return;
    #}
    #swap(v,0,size-1);
    #mirror(v+1,size-2);
#}

mirror:

mirror_fin:

#float mult_add(float pos1, float pos2, float result){
    #return pos1*pos2+result;
#}

mult_add:

mult_add_fin:

#float prod_esc(float* v1, float* v2, int size){
    #if (size == 0){
        #return 0;
    #}
    #float result = 0;
    #for(int i = 0, i < size, i++){
        #result = mult_add(v1[i],v2[i],result);
    #}
    #return result;
#} 

prod_esc:

prod_esc_fin:

main:

 # empezamos el programa
    li $v0,4
    la $s0,tittle
    syscall


# muestra el menú
menuprograma:

    li $v0,4
    la $s0, menu
    syscall

# fin del programa
fin_programa:

    li $v0,4
    la $s0, msg_fin
    syscall





