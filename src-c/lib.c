#include "lib.h"

int add_two_numbers(int one, int two) { return one + two; }

int operate_numbers(int num1, int num2, operator opt) {
  switch (opt) {
  case OP_ADD:
    return num1 + num2;
  case OP_SUBTRACT:
    return num1 - num2;
  case OP_MULTIPLY:
    return num1 * num2;
  case OP_DIVIDE:
    return num1 / num2;
  }
}
