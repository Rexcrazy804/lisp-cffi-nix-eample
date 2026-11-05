#ifndef __LIB_H__
#define __LIB_H__

/// TYPES

typedef enum {
  OP_ADD = 1,
  OP_SUBTRACT = 2,
  OP_MULTIPLY = 3,
  OP_DIVIDE = 4,
} operator;

typedef struct {
  int num1;
  int num2;
  operator op;
} atom;

/// FUNCTIONS

// Adds two numbers
int add_two_numbers(int, int);

// Performs an operation on the given numbers
int operate_numbers(int, int, operator);

// Processes an atom
int operate_atom(atom);

// Processes a reference to an atom
int operate_atom_ref(atom*);

// Creates an atom
atom new_atom(int, int, operator);

#endif
