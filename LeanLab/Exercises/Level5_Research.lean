import Mathlib.Tactic
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.NumberTheory.Divisors
import Mathlib.GroupTheory.OrderOfElement

/-!
# Exercises — Level 5: Research-Level Formalization

Congratulations on reaching the final level! These are not "exercises"
in the traditional sense — they're mini research projects. Each one
could take hours (or days) to complete, and that's completely normal.

## Difficulty: ⭐⭐⭐⭐⭐ (real research problems)

## How to approach these
  1. Start by finding whether Mathlib already has the result (`exact?`, Moogle)
  2. If it does, study the Mathlib proof to understand the approach
  3. If it doesn't, formalize the STATEMENT first (this is already valuable!)
  4. Break the proof into lemmas and prove them one at a time
  5. Use `sorry` freely for sub-goals — you can fill them in later

## Why this matters
These exercises represent the kind of work valued by the Aristotle program.
Each one involves formalizing a non-trivial mathematical result.
Don't expect to finish all of these — they're aspirational goals.
Completing even ONE of these projects demonstrates real competence.
-/

-- ============================================================
-- PROJECT 1: Formalize the Irrationality of √2
-- ============================================================

/-!
## The classic proof by contradiction:
1. Assume √2 = p/q with gcd(p,q) = 1
2. Then 2q² = p², so p² is even, so p is even
3. Write p = 2k, then 2q² = 4k², so q² = 2k²
4. So q is even, contradicting gcd(p,q) = 1

Mathlib already has this. Try to:
a) Find the Mathlib version
b) Write your own proof (even a partial one!)
-/

-- Find it:
-- #check irrational_sqrt_two

-- Your version (sketch — this is genuinely hard in Lean):
-- theorem my_sqrt2_irrational : Irrational (Real.sqrt 2) := by
--   sorry

-- ============================================================
-- PROJECT 2: Bezout's Identity
-- ============================================================

/-!
## Statement: For all integers a, b, there exist x, y such that
## gcd(a, b) = a * x + b * y

This is a fundamental result in number theory.
Mathlib has it — find and use it.
-/

-- Find the Mathlib version:
-- #check Int.gcd_eq_gcd_ab

-- Prove a special case:
theorem bezout_special : ∃ x y : ℤ, 12 * x + 8 * y = 4 := by
  sorry  -- hint: x = 1, y = -1

-- ============================================================
-- PROJECT 3: Fundamental Theorem of Arithmetic (uniqueness)
-- ============================================================

/-!
## Every natural number > 1 has a unique prime factorization.

The existence part: every n > 1 has a prime factor.
The uniqueness part: the factorization is unique up to order.

Mathlib has the full theorem. Explore it:
-/

-- #check Nat.factors
-- #check Nat.factors_unique

-- Verify for specific numbers:
-- #eval Nat.factors 60    -- [2, 2, 3, 5]
-- #eval Nat.factors 100   -- [2, 2, 5, 5]

-- ============================================================
-- PROJECT 4: Convergence of a Series
-- ============================================================

/-!
## Prove that the geometric series Σ (1/2)^n converges to 2.

This requires:
- Understanding Mathlib's summation (`tsum`)
- Working with real analysis in Lean
- Connecting finite and infinite sums
-/

-- The Mathlib way:
-- #check tsum_geometric_of_lt_one
-- #check hasSum_geometric_of_lt_one

-- ============================================================
-- PROJECT 5: Group Theory
-- ============================================================

/-!
## Prove: In a group of order 2, the non-identity element is its own inverse.
## (i.e., if |G| = 2 and g ≠ 1, then g * g = 1)
-/

-- This requires working with `Fintype` and `Finset` in Mathlib.
-- Start by exploring:
-- #check orderOf_dvd_card

-- ============================================================
-- PROJECT 6: Your Own Research
-- ============================================================

/-!
## Formalize a result from YOUR research area.

This is the most valuable exercise in the entire course.
Taking something from YOUR field and expressing it in Lean teaches
you more than any tutorial can.

Steps:
1. Choose a theorem from your field (preferably one you understand well)
2. Check if it's already in Mathlib (use Moogle or exact?)
3. If not, formalize the statement — this alone is a contribution!
4. Attempt the proof (it's OK to use sorry for hard steps)
5. Document what you learned and the decisions you made

Tips:
- Start with the simplest non-trivial result in your area
- Don't aim for the most general version — start specific
- If the proof is too hard, formalizing just the STATEMENT is still
  valuable. Many Mathlib PRs start as statement-only contributions.
-/

-- Your theorem here:
-- theorem my_research_result : ... := by
--   sorry

-- ============================================================
-- PROJECT 7: Benchmark Contribution
-- ============================================================

/-!
## Contribute to miniF2F or another benchmark.

Steps:
1. Clone github.com/openai/miniF2F
2. Find a problem that is incorrectly formalized
3. Fix the formalization
4. Submit a PR

Or:
1. Find an AMC/AIME/IMO problem not in miniF2F
2. Formalize it
3. Prove it (or prove it's correctly stated)
4. Submit a PR or add it to your portfolio
-/
