#ifndef __LIB_H__
#define __LIB_H__

/// TYPES

typedef enum {
  OP_ADD = 1,
  OP_SUBTRACT = 2,
  OP_MULTIPLY = 3,
  OP_DIVIDE = 4,
} operator;

/// FUNCTIONS

// Adds two numbers
int add_two_numbers(int, int);

// Performs an operation on the given numbers
int operate_numbers(int, int, operator);

#endif
