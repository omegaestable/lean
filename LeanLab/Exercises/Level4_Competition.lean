/-!
# Exercises — Level 4: Competition Mathematics

These problems bridge the gap between "learning Lean" and "doing
research with Lean." They're modeled on problems from AMC, AIME,
and IMO — the same competitions that AI systems like Aristotle
and AlphaProof are tested on.

## Difficulty: ⭐⭐⭐⭐ (AMC/AIME-style problems formalized in Lean)

## Strategy guide
  - **AMC-style**: Often solvable by `native_decide`, `norm_num`, or `omega`
  - **AIME-style**: Need algebraic manipulation (`nlinarith`, `ring`) or case analysis
  - **IMO-style**: Need clever algebraic tricks (introduce auxiliary expressions)
  - **Autoformalization**: The hardest skill — translating English to Lean

These exercises mimic the types of problems found in the miniF2F benchmark.
They test both your formalization skills AND your proof skills.
Completing these builds your portfolio for AI/Lean research.
-/

import Mathlib.Tactic
import Mathlib.Data.Nat.Basic
import Mathlib.Data.Int.Basic
import Mathlib.Data.Rat.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Finset.Basic

-- ============================================================
-- AMC-STYLE (easier)
-- ============================================================

-- AMC 1: What is the remainder when 3^100 is divided by 4?
-- (Hint: 3 ≡ -1 (mod 4), so 3^100 ≡ (-1)^100 = 1 (mod 4))
theorem amc_mod_problem : 3 ^ 100 % 4 = 1 := by
  sorry  -- hint: native_decide works for concrete computations

-- AMC 2: If 2^x = 16, then x = 4
theorem amc_exp_problem (x : ℕ) (h : 2 ^ x = 16) : x = 4 := by
  sorry  -- hint: interval_cases x (after bounding x)

-- AMC 3: The sum 1 + 2 + ... + 100 = 5050
theorem amc_gauss : (Finset.range 101).sum id = 5050 := by
  sorry  -- hint: native_decide or simp + norm_num

-- ============================================================
-- AIME-STYLE (medium)
-- ============================================================

-- AIME 1: If a + b = 10 and ab = 21, find a² + b²
-- (a² + b² = (a+b)² - 2ab = 100 - 42 = 58)
theorem aime_sum_sq (a b : ℤ) (h1 : a + b = 10) (h2 : a * b = 21) :
    a ^ 2 + b ^ 2 = 58 := by
  sorry  -- hint: nlinarith or calc with ring

-- AIME 2: Prove that n(n+1) is always even
theorem aime_consec_even (n : ℤ) : ∃ k, n * (n + 1) = 2 * k := by
  sorry  -- hint: case split on whether n is even or odd

-- AIME 3: If p is prime and p > 2, then p is odd
theorem aime_prime_odd (p : ℕ) (hp : Nat.Prime p) (hp2 : p > 2) :
    ¬(2 ∣ p) := by
  sorry  -- hint: if 2 | p and p is prime, then p = 2

-- ============================================================
-- IMO-STYLE (hard)
-- ============================================================

-- IMO 1: Prove that for all positive reals a, b: (a+b)/2 ≥ √(ab)
-- (AM-GM inequality — this is in Mathlib but try it yourself!)
-- This is hard to state cleanly because √ requires non-negativity.

-- Simplified version: a² + b² ≥ 2ab for all reals
theorem imo_am_gm_sq (a b : ℝ) : a ^ 2 + b ^ 2 ≥ 2 * a * b := by
  sorry  -- hint: nlinarith [sq_nonneg (a - b)]

-- IMO 2: Prove Cauchy-Schwarz for two elements:
-- (a₁² + a₂²)(b₁² + b₂²) ≥ (a₁b₁ + a₂b₂)²
theorem imo_cauchy_schwarz (a₁ a₂ b₁ b₂ : ℝ) :
    (a₁^2 + a₂^2) * (b₁^2 + b₂^2) ≥ (a₁*b₁ + a₂*b₂)^2 := by
  sorry  -- hint: nlinarith [sq_nonneg (a₁*b₂ - a₂*b₁)]

-- IMO 3: If n ≥ 2, then n! > n (for n ≥ 3)
theorem imo_factorial_bound (n : ℕ) (h : n ≥ 3) : n.factorial > n := by
  sorry  -- hint: induction, or use Nat.factorial bounds from Mathlib

-- ============================================================
-- AUTOFORMALIZATION EXERCISES
-- ============================================================

-- 🎯 This is the skill that AI researchers care about most.
-- These are INFORMAL statements — no Lean code given!
-- Your job:
-- 1. Formalize them as Lean theorem statements (the HARD part)
-- 2. Prove them (or use sorry if the proof is too hard)
-- Even getting the statement right is valuable practice.

-- A. "The sum of the first n odd numbers equals n²"
-- Hint: the kth odd number is 2k + 1 (0-indexed) or 2k - 1 (1-indexed)
-- theorem sum_odd_squares (n : ℕ) : ... := by sorry

-- B. "There are infinitely many primes of the form 4k + 3"
-- (This is a famous result — it's in Mathlib, can you find it?)

-- C. "A number is divisible by 3 iff the sum of its digits is divisible by 3"
-- (This is very hard to formalize! Think about what "digits" means in Lean.)

-- D. "In any group, the order of an element divides the order of the group"
-- (Lagrange's theorem — also in Mathlib)
-- #check Subgroup.card_subgroup_dvd_card
