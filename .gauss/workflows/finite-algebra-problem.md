# Finite Algebra Witness Problem

Target Lean file: `LeanLab/Exercises/OpenGaussFiniteAlgebra.lean`

Target theorem:

`exists_finite_ring_with_unit_witnesses`

Interpret the problem in an associative unital ring, not assumed commutative.

Find a finite ring `R` and units `a b : R` such that

* `b * a + b ^ 2 * a * b = 1`
* `a + b ^ 2 * a ^ 2 + b ^ 3 = 0`
* `a ^ 3 + a ^ 2 * b + a * b + b ≠ 1`

Suggested Gauss entrypoints:

* `/project status`
* `/formalize LeanLab/Exercises/OpenGaussFiniteAlgebra.lean`
* `/prove LeanLab/Exercises/OpenGaussFiniteAlgebra.lean`