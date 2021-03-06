
Core Syntax
===========

## End-of-line Parsing

The end-of-line token (`\n`) is associated to two parsing rules:

- on the one hand, it denotes the termination of the last expression on the line,
- and on the other it may give continuation to the last expression, if the next
  expression has greater indentation than the current one.

Let's see two examples that show the described rules applied.

    print "Hello, World!"
    print "Bye."

This may be read as: `[<expr>, <EOL>, <expr>, <EOL>, <EOF>]`. Consider the first three elements; here the end-of-line token completely terminates the previous expression and the parser starts a fresh new one afterwards. But if the next line had an indented expression it would be treated as an argument to the first one, like in the following example:

    print "Hello, "
        "World!"

Which is translated as a sequence of `[<expr>, <EOL>, <TAB>, <expr>]`.

    input  = [`EOL, `EOF]
    output =


## Rules

- On the top-level the indentation must start at the begining of the line.

## Blocks

    expr = atom | infix | prefix | block
    infix = expr <op> expr
    prefix =
    block = `{ expr* `}

    print "Hello, "
        (capitalize "World")
        "!"
    print (2 + 2)
    2 + 2 *
        3

    print "Hello, "
        (capitalize "World!")
        "!";
    print (2 + 2);
    2 + 2 *
        3

    print "Hello, " (capitalize "World!") "!";
    print (2 + 2);
    2 + 2 * 3

    (seq : (print : "Hello, " (capitalize : "World!") "!")
         (seq : (print : (+ : 2 2))
              (+ : 2 (* : 2 3))))

    ----

    a =
        3;
        2;
        2 + 1

    a = 5
        3

    a = 5;
        3

    -> a = 5; 3
     | (a = 5); 3       ✗
     |  a = (5; 3)      ✓
     ?


### Notes:

- Criterion: current indentation level.

- The sequence is created each time two sequences are found where the indent relation is:
    - indent(e1) = indent(e2)
    - indent(e1) > indent(e2)
- But not when the relation is:
    - indent(e1) < indent(e2)

- For infix parser the next expression must be indented or be in the same line.
- All tokens on the same line have the same indentation level.
- All tokens on the same line have the indentation level equal to the


## Case Studies


(get_function `sum cache: Yes) 3 2
{ hey; f }
