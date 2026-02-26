import Mathlib.Tactic

/-!
# 07 — Natural Numbers: Building Math from Scratch

## Why start here?
The natural numbers are where all of mathematics begins in Lean.
Nat is defined inductively: you have `zero` and `succ`.
Everything else (addition, multiplication, ordering) is built on top.

This file shows you how to prove things about ℕ that you "know" are true,
but now you'll understand WHY they're true at a foundational level.
-/

-- ============================================================
-- SECTION 1: Induction — the fundamental proof technique for ℕ
-- ============================================================

-- The induction principle for Nat:
-- To prove P(n) for all n, prove:
--   1. P(0)          (base case)
--   2. P(n) → P(n+1) (inductive step)

-- Let's prove 0 + n = n (this is NOT trivial — addition is defined by
-- recursion on the FIRST argument, so `0 + n` doesn't simplify directly
-- in the same way `n + 0` does)

theorem zero_add_demo (n : Nat) : 0 + n = n := by
  induction n with
  | zero => rfl                      -- 0 + 0 = 0 ✓
  | succ k ih =>                     -- assume 0 + k = k, prove 0 + (k+1) = k+1
    rw [Nat.add_succ]                -- unfold definition
    exact congrArg Nat.succ ih

-- Addition is associative
theorem add_assoc' (a b c : Nat) : (a + b) + c = a + (b + c) := by
  induction c with
  | zero => simp
  | succ k ih => omega

-- ============================================================
-- SECTION 2: Divisibility
-- ============================================================

-- a ∣ b means "a divides b", i.e., ∃ k, b = a * k

example : 3 ∣ 12 := by
  use 4                -- witness: 12 = 3 * 4

example : ¬(3 ∣ 7) := by
  intro ⟨k, hk⟩
  omega

-- Every number divides 0
theorem dvd_zero' (n : Nat) : n ∣ 0 := by
  use 0
  ring

-- 1 divides everything
theorem one_dvd' (n : Nat) : 1 ∣ n := by
  use n
  ring

-- Divisibility is transitive
theorem dvd_trans' (a b c : Nat) (h1 : a ∣ b) (h2 : b ∣ c) : a ∣ c := by
  obtain ⟨k, hk⟩ := h1
  obtain ⟨l, hl⟩ := h2
  use k * l
  rw [hl, hk]
  ring_nf

-- ============================================================
-- SECTION 3: Modular arithmetic
-- ============================================================

-- Lean has built-in mod (%)
example : 17 % 5 = 2 := by decide
example : 100 % 7 = 2 := by decide

-- A number is even iff it's divisible by 2
def isEven (n : Nat) : Prop := 2 ∣ n

theorem zero_is_even : isEven 0 := by
  unfold isEven
  use 0

theorem even_plus_two (n : Nat) (h : isEven n) : isEven (n + 2) := by
  unfold isEven at *
  obtain ⟨k, hk⟩ := h
  use k + 1
  omega

-- ============================================================
-- SECTION 4: Strong induction and well-founded recursion
-- ============================================================

-- Sometimes you need to assume the result for ALL smaller values,
-- not just the predecessor. This is strong induction.

-- Lean supports this through well-founded recursion.
-- Here's a classic: every number ≥ 2 has a prime factor.
-- (We won't prove this here but set up the framework.)

-- For now, let's see a simpler strong induction example:
-- Every natural number is either 0, 1, or ≥ 2

theorem nat_cases (n : Nat) : n = 0 ∨ n = 1 ∨ n ≥ 2 := by
  omega

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Prove by induction: n + 0 = n (this one is actually `rfl` because
--    addition is defined by recursion on the second argument in Lean 4,
--    but try doing it by induction anyway for practice!)
theorem my_add_zero (n : Nat) : n + 0 = n := by
  sorry

-- 2. Prove: if n is even, then n + n is even
theorem even_double (n : Nat) (h : isEven n) : isEven (n + n) := by
  sorry

-- 3. Prove: 6 divides 42
example : 6 ∣ 42 := by
  sorry
