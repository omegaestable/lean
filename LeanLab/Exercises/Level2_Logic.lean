import Mathlib.Tactic

/-!
# Exercises — Level 2: Logic and Proofs

This is where the real proving begins! Each exercise asks you to
prove a logical statement using tactics. If you get stuck:
  1. Look at the Infoview panel — what's the goal? What hypotheses do you have?
  2. Think: "What's the shape of my goal?" (→ means `intro`, ∧ means `constructor`, etc.)
  3. Refer back to the Logic/ tutorial files for examples

## Difficulty: ⭐⭐ (requires reading Logic/ files)

## Quick tactic reminder
  | Goal shape   | Try this tactic    |
  |-------------|-------------------|
  | `P → Q`     | `intro h`         |
  | `P ∧ Q`     | `constructor`      |
  | `P ∨ Q`     | `left` or `right` |
  | `¬P`        | `intro h`         |
  | `P ↔ Q`     | `constructor`      |
  | `∀ x, P x`  | `intro x`        |
  | `∃ x, P x`  | `use witness`     |
  | have `h : P ∧ Q` | `obtain ⟨hp, hq⟩ := h` |
  | have `h : P ∨ Q` | `rcases h with hp | hq` |

Tactic suggestions are given. Try to use different approaches!
-/

-- ============================================================
-- IMPLICATION
-- ============================================================

-- The simplest implication
example (P : Prop) : P → P := by sorry

-- Implication is transitive
example (P Q R : Prop) : (P → Q) → (Q → R) → (P → R) := by sorry

-- Currying
example (P Q R : Prop) : (P ∧ Q → R) → (P → Q → R) := by sorry

-- Uncurrying
example (P Q R : Prop) : (P → Q → R) → (P ∧ Q → R) := by sorry

-- ============================================================
-- CONJUNCTION (AND)
-- ============================================================

-- Swap the sides
example (P Q : Prop) : P ∧ Q → Q ∧ P := by sorry

-- Extract from nested conjunction
example (P Q R : Prop) : P ∧ Q ∧ R → R := by sorry

-- Combine two implications
example (P Q R S : Prop) : (P → R) → (Q → S) → P ∧ Q → R ∧ S := by sorry

-- ============================================================
-- DISJUNCTION (OR)
-- ============================================================

-- If P then P or anything
example (P Q : Prop) : P → P ∨ Q := by sorry

-- Disjunction is associative
example (P Q R : Prop) : (P ∨ Q) ∨ R → P ∨ (Q ∨ R) := by sorry

-- Distribute ∧ over ∨
example (P Q R : Prop) : P ∧ (Q ∨ R) → (P ∧ Q) ∨ (P ∧ R) := by sorry

-- ============================================================
-- NEGATION
-- ============================================================

-- From False, anything follows
example (P : Prop) : False → P := by sorry

-- Modus tollens
example (P Q : Prop) : (P → Q) → ¬Q → ¬P := by sorry

-- Contrapositive (constructive direction)
example (P Q : Prop) : (P → Q) → (¬Q → ¬P) := by sorry

-- ============================================================
-- IFF (IF AND ONLY IF)
-- ============================================================

-- Iff is symmetric
example (P Q : Prop) : (P ↔ Q) → (Q ↔ P) := by sorry

-- Iff is transitive
example (P Q R : Prop) : (P ↔ Q) → (Q ↔ R) → (P ↔ R) := by sorry

-- ============================================================
-- QUANTIFIERS
-- ============================================================

-- Simple universal
example : ∀ n : Nat, 0 ≤ n := by sorry

-- Existential with witness
example : ∃ n : Nat, n + n = 10 := by sorry

-- Universal + existential
example : ∀ n : Nat, ∃ m : Nat, m = n + 1 := by sorry

-- From existential hypothesis
example : (∃ n : Nat, n > 100) → ∃ n : Nat, n > 50 := by sorry

-- ============================================================
-- CHALLENGE: Combine everything
-- ============================================================

-- 🏆 These require combining multiple tactics. Break the proof
-- into small steps using `have` if needed. There's no shame in
-- looking back at the Logic/ tutorial files!
example (P Q R : Prop) : (P ∨ Q) → (P → R) → (Q → R) → R := by sorry

-- A real logical puzzle:
-- "If it's raining, the ground is wet.
--  If the ground is wet, it's slippery.
--  It's raining. Therefore it's slippery."
example (raining wet slippery : Prop)
    (h1 : raining → wet)
    (h2 : wet → slippery)
    (h3 : raining) : slippery := by sorry
