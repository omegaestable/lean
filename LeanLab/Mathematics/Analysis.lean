/-!
# 09 — Analysis: Limits, Continuity, and Beyond

## Analysis in Lean
Mathlib has a full development of real analysis, topology, and measure theory.
This file gives you a taste of how mathematical analysis looks in Lean.

Fair warning: analysis in Lean is harder than algebra because it involves
ε-δ arguments that require careful manipulation. But the patterns become
natural with practice.
-/

import Mathlib.Tactic
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.Order.Basic
import Mathlib.Analysis.Normed.Group.Basic

-- ============================================================
-- SECTION 1: Absolute value and basic inequalities
-- ============================================================

-- Working with absolute values
example (a : ℝ) : |a| ≥ 0 := abs_nonneg a

example (a b : ℝ) : |a + b| ≤ |a| + |b| := abs_add a b

-- Useful lemma patterns
example (a : ℝ) (h : |a| < 1) : -1 < a := by linarith [abs_lt.mp h]

-- ============================================================
-- SECTION 2: Sequences (a taste of what ε-δ proofs look like)
-- ============================================================

-- A sequence is just a function ℕ → ℝ
-- "a_n converges to L" is written: Filter.Tendsto a Filter.atTop (nhds L)
-- But let's work with the raw ε-definition first to see what's happening:

-- Definition: a sequence a converges to L if
-- ∀ ε > 0, ∃ N, ∀ n ≥ N, |a n - L| < ε

def SeqConvergesTo (a : ℕ → ℝ) (L : ℝ) : Prop :=
  ∀ ε > 0, ∃ N : ℕ, ∀ n : ℕ, n ≥ N → |a n - L| < ε

-- The constant sequence converges to itself
theorem const_converges (c : ℝ) : SeqConvergesTo (fun _ => c) c := by
  intro ε hε
  use 0
  intro n _hn
  simp
  exact hε

-- The zero sequence converges to 0
theorem zero_converges : SeqConvergesTo (fun _ => 0) 0 := by
  exact const_converges 0

-- ============================================================
-- SECTION 3: Working with Mathlib's topology
-- ============================================================

-- Mathlib uses filters for limits, which is more general.
-- Here are some examples using Mathlib's API:

-- Continuous functions
-- In Mathlib: `Continuous f` means f is continuous everywhere

example : Continuous (fun x : ℝ => x + 1) := by
  fun_ext  -- or continuity
  sorry    -- these require more Mathlib setup

-- Instead, let's work with what's easier:

-- A function is continuous at a point if...
-- (The ε-δ definition you know)

-- ============================================================
-- SECTION 4: Metric spaces (abstract setting)
-- ============================================================

-- Mathlib abstracts over metric spaces with the `MetricSpace` typeclass.
-- `dist x y` is the distance function.

variable {X : Type*} [MetricSpace X]

-- Distance is symmetric
example (x y : X) : dist x y = dist y x := dist_comm x y

-- Triangle inequality
example (x y z : X) : dist x z ≤ dist x y + dist y z := dist_triangle x y z

-- Distance is non-negative
example (x y : X) : dist x y ≥ 0 := dist_nonneg

-- dist x x = 0
example (x : X) : dist x x = 0 := dist_self x

-- ============================================================
-- SECTION 5: The big picture — what's available in Mathlib
-- ============================================================

/-!
Mathlib has formalizations of:
- **Real analysis**: limits, derivatives, integrals (Lebesgue!), power series
- **Complex analysis**: holomorphic functions, Cauchy integral formula
- **Measure theory**: σ-algebras, measures, Lp spaces
- **Topology**: general topology, compactness, connectedness
- **Functional analysis**: Banach spaces, Hilbert spaces, spectral theory
- **Algebraic topology**: fundamental group (in progress)
- **Number theory**: Dirichlet's theorem, quadratic reciprocity
- **Algebraic geometry**: schemes, sheaves (in progress)

To find lemmas, use:
- `exact?`  — "find a lemma that closes this goal"
- `apply?` — "find a lemma I can apply here"
- `rw?`    — "find a rewrite rule for this"
- `simp?`  — "what lemmas did simp use?"
- The Mathlib documentation: https://leanprover-community.github.io/mathlib4_docs/
-/

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Prove triangle inequality for absolute value
example (a b c : ℝ) : |a - c| ≤ |a - b| + |b - c| := by
  sorry
  -- hint: this is `abs_sub_abs_le_abs_sub` or use `calc` with `abs_add`

-- 2. Prove the constant sequence converges (do it yourself this time)
theorem my_const_converges (c : ℝ) : SeqConvergesTo (fun _ => c) c := by
  sorry
