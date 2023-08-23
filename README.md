# Programming Languages: Application and Interpretation

Some notes of the book.

## Evaluation

1. arithmetic calculator
1. interpret conditional
1. boolean space design
1. scope + local binding
1. function environment model + mutation

## Parsing

racket special syntax starting with `\`` for writing s-expressions conveniently, which saves us from writing a parser.

```racket
; (s-exp-list (s-exp-symbol +) (s-exp-number 1) (s-exp-number 2))
`(+ 1 2)
```

## Syntax Sugar

Transforms surface language with syntax sugar to core language.

A hygiene macro system key points.

1. hygiene macro supports **static scoping** to allow same identifier used in multiple definitions.
1. an important idiom of treating truthy/falsy value, design `false` to be the only falsy value, all others are truthy, it's good in a way that `false` can be the sentinel value of representing invalid case.
1. macro must apply expression with **side effects** only once for expected behavior.
1. multiple argument macro, `a ...` represents zero ore more leading pattern.

## Object Orientation

Target features of simulating object orientation with functions.

1. object pattern
1. class pattern (constructor)
1. self reference
   1. self reference with mutation
   1. self reference without mutation (fixed point).
   1. [open recursion](https://journal.stuffwithstuff.com/2013/08/26/what-is-open-recursion/), self should refer to the most refined object, so that dynamic dispatch works. see object/open-recursion.rkt, code different from the book.
1. inheritance
   1. single inheritance
   1. multiple inheritance [diamond problem](https://en.wikipedia.org/wiki/Multiple_inheritance)
1. static members
1. private members
1. dynamic dispatch

Problems of class based object-orientation and advantages of function over object-orientation.

1. [Fragile base class problem](https://en.wikipedia.org/wiki/Fragile_base_class)
1. [Synthesizing Object-Oriented and Functional Design to Promote Re-Use](https://cs.brown.edu/~sk/Publications/Papers/Published/kff-synth-fp-oo/)
1. https://www-old.cs.utah.edu/plt/publications/icfp98-ff/paper.shtml
1. [Object-Oriented Programming Languages: Application and Interpretation](https://users.dcc.uchile.cl/~etanter/ooplai/)

### Prototype

[Self language](https://selflanguage.org/)

prototype based object orientation without class.

### Mixins and Traits

Class extension syntax defines a static relationship, [mixins and traits](https://cs.brown.edu/~sk/Publications/Papers/Published/fkf-classes-mixins/) provides a flexible way of class composition, which allows us to define only need classes or compositions of classes in a **combinatorial** situation.

## Types

In a typing rule, antecedent above horizontal bar infers consequent under.

1. [Inferring Type Rules for Syntactic Sugar](https://cs.brown.edu/~sk/Publications/Papers/Published/pk-resuarging-types/)
1. typing conditionals
1. typing functions
1. recursive type
1. safety and soundness
1. type inference Hindley-Milner
   1. PLAI V1 Chatpter 30
   1. PLAI V2 15.3.2
1. algebraic data types
   1. tagged union / sum of products
   1. pattern matching, a logarithm of the number of variants is needed at runtime to distinguish between variants of a data type.
   1. untagged union +
      1. if-splitting / [occurrence-type](https://docs.racket-lang.org/ts-guide/occurrence-typing.html) / flow typing [flow analysis](https://cs.brown.edu/people/sk/Publications/Papers/Published/gsk-flow-typing-theory/)
      1. union types can help to represent [partial functions](https://docs.racket-lang.org/ts-guide/occurrence-typing.html)
1. algebraic vs class type
   1. [Expression Problem](https://en.wikipedia.org/wiki/Expression_problem)
   1. [Synthesizing Object-Oriented and Functional Design to Promote Re-Use](https://cs.brown.edu/~sk/Publications/Papers/Published/kff-synth-fp-oo/)
   1. [Toward a Formal Theory of Extensible Software](https://cs.brown.edu/~sk/Publications/Papers/Published/kf-ext-sw-def/)
1. nominal vs structural typing
   1. [A theory of Objects](https://cs.brown.edu/~sk/Publications/Papers/Published/kf-ext-sw-def/)
   1. [Semantics and Types for Objects with First-Class Member Names](https://cs.brown.edu/~sk/Publications/Papers/Published/pgk-sem-type-fc-member-name/)
1. [gradual typing](https://en.wikipedia.org/wiki/Gradual_typing)
1. [Contracts](https://docs.racket-lang.org/guide/contracts.html)

### Classic case

1. [partial domains](https://dcic-world.org/2022-08-28/partial-domains.html)
