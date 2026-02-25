/-!
# Exercises — Level 2: Logic and Proofs

Complete each `sorry` with an actual proof.
Difficulty: ⭐⭐ (requires reading Logic/ files)

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

-- This one requires multiple tactics. Take your time.
example (P Q R : Prop) : (P ∨ Q) → (P → R) → (Q → R) → R := by sorry

-- A real logical puzzle:
-- "If it's raining, the ground is wet.
--  If the ground is wet, it's slippery.
--  It's raining. Therefore it's slippery."
example (raining wet slippery : Prop)
    (h1 : raining → wet)
    (h2 : wet → slippery)
    (h3 : raining) : slippery := by sorry
