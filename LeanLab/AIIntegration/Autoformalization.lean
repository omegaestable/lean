import Mathlib.Tactic
import Mathlib.Data.Nat.Basic
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Int.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecificLimits.Basic

/-!
# Phase 4B — Autoformalization: Bridging Informal and Formal Math

## What is autoformalization?
The automatic translation of informal mathematical text (as found in
textbooks, papers, and competition problems) into formal Lean 4 code.

This is one of the most active research areas in AI/Lean integration
and a key theme of the Harmonic Aristotle program.

## This file contains
- Worked examples of autoformalization (informal → formal)
- Common pitfalls and how to avoid them
- Patterns for LLM-based autoformalization
- Exercises: formalize real mathematical statements
-/

-- ============================================================
-- SECTION 1: Worked examples — Informal to Formal
-- ============================================================

/-!
## Example 1
**Informal**: "The sum of two even numbers is even."

**Analysis**:
- "Even" means divisible by 2, i.e., ∃ k, n = 2 * k
- "Sum" means addition
- We need: ∀ a b, even(a) → even(b) → even(a + b)
-/

-- Formal version:
theorem sum_of_even (a b : ℤ) (ha : ∃ k, a = 2 * k) (hb : ∃ k, b = 2 * k) :
    ∃ k, a + b = 2 * k := by
  obtain ⟨ka, hka⟩ := ha
  obtain ⟨kb, hkb⟩ := hb
  use ka + kb
  linarith

/-!
## Example 2
**Informal**: "If n² is even, then n is even." (Contrapositive of a classic)

**Analysis**:
- This is often proved by contrapositive: if n is odd, then n² is odd
- "Odd" means ∃ k, n = 2 * k + 1
- We need to be careful about the logical structure
-/

theorem sq_even_imp_even (n : ℤ) (h : ∃ k, n ^ 2 = 2 * k) : ∃ k, n = 2 * k := by
  by_contra hnodd
  push_neg at hnodd
  -- This is the kind of problem where omega or Mathlib lemmas help
  -- In practice you might use: `Int.even_of_sq_even` from Mathlib
  sorry -- Exercise: complete this proof!

/-!
## Example 3
**Informal**: "For all ε > 0, there exists N such that for all n ≥ N, |1/n - 0| < ε."
(i.e., 1/n → 0)

**Analysis**:
- This is a convergence statement
- Need to be careful about types: 1/n in ℝ, not ℕ
- N should be chosen based on ε (Archimedean property)
-/

-- This is formalized in Mathlib as `tendsto_one_div_atTop_nhds_zero_nat`
-- But let's see what the manual version looks like:

-- Using our custom definition from Analysis.lean:
def SeqConvergesTo' (a : ℕ → ℝ) (L : ℝ) : Prop :=
  ∀ ε > 0, ∃ N : ℕ, ∀ n : ℕ, n ≥ N → |a n - L| < ε

-- The statement (proof is non-trivial, requires Archimedean property)
-- theorem one_over_n_converges : SeqConvergesTo' (fun n => 1 / (n + 1)) 0 := by
--   sorry

-- ============================================================
-- SECTION 2: Common autoformalization pitfalls
-- ============================================================

/-!
## Pitfall 1: Type mismatches
Informal math freely mixes ℕ, ℤ, ℚ, ℝ.
Lean requires explicit coercions.

❌ `theorem bad : (n : Nat) → n > 0 → 1/n > 0`
   (1/n in Nat is integer division! 1/3 = 0)

✓ `theorem good : (n : ℕ) → n > 0 → (1 : ℝ) / n > 0`
   (cast to ℝ for real division)

## Pitfall 2: Implicit assumptions
Informal: "Let p be prime" → need `Nat.Prime p` or `Fact (Nat.Prime p)`
Informal: "Let f be continuous" → need `Continuous f` or `ContinuousOn f s`
Informal: "Let G be a group" → need `[Group G]` typeclass instance

## Pitfall 3: Quantifier scope
Informal: "For large enough n, P(n)" → `∃ N, ∀ n ≥ N, P n`
NOT: `∀ n, (n is large) → P n` (what does "large" mean?)

