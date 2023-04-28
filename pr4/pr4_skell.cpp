/* # Autor: 
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
error_dim:  .asciiz "\nError: Dimension incorrecta. \n"
error_ind:  .asciiz "\nError: Indice incorrecto.\n"
error_d_dim:    .asciiz "\nError: Los vectores tienen distinta dimension.\n"
msg_prodesc:    .asciiz "\nEl producto escalar de los vectores es: "
msg_fin:    .asciiz "\nFIN DEL PROGRAMA."


    .text */

#include <iostream>
#include <vector>
#include <iomanip>

void print_vect(float* v,int size, std::string espacio = " "){
    for(int i = 0; i < size; i++){
        std::cout << v[i] << espacio;
    }
}

void change_elto(float* v, int position, float val){
    v[position] = val;
}

void swap(float* v, int pos1, int pos2){
    float aux = v[pos1];
    v[pos1] = v[pos2];
    v[pos2] = aux; 
}

void mirror(float* v, int size){
    if(size == 0 || size == 1){
        return;
    }
    swap(v,0,size-1);
    mirror(v+1,size-2);
}

float mult_add(float pos1, float pos2, float result){
    return pos1*pos2+result;
}

float prod_esc(float* v1, float* v2, int size){
    if (size == 0){
        return 0;
    }
    float result = 0;
    for(int i = 0; i < size; i++){
        result = mult_add(v1[i],v2[i],result);
    }
    return result;
}


int main(void){

    float v1[40], v2[40];
    int n1{0}, n2{0};
    for(int i{0}; i < 40; i++){
        v1[i] = i + 10;
        v2[i] = 40 -i;
        n1++;
        n2++;
    }

    std::cout << "Practica 4 de Principios de Computadores. Subrutinas." << std::endl;

    int option{1};
    while(option != 0){
    std::cout << "Vector con dimension  " << std::setprecision(8)<< n1 << std::endl; 
    print_vect(v1,n1);

    std::cout << std::endl;

    std::cout << "Vector con dimension  "  << n2 << std::endl; 
    print_vect(v2,n2);

    std::cout << std::endl;
    
    std::cout << "(1) Cambiar dimension de un vector" << std::endl;
	std::cout << "(2) Cambiar un elemento de un vector" << std::endl;
	std::cout << "(3) Invertir un vector" << std::endl;
	std::cout << "(4) Calcular el producto escalar de dos vectores" << std::endl;
	std::cout << "(0) Salir" << std::endl << std::endl;
    
	std::cout << "Introducir opción : ";
	std::cin >> option;


    switch(option){
        case 1:{

            int elegir_vector{0};
            int dimension{0};
            std::cout << "Elija vector para realizar la operacion (1) para v1 (2) para v2: " << std::endl;
            std::cin >> elegir_vector;
            std::cout << "Introduzca nueva dimension para el vector (1-40):" << std::endl;
            std::cin >> dimension;
            if((dimension <= 0)||(dimension > 40)){
                std::cout << "Error: Dimension incorrecta. " <<std::endl;
                break;
            }

            if(elegir_vector == 1){
                n1 = dimension;
            }
            else if(elegir_vector == 2){
                n2 = dimension;
            }
            else{
                std::cout << "Error: opcion incorrecta." << std::endl;
            }
        }
            break;
        case 2:{

            int elegir_vector{0};
            int position{0};
            float val{0};
            std::cout << "Elija vector para realizar la operacion (1) para v1 (2) para v2: " << std::endl;
            std::cin >> elegir_vector;
            if((elegir_vector != 1)&&(elegir_vector != 2)){
                std::cout << "Error: opcion incorrecta." << std::endl;
                break;
            }

            std::cout << "Elija el indice del elemento a cambiar: " << std::endl;
            std::cin >> position;
            if ((elegir_vector == 1 && (position <= 0 || position > n1))||(elegir_vector == 2 && (position <= 0 || position > n2))){
                std::cout << "Error: Indice incorrecto." << std::endl;
                break;
            }

            std::cout << "Introduce nuevo valor para el elemento elegido:" << std::endl;
            std::cin >> val;

            if(elegir_vector == 1){
                change_elto(v1,position-1, val);
            }
            else if(elegir_vector == 2){
                change_elto(v2,position-1, val);
            }
        }
            break;
        case 3:{
            int elegir_vector{0};
            std::cout << "Elija vector para realizar la operacion (1) para v1 (2) para v2: " << std::endl;
            std::cin >> elegir_vector;
            if((elegir_vector != 1)&&(elegir_vector != 2)){
                std::cout << "Error: opcion incorrecta." << std::endl;
                break;
            }

            if(elegir_vector == 1){
                mirror(v1,n1);
            }
            else if(elegir_vector == 2){
                mirror(v2,n2);
            }
        }
            break;
        case 4:{
            if(n1 != n2){
                std::cout << "Error: Los vectores tienen distinta dimension." << std::endl;
                break;
            }
            std::cout << "El producto escalar de los vectores es: " << prod_esc(v1,v2,n1) << std::endl;
        }
            break;
        case 0:
            break;
        default:{
            std::cout << "Error: opcion incorrecta." << std::endl;
        }
            break;
    }

    std::cout << "FIN DEL PROGRAMA." << std::endl;
    }
}