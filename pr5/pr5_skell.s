# Autor: 
# Fecha ultima modificacion: 


# #include <iostream>

# const int n1 = 10;
# double v1[n1] = {10.5, 9.5, 7.25, 6.25, 5.75, 4.5, 4.25, 3.5, -1.5, -2.0};
# const int n2 = 5;
# double v2[n2] = {5.5, 4.5, 4.25, 2.5, 2.5 };

size = 8     # bytes que ocupa cada elemento

    .data
v1:         .double 10.5, 9.5, 7.25, 6.25, 5.75, 4.5, 4.25, 3.5, -1.5, -2.0
v2:         .double 5.5, 4.5, 4.25, 2.5, 2.5 
n1:         .word 10 # tamano del v1
n2:         .word 5 # numero eltos vector 2. Inicialmente suponemos vacios
space:      .asciiz " "
newline:    .asciiz "\n"
title:      .asciiz "\nMicroexamen práctico de Principio de Computadores.\n"
cabvec:     .asciiz "\nVector con dimension "
msg_ord:    .asciiz "\nVector ordenado estrictamente decrecite\n"
msg_no_ord: .asciiz "\nVector NO ordenado estrictamente decrecite\n"
msg_fin:    .asciiz "\nFIN DEL PROGRAMA.\n"

    .text
 
print_vect:

# void printvec(double v[], const int n, std::string separador) {
#     for (int i = 0; i < n; i++)
for_print_vec:



#         std::cout << v[i] << separador;
# }
print_vec_fin:


check:
# int check(double a,double b) {

#     if (a < b ) return(-1);
if_check:

    beg b,a,elseif_check
#     else if (a == b) return(0);
elseif_check:

#     else return(1);
else_check:

# }
check_fin:



ordenado:
# int ordenado(double v[], const int n) {
#     int resultado = 1;

#     for (int i = 0; i < n-1; i++)
for_ordenado:

#         if ( check(v[i],v[i+1]) != 1 ) {
if_ordenado:

#             resultado = 0;
#             break;
    jal $ra
#         }

#     return(resultado);
# }
ordenado_fin:

# int main(void) {
main:

#     std::cout << "\nVector con dimension " << n1 << std::endl;

    li $v0,4
    la $a0,cabvec
    syscall

#     printvec(v1,n1," ");

    jal print_vect
#     std::cout << std::endl;

    li $v0,4
    la $a0,newline
    syscall

#     int o = ordenado(v1,n1);

#     if (o == 1) std::cout << "\nVector ordenado estrictamente decrecite\n";
if_main:




    li $v0,4
    la $a0,msg_ord
    syscall

#     else std::cout << "\nVector NO ordenado estrictamente decrecite\n";

else_main:

    li $v0,4
    la $a0,msg_no_ord
    syscall

#     std::cout << "\nVector con dimension " << n2 << std::endl;

    li $v0,4
    la $a0,cabvec
    syscall

#     printvec(v2,n2," ");
#     std::cout << std::endl;

    li $v0,4
    la $a0,newline
    syscall

#     o = ordenado(v2,n2);
#     if (o == 1) std::cout << "\nVector ordenado estrictamente decrecite\n";
if2_main:



    li $v0,4
    la $a0,msg_ord
    syscall

#     else std::cout << "\nVector NO ordenado estrictamente decrecite\n";
else2_main:



    li $v0,4
    la $a0,msg_no_ord
    syscall

#     std::cout << "\nFIN DEL PROGRAMA\n";

    li $v0,4
    la $a0,msg_fin
    syscall

#     return(0);
# }
