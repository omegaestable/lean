import Mathlib

/-!
# OpenGauss Target: Finite Algebra Witness

We interpret the problem in an associative unital ring, not assumed commutative.
The mixed products use the default left-associative parsing, so

* `b ^ 2 * a * b` means `(b ^ 2) * a * b`
* `b ^ 2 * a ^ 2` means `(b ^ 2) * (a ^ 2)`

The proof is left open as a Gauss target.
-/

theorem exists_finite_ring_with_unit_witnesses :
    ∃ (R : Type) (_ : Ring R) (_ : Fintype R) (a b : R),
      IsUnit a ∧
      IsUnit b ∧
      b * a + b ^ 2 * a * b = (1 : R) ∧
      a + b ^ 2 * a ^ 2 + b ^ 3 = (0 : R) ∧
      a ^ 3 + a ^ 2 * b + a * b + b ≠ (1 : R) := by
  sorry
