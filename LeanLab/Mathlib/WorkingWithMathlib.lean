import Mathlib.Tactic
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Ring.Basic
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Int.GCD
import Mathlib.Order.Basic
import Mathlib.Data.Set.Basic

/-!
# Phase 2B — Working with Mathlib: Real Formalization Workflow

The previous file taught you how to FIND lemmas. This file teaches you
how to USE them fluently. You'll learn the proof patterns that experienced
Lean users reach for naturally — patterns that turn a frustrating proof
attempt into a clean, readable argument.

## What this file covers
- Importing and navigating Mathlib
- Working with Mathlib's algebraic hierarchy (typeclasses)
- Proof engineering patterns used in real Mathlib contributions
- How to structure a formalization project that builds on Mathlib

## Learning objectives
After this file you will be able to:
  1. Understand Mathlib's typeclass hierarchy and why it exists
  2. Work with sets as predicates
  3. Use `calc`, `have`, `suffices`, and `convert` fluently
  4. Read and write Mathlib-style proofs
  5. Know the Mathlib contribution workflow

## Why this matters for AI/Lean research
AI models like Aristotle, DeepSeek-Prover, and AlphaProof are trained on
Mathlib proofs. Understanding Mathlib conventions is essential for:
- Training data extraction
- Evaluating AI-generated proofs
- Contributing formalizations that AI can learn from
-/

-- ============================================================
-- SECTION 1: Mathlib's typeclass hierarchy
-- ============================================================

-- 💡 KEY INSIGHT: Typeclasses are how Lean knows that ℤ is a ring,
-- that ℚ is a field, that ℝ is an ordered field, etc. When you write
-- `[CommRing R]`, Lean automatically infers that R is also a Ring,
-- a Monoid, an AddGroup, and everything else in the hierarchy below.
-- You don't need to state all of these — Lean figures it out.

/-!
Mathlib organizes mathematics through **typeclasses** — a Lean mechanism
for ad-hoc polymorphism. The hierarchy looks like:

```
Monoid → Group → CommGroup
              ↓
Semiring → Ring → CommRing → Field
              ↓
        OrderedRing → LinearOrderedField
```

When you write `[CommRing R]`, you're saying "R is a commutative ring"
and Lean automatically knows it's also a ring, a monoid, etc.
-/

-- Working with abstract structures: the proof works for ANY commutative ring
example {R : Type*} [CommRing R] (a b : R) :
    (a + b) * (a - b) = a ^ 2 - b ^ 2 := by
  ring

-- Lean automatically finds instances for concrete types
example : (3 : ℤ) * (3 + 4) = 21 := by norm_num

-- You can check what instances exist:
#check (inferInstance : CommRing ℤ)
#check (inferInstance : Field ℚ)

-- ============================================================
-- SECTION 2: Sets in Mathlib
-- ============================================================

-- Sets in Mathlib are predicates: `Set α` is `α → Prop`

open Set in
example : ({1, 2, 3} : Set Nat) ∩ {2, 3, 4} = {2, 3} := by
  ext x
  simp
  omega

-- Subset
open Set in
example : ({1, 2} : Set Nat) ⊆ {1, 2, 3} := by
  intro x hx
  simp at hx ⊢
  omega

-- ============================================================
-- SECTION 3: Proof engineering patterns
-- ============================================================

-- 💡 These five patterns cover 90% of the proof moves you'll ever make.
-- Master them and you'll be able to structure any proof clearly.
-- Think of them as your "proof vocabulary."

-- PATTERN 1: `calc` for readable chains (this is how Mathlib proofs look)
-- Use when: You want to show A ≤ B ≤ C or A = B = C step by step.
-- Each line has `_ rel RHS := by justification`.
example (a b c d : ℤ) (h1 : a ≤ b) (h2 : c ≤ d) : a + c ≤ b + d := by
  calc a + c ≤ b + c := by linarith
    _ ≤ b + d := by linarith

-- PATTERN 2: `have` for intermediate steps
example (n : Nat) (h : n > 0) : n * n > 0 := by
  have h1 : n ≥ 1 := h
  have h2 : n * n ≥ 1 * 1 := Nat.mul_le_mul h1 h1
  omega

-- PATTERN 3: `suffices` for backward reasoning
example (n : Nat) (h : n > 10) : n > 5 := by
  suffices n ≥ 11 from by omega
  omega

-- PATTERN 4: `convert` — like `exact` but allows mismatches to become goals
-- This is VERY useful when types almost match but not quite.

-- PATTERN 5: `gcongr` — generalized congruence for inequalities
example (a b c d : ℤ) (h1 : a ≤ b) (h2 : c ≤ d)
    (ha : 0 ≤ a) (hc : 0 ≤ c) : a * c ≤ b * d := by
  have hb : 0 ≤ b := le_trans ha h1
  exact mul_le_mul h1 h2 hc hb

-- ============================================================
-- SECTION 4: Contributing to Mathlib
-- ============================================================

/-!
## How Mathlib contributions work
Contributing to Mathlib is a fantastic way to learn and to advance
formal mathematics. Even small contributions (improving documentation,
adding a missing lemma, fixing a proof) are valued by the community.

1. **Find something to formalize**: Check the Mathlib project board,
   Zulip discussions, or identify gaps in your area.

2. **Follow conventions**:
   - Use `snake_case` for definitions and lemmas
   - Follow the naming scheme (see SearchAndDiscovery.lean)
   - Add `@[simp]` attributes where appropriate
   - Write docstrings with `/-- -/` syntax

3. **Submit a PR**:
   - Fork mathlib4, create a branch
   - Run `lake build` and linters locally
   - Submit PR with description of mathematical content
   - Respond to code review feedback

4. **Quality standards**:
   - No `sorry` (obviously)
   - Consistent style with surrounding code
   - Appropriate level of generality (not too specific, not too abstract)
   - Good documentation

## Example of a well-documented Mathlib-style lemma:
-/

/-- If `a` divides both `b` and `c`, then `a` divides their sum.
This is a basic property of divisibility in any `CommMonoid`. -/
theorem my_dvd_add_example (a b c : Nat) (h1 : a ∣ b) (h2 : a ∣ c) :
    a ∣ b + c := by
  obtain ⟨k, hk⟩ := h1
  obtain ⟨l, hl⟩ := h2
  use k + l
  rw [hk, hl]
  ring

-- ============================================================
-- SECTION 5: Exploring Mathlib programmatically
-- ============================================================

/-!
## Extracting data from Mathlib (relevant for AI/ML)

The Lean 4 environment stores all definitions, theorems, and proofs
as data that can be accessed programmatically. This is how tools like
LeanDojo extract training data for AI models.

Key concepts:
- `Environment` — the collection of all declarations
- `Declaration` — a definition, theorem, axiom, etc.
- `Expr` — Lean's internal representation of terms and types
- `Name` — the hierarchical name of a declaration

We'll explore this more in the Metaprogramming section.
-/

-- You can inspect declarations:
#print Nat.Prime          -- see the definition of "prime"
#print Nat.add_comm       -- see the proof of commutativity

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Prove using Mathlib lemmas (use `exact?` to find them)
example (p : Nat) (hp : Nat.Prime p) : p ≥ 2 := by
  sorry

-- 2. Prove a set equality
open Set in
example : ({1, 2, 3} : Set Nat) ∪ {3, 4, 5} = {1, 2, 3, 4, 5} := by
  sorry

-- 3. Write a Mathlib-style documented lemma for: n^2 is even iff n is even
-- (This is genuinely useful! Think about what imports you need.)
