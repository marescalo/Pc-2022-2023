#include <iostream>
const int n1 = 10;
double v1[n1] = {10.5, 9.5, 7.25, 6.25, 5.75, 4.5, 4.25, 3.5, -1.5, -2.0};
const int n2 = 5;
double v2[n2] = {5.5, 4.5, 4.25, 2.5, 2.5 };
void printvec(double v[], const int n, std::string separador) {
 for (int i = 0; i < n; i++)
 std::cout << v[i] << separador;
}
int check(double a,double b) {
 if (a < b ) return(-1);
 else if (a == b) return(0);
 else return(1);
}
int ordenado(double v[], const int n) {
 int resultado = 1;
 for (int i = 0; i < n-1; i++)
 if ( check(v[i],v[i+1]) != 1 ) {
 resultado = 0;
 break;
 }
 return(resultado);
}
int main(void) {
 std::cout << "\nVector con dimension " << n1 << std::endl;
 printvec(v1,n1," ");
 std::cout << std::endl;
 int o = ordenado(v1,n1);
 if (o == 1) std::cout << "\nVector ordenado estrictamente decrecite\n";
 else std::cout << "\nVector NO ordenado estrictamente decrecite\n";
 std::cout << "\nVector con dimension " << n2 << std::endl;
 printvec(v2,n2," ");
 std::cout << std::endl;
 o = ordenado(v2,n2);
 if (o == 1) std::cout << "\nVector ordenado estrictamente decrecite\n";
 else std::cout << "\nVector NO ordenado estrictamente decrecite\n";
 std::cout << "\nFIN DEL PROGRAMA\n";
 return(0);
}