## Pitfall 4: Convention differences
- Informal "positive" might mean > 0 or ≥ 0 depending on context
- "Divides" in ℤ vs ℕ has different behaviors
- "Subgroup" might be normal or not depending on context
- "Ring" might or might not be commutative

## Pitfall 5: Missing conditions
Informal: "√(ab) ≤ (a+b)/2" (AM-GM)
Formal needs: a ≥ 0 ∧ b ≥ 0 (otherwise √(ab) is undefined/complex)
-/

-- ============================================================
-- SECTION 3: The agentic autoformalization pipeline
-- ============================================================

/-!
## The FORMAL pipeline (Retrieval-Augmented Thinking)

1. **Input**: Informal mathematical statement
2. **Retrieve**: Find similar formal statements in Mathlib
3. **Generate**: LLM produces candidate Lean formalization
4. **Check**: Lean compiler verifies syntax and types
5. **Fix**: If errors, feed error messages back to LLM
6. **Iterate**: Repeat steps 3-5 until correct or max attempts

## The PSV pipeline (Process-level Self-Verification)

1. **Statement formalization**: Translate the statement
2. **Proof attempt**: Try to prove it
3. **Verification**: Check if the proof is correct
4. **Feedback**: Use proof success/failure as signal
5. **Refinement**: Adjust the formalization based on feedback

## Why iterative approaches work better
- First-attempt accuracy for LLMs is ~30-50%
- With compiler feedback: ~60-70%
- With retrieval augmentation: ~70-80%
- The compiler is a perfect verifier (unlike code generation)

This is why formal methods + AI is so powerful:
you have an ORACLE (the Lean kernel) that tells you definitively
whether your answer is correct.
-/

-- ============================================================
-- SECTION 4: Exercises — Formalize these!
-- ============================================================

-- For each informal statement, write the formal Lean 4 version
-- AND prove it (or use `sorry` if the proof is too hard).

-- 1. "The product of two odd numbers is odd"
-- (odd n means ∃ k, n = 2 * k + 1)
-- theorem prod_odd : ... := by sorry

-- 2. "If a | b and a | c, then a | (b + c)"
theorem dvd_add_exercise (a b c : ℤ) (h1 : a ∣ b) (h2 : a ∣ c) : a ∣ (b + c) := by
  sorry

-- 3. "For all n ≥ 1, n² ≥ n"
theorem sq_ge_self (n : ℕ) (h : n ≥ 1) : n ^ 2 ≥ n := by
  sorry

-- 4. "The square root of 2 is irrational"
-- (This exists in Mathlib — find it!)
-- #check irrational_sqrt_two

-- 5. (Challenge) Formalize and prove:
--    "If p is prime and p | ab, then p | a or p | b"
-- This is Euclid's lemma — it's in Mathlib as `Nat.Prime.dvd_mul`
-- theorem euclids_lemma : ... := by sorry

-- 6. (Challenge) AMC-style problem:
--    "Find the remainder when 2^100 is divided by 7"
--    (Hint: use modular arithmetic and `decide` or `native_decide`)
example : 2 ^ 100 % 7 = 2 := by native_decide

-- ============================================================
-- SECTION 5: Building your autoformalization portfolio
-- ============================================================

/-!
## For your Aristotle grant application

Demonstrating autoformalization skill means:
1. Taking problems from informal math sources
2. Formalizing them correctly in Lean 4
3. Proving them (or identifying what's needed for the proof)
4. Documenting the translation decisions you made
5. Identifying and fixing misformalizations in benchmarks

## Suggested portfolio projects
- Formalize 10-20 problems from a math textbook in your area
- Formalize 5-10 competition problems and prove them
- Find and fix misformalizations in miniF2F
- Build a small RAG-based autoformalization tool (Python + Lean)
- Write a blog post comparing informal vs formal statements

## Where to find problems to formalize
- IMO Shortlist problems
- Putnam competition problems
- Your own research papers
- Textbook theorem statements in your field
- miniF2F problems that are still unsolved
-/
