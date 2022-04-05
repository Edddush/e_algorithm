#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void ecalculation(int num_digits, int * e){
    int m = 4;
    int temp = 0; 
    int carry = 0;
    float test_value = (num_digits + 1) * 2.30258509;
    
   
    while ((m * (log(m) - 1.0) + 0.5 * log(6.2831852 * m)) < test_value){
        m += 1;
    }

    int coeff[m+1];
    for(int i = 0; i <= m; i++){
        coeff[i] = 0;
    }

    for(int i = 2; i <= m; i++){
        coeff[i] = 1;
    }
 
    for (int i = 0; i < num_digits; i++){
        e[i] = 0;
    }
    e[0] = 2;

    for (int i = 1; i < num_digits; i++){
        carry = 0;
        for(int j = m; j >= 2; j--){
            temp = coeff[j] * 10 + carry;
            carry = (int) temp/j;
            coeff[j] = temp - carry * j;
        }
        e[i] = carry;
    }

    for (int i = 0; i < num_digits; i++){
        printf("%d", e[i]);
    }
    printf("\n");
}


int main(){
    int num_digits = 801;
    int * e = malloc(sizeof(int) * num_digits);

    ecalculation(num_digits, e);
    free(e);
    return 0;
}