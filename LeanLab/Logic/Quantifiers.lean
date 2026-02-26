import Mathlib.Tactic

/-!
# 05 — Quantifiers: For All and There Exists

This is where Lean starts to feel like real mathematics. If the previous
file was about logic puzzles, this file is about mathematical reasoning.

## The mathematical heart of Lean
- `∀ x, P x` = "for all x, P(x) holds" = a dependent function
- `∃ x, P x` = "there exists x such that P(x)" = a dependent pair

## Learning objectives
After this file you will be able to:
  1. Prove universal statements with `intro`
  2. Prove existential statements with `use` (providing a witness)
  3. Destructure existential hypotheses with `obtain`
  4. Use `rw` (rewrite) and `calc` blocks for equational reasoning
  5. Work with classical logic (`by_contra`, excluded middle)

## A note on `use`
The `use` tactic is one of the most satisfying in Lean. When your goal
is `∃ x, P x`, you say `use 42` (or whatever your witness is), and
Lean immediately asks you to prove `P 42`. You've made an existence
claim concrete!
-/

-- ============================================================
-- SECTION 1: Universal quantifier (∀)
-- ============================================================

-- 💡 MENTAL MODEL: ∀ is just a function!
-- `∀ n : Nat, P n` means:
-- "give me ANY Nat, and I'll give you a proof of P for that Nat."
--
-- This is literally the same as a dependent function type.
-- To PROVE ∀ x, P x: use `intro x` (let x be arbitrary), then prove P x.
-- To USE  h : ∀ x, P x: apply it to a specific value, e.g., `h 42`.

theorem all_add_zero : ∀ n : Nat, n + 0 = n := by
  intro n              -- "let n be an arbitrary Nat"
  rfl                  -- both sides are definitionally equal

-- Multiple quantifiers
theorem all_add_comm : ∀ (a b : Nat), a + b = b + a := by
  intro a b
  omega                -- `omega` solves linear arithmetic over Nat and Int

-- Using `∀` with a hypothesis
theorem all_impl : ∀ n : Nat, n > 0 → n ≥ 1 := by
  intro n hn
  omega

-- ============================================================
-- SECTION 2: Existential quantifier (∃)
-- ============================================================

-- 💡 MENTAL MODEL: ∃ is a pair — a WITNESS plus a PROOF about that witness.
-- `∃ x, P x` means "I have a specific x, and P holds for that x."
--
-- To PROVE ∃ x, P x:
--   1. Use `use value` to provide your witness
--   2. Then prove that P holds for your specific value
--
-- To USE h : ∃ x, P x:
--   Use `obtain ⟨x, hx⟩ := h` to get the witness `x` and proof `hx`.

theorem exists_even : ∃ n : Nat, n % 2 = 0 := by
  use 42               -- "I claim n = 42 works" (the witness)

-- Another example: there exists a number greater than 100
theorem exists_big : ∃ n : Nat, n > 100 := by
  use 101              -- witness
  omega                -- proof that 101 > 100

-- Using an existential hypothesis
theorem exists_double : (∃ n : Nat, n * 2 = 10) → ∃ m : Nat, m = 5 := by
  intro ⟨n, hn⟩       -- destructure: get the witness n and proof hn
  use n                -- claim m = n
  omega                -- arithmetic takes care of the rest

-- ============================================================
-- SECTION 3: Combining quantifiers
-- ============================================================

-- "For every even number, there exists a half"
theorem even_has_half : ∀ n : Nat, n % 2 = 0 → ∃ k : Nat, n = 2 * k := by
  intro n hn
  use n / 2
  omega

-- Nested quantifiers
example : ∀ n : Nat, ∃ m : Nat, m > n := by
  intro n
  use n + 1
  omega

-- ============================================================
-- SECTION 4: Equality
-- ============================================================

-- Equality is the most fundamental relation in mathematics, and Lean
-- has powerful tools for working with it. These three tactics will
-- handle 90% of your equality proofs:
--
-- `rfl`     : proves a = a (reflexivity) — "both sides are the same"
-- `rw [h]`  : if h : a = b, replaces a with b in the goal — "substitute"
-- `calc`    : chain of equalities — "step-by-step, like on paper"
--
-- 💡 TIP: `calc` blocks are how experienced Lean users write readable
-- proofs. They look just like the chain-of-equalities proofs you'd
-- write on a whiteboard. Get comfortable with them early!

-- The `rw` (rewrite) tactic
theorem rw_example (a b c : Nat) (h1 : a = b) (h2 : b = c) : a = c := by
  rw [h1]             -- goal becomes b = c
  rw [h2]             -- goal becomes c = c, which is rfl

-- The `calc` block — feels like writing math on paper
theorem calc_example (a b c : Nat) (h1 : a = b + 1) (h2 : b = c + 1) : a = c + 2 := by
  calc a = b + 1     := h1
    _ = (c + 1) + 1  := by rw [h2]
    _ = c + 2        := by omega

-- ============================================================
-- SECTION 5: Classical logic
-- ============================================================

-- Lean is constructive by default, but you can use classical logic:
open Classical in
theorem em_example (P : Prop) : P ∨ ¬P := by
  exact Classical.em P           -- law of excluded middle

-- `by_contra` assumes ¬(goal) and asks you to derive False
open Classical in
theorem double_neg (P : Prop) : ¬¬P → P := by
  intro hnnp
  by_contra hnp        -- assume ¬P, derive contradiction
  exact hnnp hnp       -- ¬¬P applied to ¬P gives False

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Prove: for every n, there exists m such that m = n + n
theorem exists_double' : ∀ n : Nat, ∃ m : Nat, m = n + n := by
  sorry

-- 2. Prove transitivity of ≤ using omega
theorem le_trans_example (a b c : Nat) (h1 : a ≤ b) (h2 : b ≤ c) : a ≤ c := by
  sorry

-- 3. Use `calc` to prove: if a = b and b = c and c = d, then a = d
theorem eq_chain (a b c d : Nat) (h1 : a = b) (h2 : b = c) (h3 : c = d) : a = d := by
  sorry
