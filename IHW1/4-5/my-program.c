// gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none c-array-sum.c

#include <stdio.h>

#define max_size 10000

int fillOutputArray(int input[], int output[], int length) {
  int result = 0;
  for(int i = 0; i < length; ++i) {
    // Проверка, что следующий элемент не убывает.
    if(i < length-1 && input[i] <= input[i+1]) {
      output[result] = input[i];
      // Счетчик элементов нового массива.
      ++result; 
    // Проверка, что предыдщуий элемент не возрастает (для конца подпослед.)
    } else if(i > 0 && input[i-1] <= input[i]) {
      output[result] = input[i];
      ++result;
    }
  }
  return result;
}

void printArray(int output[], int counter) {
  for(int i = 0; i < counter; ++i) {
    printf("array[%d] = %d\n", i, output[i]);
  }
}

int main() {
int input_array[max_size];
int output_array[max_size];
int length;
  printf("Input length (0 < length <= %d): ", max_size);
  scanf("%d", &length);

  if(length < 1 || length > max_size) {
    printf("Incorrect length = %d\n", length);
    return 1;
  }

  for(int i = 0; i < length; ++i) {
    printf("array[%d]? ", i);
    scanf("%d", input_array + i);
  }

  length = fillOutputArray(input_array, output_array, length);
  printArray(output_array, length);
  return 0;
}
