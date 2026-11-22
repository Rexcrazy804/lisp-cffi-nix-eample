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

typedef struct {
  unsigned long length;
  atom *atoms;
} AtomCollection;


// Note
// this callback should create and return an atom
// using the given operator
// operands are up to the callbacks discretion
typedef atom (*MakeAtomCallback)(operator op);

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

// Updates the operator of the atom
void atom_set_operator(atom*, operator);

// Returns a AtomCollection initialized with sample values
AtomCollection example_pointerarray();

// Returns the result of the object created by the callback
int compute_callback(MakeAtomCallback callback);

#endif
