import Mathlib.Tactic

/-!
# Exercises — Level 3: Mathematics

Now you're doing real mathematical proofs. These exercises range from
computational facts to algebraic identities to an introduction to
mathematical induction. When you're stuck:
  1. Use `exact?` to search Mathlib for a single-lemma solution
  2. Use `ring` for polynomial identities
  3. Use `linarith` or `nlinarith` for linear/nonlinear inequalities
  4. Use `omega` for natural number arithmetic
  5. Use `norm_num` for concrete numerical goals

## Difficulty: ⭐⭐⭐ (requires reading Mathematics/ files and some creativity)

Use `exact?`, `apply?`, or `rw?` to find useful lemmas.
-/

-- ============================================================
-- NATURAL NUMBER ARITHMETIC
-- ============================================================

-- Basic
example (n : Nat) : n + 0 = n := by sorry
example (n m : Nat) : n + m = m + n := by sorry
example (a b c : Nat) : a * (b + c) = a * b + a * c := by sorry

-- A bit harder
example (n : Nat) : n * 0 = 0 := by sorry
example (n : Nat) (h : n > 0) : n ≥ 1 := by sorry

-- ============================================================
-- DIVISIBILITY
-- ============================================================

example : 5 ∣ 25 := by sorry
example : 7 ∣ 49 := by sorry

-- If a | b and a | c, then a | (b + c)
example (a b c : Nat) (h1 : a ∣ b) (h2 : a ∣ c) : a ∣ (b + c) := by sorry

-- ============================================================
-- RING ARITHMETIC
-- ============================================================

-- The `ring` tactic should handle all of these
example (a b : ℤ) : (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 := by sorry
example (a : ℤ) : (a + 1) * (a - 1) = a ^ 2 - 1 := by sorry
example (x y : ℚ) : (x + y) ^ 3 = x^3 + 3*x^2*y + 3*x*y^2 + y^3 := by sorry

-- ============================================================
-- INEQUALITIES
-- ============================================================

example (a : ℤ) : a ^ 2 ≥ 0 := by sorry
example (a b : ℤ) (ha : a > 0) (hb : b > 0) : a * b > 0 := by sorry
example (x : ℝ) (h : x > 0) : x + x > x := by sorry

-- AM-GM for two numbers (special case)
-- hint: expand (a - b)^2 ≥ 0
-- This is hard! Use `nlinarith` or `positivity` + algebraic manipulation
example (a b : ℝ) (ha : a ≥ 0) (hb : b ≥ 0) : a * b ≤ (a + b)^2 / 4 := by
  sorry

-- ============================================================
-- INDUCTION
-- ============================================================

-- Sum of first n natural numbers
-- hint: induction n, then omega or ring in each case
theorem gauss_sum (n : Nat) : 2 * (Finset.range (n + 1)).sum id = n * (n + 1) := by
  sorry

-- ============================================================
-- 🏆 BOSS LEVEL: Irrationality of √2
-- ============================================================

-- Don't attempt this until you've completed everything above!
-- This is genuinely hard in Lean. It's here to show you where
-- things are headed — not to frustrate you.

/-
This is a famous proof. In Lean, it would involve:
1. Assuming √2 = p/q with gcd(p,q) = 1
2. Showing 2q² = p², so p is even
3. Writing p = 2k, then 2q² = 4k², so q² = 2k²
4. So q is also even, contradicting gcd(p,q) = 1

Mathlib already has this: `irrational_sqrt_two`
But try to understand the structure!
-/

-- For now, just invoke Mathlib's version:
-- example : Irrational (Real.sqrt 2) := irrational_sqrt_two
