import Mathlib.Tactic

/-!
# 06 — Tactics: Your Proof Toolbox

This file is your **reference guide** for tactics. You've already seen
many of these in the previous files — now we consolidate them in one place
with clear examples and a quick-reference table.

Come back to this file whenever you forget what a tactic does!

## What are tactics?
Tactics are commands that transform proof goals step by step.
Think of them as "moves" in a proof game:
  - You start with a GOAL (what you need to prove)
  - Each tactic transforms the goal into simpler subgoals
  - When no goals remain, the proof is complete
  - Lean ensures every move is valid — you can't cheat!

## Learning objectives
After this file you will:
  1. Know the core tactics (intro, exact, apply, constructor, cases, obtain)
  2. Know the rewriting tactics (rw, simp)
  3. Know the "power tactics" (omega, norm_num, ring, linarith, aesop)
  4. Understand when to use which tactic
  5. Have a reference table you can come back to

## Reading tactic proofs
After each tactic, look at the "Lean Infoview" panel in VS Code.
It shows your current goals and hypotheses. This is ESSENTIAL.
Put your cursor on each line to see the state at that point.

## The "I'm stuck" ladder
When you don't know which tactic to use, try these in order:
  1. `exact?` — does a single lemma close the goal?
  2. `simp` — can simplification handle it?
  3. `omega` — is it arithmetic?
  4. `ring` — is it an algebraic identity?
  5. `linarith` — do the hypotheses imply the goal linearly?
  6. `aesop` — can automated search figure it out?
  7. *Think* — what's the mathematical idea? Break it into steps with `have`.
-/

-- ============================================================
-- SECTION 1: The most important tactics
-- ============================================================

-- INTRO: introduces hypotheses / universal variables
example (P Q : Prop) : P → Q → P := by
  intro hp _hq          -- now we have hp : P and _hq : Q in context
  exact hp              -- the goal is P, which we have

-- EXACT: provides the exact proof term
example (P : Prop) (hp : P) : P := by
  exact hp

-- APPLY: "backwards reasoning" — if goal is Q and we have h : P → Q,
-- `apply h` changes the goal to P
example (P Q : Prop) (h : P → Q) (hp : P) : Q := by
  apply h               -- goal changes from Q to P
  exact hp

