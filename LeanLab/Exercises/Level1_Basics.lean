/-!
# Exercises — Level 1: Basics

Complete each `sorry` with an actual proof.
Difficulty: ⭐ (should be doable after reading Basics/ files)

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

-- Write these functions (replace `sorry` with implementations)

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

-- Hint: rfl
example : (fun x : Nat => x + 1) 5 = 6 := by sorry

-- Hint: rfl or decide
example : [1, 2, 3].length = 3 := by sorry

-- Hint: intro + rfl or rfl
theorem apply_id (n : Nat) : (fun x => x) n = n := by sorry

-- Hint: intro, simp, or omega
theorem succ_pos (n : Nat) : n + 1 > 0 := by sorry
