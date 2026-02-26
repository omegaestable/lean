/-!
# Exercises — Level 1: Basics

Welcome to your first exercise set! The goal is simple: replace
every `sorry` with something that makes Lean happy (green squiggles
gone, no red errors). `sorry` is Lean's way of saying "I'll trust
you for now" — but you need to replace it with real proofs.

## How to work through these
  1. Open this file in VS Code with the Lean 4 extension
  2. Place your cursor after a `by sorry` line
  3. Delete `sorry` and start typing tactics
  4. Watch the Infoview panel — it shows what Lean expects

## Difficulty: ⭐ (should be doable after reading Basics/ files)

## Tactics you'll need
  - `rfl` — proves goals of the form `a = a`
  - `decide` — proves decidable propositions by computation
  - `norm_num` — proves numerical facts
  - `simp` — simplifies using known lemmas
  - `omega` — solves linear arithmetic over ℕ and ℤ

Hints are provided. Try without them first!
-/

-- ============================================================
-- WARM-UP: Computation
-- ============================================================

-- Just use `rfl`, `decide`, or `norm_num`
example : 5 + 7 = 12 := by sorry
example : 3 * 8 = 24 := by sorry
example : 2 ^ 5 = 32 := by sorry
example : 100 - 30 = 70 := by sorry
example : "hello" ++ " " ++ "world" = "hello world" := by sorry

-- ============================================================
-- FUNCTIONS
-- ============================================================

-- Now write some actual Lean functions. Replace `sorry` with
-- a working implementation. Remember:
--   - `fun n => ...` for anonymous functions
--   - `match n with | ...` for pattern matching
--   - Nat has two constructors: `0` and `n + 1` (i.e., `Nat.succ n`)

-- Returns true if n is zero
def isZero' : Nat → Bool := sorry

-- Returns the maximum of two natural numbers
def myMax (a b : Nat) : Nat := sorry

-- Computes n! (factorial)
def myFactorial : Nat → Nat := sorry

-- Test your implementations:
-- #eval isZero' 0      -- should be true
-- #eval isZero' 5      -- should be false
-- #eval myMax 3 7      -- should be 7
-- #eval myFactorial 5  -- should be 120

-- ============================================================
-- LISTS
-- ============================================================

-- Count the number of elements equal to `target`
def count (target : Nat) : List Nat → Nat := sorry

-- Return the last element of a list, or 0 if empty
def lastOrZero : List Nat → Nat := sorry

-- ============================================================
-- INDUCTIVE TYPES
-- ============================================================

-- Define a type for playing cards suits
-- inductive Suit where ...

-- Write a function that returns true if a suit is red (hearts or diamonds)
-- def isRed : Suit → Bool := ...

-- ============================================================
-- SIMPLE PROOFS
-- ============================================================

-- Now combine your Lean knowledge with proof tactics.
-- Start with `rfl` (reflexivity). If that doesn't work, try
-- `decide`, `simp`, or `omega`. Read the Infoview for clues!

-- Hint: rfl
example : (fun x : Nat => x + 1) 5 = 6 := by sorry

-- Hint: rfl or decide
example : [1, 2, 3].length = 3 := by sorry

-- Hint: intro + rfl or rfl
theorem apply_id (n : Nat) : (fun x => x) n = n := by sorry

-- Hint: intro, simp, or omega
theorem succ_pos (n : Nat) : n + 1 > 0 := by sorry
