import Mathlib

/-!
# OpenGauss Target: Finite Algebra Witness

We interpret the problem in an associative unital ring, not assumed commutative.
The mixed products use the default left-associative parsing, so

* `b ^ 2 * a * b` means `(b ^ 2) * a * b`
* `b ^ 2 * a ^ 2` means `(b ^ 2) * (a ^ 2)`

Progress notes (external exhaustive checks):

* No witnesses in `ZMod n` for `n ∈ {2,3,5,7,8,9,11}`.
* No witnesses in `ZMod 2 × ZMod 2`, `ZMod 3 × ZMod 3`.
* No witnesses in `Matrix (Fin 2) (Fin 2) (ZMod p)` for `p ∈ {2,3,5,7,11,13}`
  under exhaustive unit-pair search for the two equations and final inequality.
* No witnesses in upper triangular rings `UT2(F_p)` for `p ∈ {2,3,5,7,11,13,17}`.

This file remains the formal target for a full Lean proof.
-/

section HelperLemmas

variable {R : Type} [Ring R]
variable {a b x : R}

lemma eq_zero_of_mul_right_eq_zero (ha : IsUnit a) (h : x * a = 0) : x = 0 := by
  rcases ha with ⟨u, rfl⟩
  have h' := congrArg (fun t => t * ((↑u⁻¹ : R))) h
  simpa [mul_assoc] using h'

lemma eq_zero_of_mul_left_eq_zero (ha : IsUnit a) (h : a * x = 0) : x = 0 := by
  rcases ha with ⟨u, rfl⟩
  have h' := congrArg (fun t => ((↑u⁻¹ : R)) * t) h
  simpa [mul_assoc] using h'

lemma h1_factored
    (h1 : b * a + b ^ 2 * a * b = (1 : R)) :
    b * (a + b * a * b) = 1 := by
  simpa [pow_two, mul_add, mul_assoc] using h1

lemma solve_for_a_from_h2
    (h2 : a + b ^ 2 * a ^ 2 + b ^ 3 = (0 : R)) :
    a = -(b ^ 2 * a ^ 2 + b ^ 3) := by
  have h' := congrArg (fun t => t - (b ^ 2 * a ^ 2 + b ^ 3)) h2
  simpa [sub_eq_add_neg, add_assoc, add_left_comm, add_comm] using h'

end HelperLemmas

theorem exists_finite_ring_with_unit_witnesses :
    ∃ (R : Type) (_ : Ring R) (_ : Fintype R) (a b : R),
      IsUnit a ∧
      IsUnit b ∧
      b * a + b ^ 2 * a * b = (1 : R) ∧
      a + b ^ 2 * a ^ 2 + b ^ 3 = (0 : R) ∧
      a ^ 3 + a ^ 2 * b + a * b + b ≠ (1 : R) := by
  sorry