-- CONSTRUCTOR: splits a goal with multiple parts (∧, ↔, ∃)
example (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor
  · exact hp
  · exact hq

-- CASES: case analysis on a hypothesis
example (P Q : Prop) (h : P ∨ Q) : Q ∨ P := by
  cases h with
  | inl hp => right; exact hp
  | inr hq => left; exact hq

-- OBTAIN: destructure a hypothesis
example (P Q : Prop) (h : P ∧ Q) : Q := by
  obtain ⟨_hp, hq⟩ := h
  exact hq

-- ============================================================
-- SECTION 2: Rewriting tactics
-- ============================================================

-- Rewriting is one of the most common things you'll do in proofs.
-- The key idea: if you know a = b, you can replace a with b anywhere.
-- This is so fundamental that it has its own dedicated tactics.

-- RW (rewrite): substitutes equal things
example (a b : Nat) (h : a = b) : a + 1 = b + 1 := by
  rw [h]               -- replaces a with b everywhere in the goal

-- RW ← (rewrite backwards): goes the other direction
example (a b : Nat) (h : a = b) : b + 1 = a + 1 := by
  rw [← h]             -- replaces b with a

-- Multiple rewrites
example (a b c : Nat) (h1 : a = b) (h2 : b = c) : a = c := by
  rw [h1, h2]          -- chain rewrites

-- SIMP: the simplifier — tries to simplify using a database of lemmas
example (n : Nat) : n + 0 = n := by
  simp                  -- knows that n + 0 = n

example (xs : List Nat) : (xs ++ []).length = xs.length := by
  simp                  -- knows that xs ++ [] = xs

-- SIMP with specific lemmas
example (a b : Nat) (h : a = b) : a + 1 = b + 1 := by
  simp [h]             -- simplify using h

-- ============================================================
-- SECTION 3: Arithmetic and decision tactics
-- ============================================================

-- These are the "just solve it" tactics for arithmetic. They're
-- incredibly powerful — learn when to reach for each one!
--
-- `omega`    — linear equations and inequalities over ℕ and ℤ
-- `norm_num` — concrete numerical calculations (2 + 3 = 5)
-- `decide`   — finite/decidable propositions (can the computer check all cases?)

-- OMEGA: solves linear arithmetic over Nat and Int
example (n : Nat) : n + 1 > n := by omega
example (a b : Nat) (h : a ≤ b) : a ≤ b + 1 := by omega
example (n : Nat) : 2 * n + 1 > n := by omega

-- NORM_NUM: normalizes numerical expressions
example : (2 : Nat) + 3 = 5 := by norm_num
example : (10 : Nat) * 10 = 100 := by norm_num
example : (7 : Int) - 12 = -5 := by norm_num

-- DECIDE: for decidable propositions (finite case checking)
example : 2 + 2 = 4 := by decide
example : ¬(3 = 4) := by decide

-- ============================================================
-- SECTION 4: Structural tactics
-- ============================================================

-- INDUCTION: prove by induction on a natural number or inductive type
theorem sum_formula (n : Nat) : 0 + n = n := by
  induction n with
  | zero => rfl
  | succ k ih =>
    rw [Nat.add_succ]
    exact congrArg Nat.succ ih

-- HAVE: introduce an intermediate result
example (P Q R : Prop) (hpq : P → Q) (hqr : Q → R) (hp : P) : R := by
  have hq : Q := hpq hp    -- first establish Q
  have hr : R := hqr hq    -- then establish R
  exact hr

-- SUFFICES: "it suffices to show..."
example (P Q : Prop) (hpq : P → Q) (hp : P) : Q := by
  suffices h : P from hpq h   -- it suffices to show P
  exact hp

-- ============================================================
-- SECTION 5: Power tactics (the "just solve it" tactics)
-- ============================================================

-- These tactics use sophisticated automation to close goals.
-- They're great for finishing proofs, but DON'T rely on them exclusively —
-- understanding WHY a proof works is more valuable than just closing goals.
-- Use them when the mathematical insight is clear but the Lean details
-- are tedious.

-- AESOP: Automated Extensible Search for Obvious Proofs
-- It tries many tactics automatically — good for "obvious" goals
example (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  aesop

-- TAUTO: propositional tautology checker
example (P Q : Prop) : P → Q → P := by
  tauto

example (P Q R : Prop) : (P → Q → R) → (P → Q) → P → R := by
  tauto

-- ============================================================
-- QUICK REFERENCE
-- ============================================================

/-
| Tactic      | What it does                                    |
|-------------|-------------------------------------------------|
| intro       | Introduce hypothesis / variable                  |
| exact       | Provide exact proof term                         |
| apply       | Backward reasoning with a lemma/hypothesis       |
| constructor | Split ∧, ↔, or ∃ goal into parts                |
| cases       | Case split on ∨ or inductive hypothesis          |
| obtain      | Destructure ∧, ∃ hypotheses                      |
| rw          | Rewrite using an equality                        |
| simp        | Simplify using lemma database                    |
| omega       | Linear arithmetic (Nat, Int)                     |
| norm_num    | Numerical normalization                          |
| decide      | Decidable propositions                           |
| induction   | Proof by induction                               |
| have        | Introduce intermediate fact                      |
| suffices    | "It suffices to show..."                         |
| aesop       | Automated proof search                           |
| tauto       | Propositional tautologies                        |
| ring        | Ring equalities (polynomials)                    |
| linarith    | Linear arithmetic with hypotheses                |
| by_contra   | Proof by contradiction                           |
| exfalso     | Change goal to False                             |
| trivial     | Solve trivial goals                              |
-/

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- Use whatever tactics you want! The goal is to close each proof.

-- 1. (hint: tauto or intro + exact)
example (P Q R : Prop) : (P ∧ Q) → (Q → R) → R := by
  sorry

-- 2. (hint: cases + constructor)
example (P Q R : Prop) : P ∧ (Q ∨ R) → (P ∧ Q) ∨ (P ∧ R) := by
  sorry

-- 3. (hint: omega)
example (n : Nat) (h : n > 5) : n > 3 := by
  sorry

-- 4. (hint: simp or rw)
example (xs ys : List Nat) : (xs ++ ys).length = xs.length + ys.length := by
  sorry
