#include <stdio.h>
#include <stdlib.h>

 
double f(double x) {
    double fx = 1.0;
    int n = 100;
    double pow = x;
    double fact = 1.0;
    for (int i = 1; i < n ; ++i) {
        if (i  % 2 != 0) {
            fx -= (pow/fact);
            
        } else {
            fx += (pow/fact);
        }
        pow *= x;
        fact *= i+1;
    }
    return fx;
}


int main(int argc, char *argv[]){
  if(argc != 3){
      printf("Incrorrect input, check README.md\n");
      return 0;
    }
    FILE *input = fopen(argv[1], "r");
    FILE *out = fopen(argv[2], "w");
    if((input == NULL) || (out == NULL)){
      printf("Can't find this file\n");
      return 0;
    }
  double x;
  fscanf(input,"%lf", &x);
  if(x > 21){
      printf("result is too small to print\n");
      return 0;
  }
  double fx = f(x);
  fprintf(out, "%.9lf", fx);
  fclose(input);
  fclose(out);
  return 0;
}
