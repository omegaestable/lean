import Mathlib.Tactic
import Mathlib.Data.Nat.Basic
import Mathlib.Data.List.Basic
import Mathlib.Algebra.Ring.Basic

/-!
# Phase 2A — Searching Mathlib: Finding What You Need

## Why this matters
Mathlib has over 200,000 lemmas. Nobody memorizes them.
The skill isn't knowing every lemma — it's knowing HOW TO FIND the right one.
This is also exactly what AI models need to do (premise selection).

## Tools covered
- `exact?`, `apply?`, `rw?`, `simp?` — interactive search from inside proofs
- Naming conventions — predict lemma names from their statements
- Loogle — type-based search engine for Mathlib
- Moogle / LeanSearch — natural language search
-/

-- ============================================================
-- SECTION 1: In-proof search tactics
-- ============================================================

-- `exact?` — "Is there a single lemma that closes this goal?"
-- Place your cursor after `exact?` and look at the Infoview suggestions.

example (n : Nat) : n + 0 = n := by
  exact?   -- will suggest: `exact Nat.add_zero n` or `exact add_zero n`

example (a b : Nat) : a + b = b + a := by
  exact?   -- will suggest: `exact Nat.add_comm a b`

-- `apply?` — "What lemma can I apply here?"
-- Useful when the goal needs an intermediate step.

example (a b c : Nat) (h1 : a ≤ b) (h2 : b ≤ c) : a ≤ c := by
  apply?   -- will suggest: `exact le_trans h1 h2`

-- `rw?` — "What can I rewrite with?"
example (a b c : Nat) : a + b + c = a + (b + c) := by
  rw?      -- will suggest: `rw [Nat.add_assoc]`

-- `simp?` — "What lemmas did simp use?" (shows reproducible call)
example (xs : List Nat) : (xs ++ []).length = xs.length := by
  simp?    -- shows: `simp only [List.append_nil]`

-- ============================================================
-- SECTION 2: Mathlib naming conventions
-- ============================================================

/-!
Mathlib follows predictable naming patterns. Learn them and you can
often GUESS the name of a lemma before searching.

## Pattern: `[Type].[operation]_[property]`
- `Nat.add_comm`       — commutativity of addition on Nat
- `Nat.mul_assoc`      — associativity of multiplication on Nat
- `List.length_append` — length distributes over append
- `Int.add_neg_cancel` — a + (-a) = 0

## Pattern: `[property]_[operation]`
- `add_comm`           — generic commutativity (works in any AddCommMonoid)
- `mul_one`            — a * 1 = a (in any Monoid)
- `zero_add`           — 0 + a = a

## Common property words
- `comm`  — commutativity
- `assoc` — associativity
- `zero`, `one` — identity elements
- `neg`, `inv` — inverses
- `le`, `lt` — ordering
- `dvd` — divisibility
- `succ`, `pred` — successor/predecessor
- `left`, `right` — which side
- `cancel` — cancellation

## Prefixes
- `is_` / `Is` — boolean/Prop predicates
- `not_` — negation
- `ne_` — not equal

## Try guessing!
If you want "a * (b + c) = a * b + a * c", try:
  `mul_add` or `left_distrib` — and you'd be right!
-/

-- Verify some naming conventions:
#check Nat.add_comm       -- a + b = b + a
#check Nat.add_assoc      -- (a + b) + c = a + (b + c)
#check Nat.mul_comm       -- a * b = b * a
#check mul_one             -- a * 1 = a
#check one_mul             -- 1 * a = a
#check add_zero            -- a + 0 = a
#check zero_add            -- 0 + a = a
#check mul_add             -- a * (b + c) = a * b + a * c

-- ============================================================
-- SECTION 3: External search tools
-- ============================================================

/-!
## Loogle (Type-based search)
URL: https://loogle.lean-lang.org/

Search by type signature. Examples:
- `Nat → Nat → Nat` finds functions like add, mul
- `_ + _ = _ + _` finds commutativity lemmas
- `List.length (_ ++ _)` finds length_append

This is the closest tool to what AI premise selection does!

## Moogle / LeanSearch (Natural language search)
URL: https://www.moogle.ai/

Search in plain English. Examples:
- "commutativity of addition" → finds `add_comm`
- "triangle inequality" → finds `abs_add`
- "every natural number is zero or a successor"

## Mathlib docs (browseable API)
URL: https://leanprover-community.github.io/mathlib4_docs/

Browseable documentation for every definition and theorem in Mathlib.

## LeanExplore
A newer semantic search tool for Mathlib declarations.
-/

-- ============================================================
-- SECTION 4: Practice — find the right lemma
-- ============================================================

-- For each of these, first try to GUESS the lemma name,
-- then use `exact?` to verify.

-- 1. Multiplication is commutative
example (a b : Nat) : a * b = b * a := by
  sorry  -- hint: what would Mathlib call this?

-- 2. Adding zero on the right
example (n : Nat) : n + 0 = n := by
  sorry  -- hint: [operation]_[identity element]

-- 3. Distributivity
example (a b c : Int) : a * (b + c) = a * b + a * c := by
  sorry  -- hint: mul_add

-- 4. List reverse reverse
example (xs : List Nat) : xs.reverse.reverse = xs := by
  sorry  -- hint: List.reverse_reverse

-- 5. Transitivity of ≤
example (a b c : Nat) (h1 : a ≤ b) (h2 : b ≤ c) : a ≤ c := by
  sorry  -- hint: le_trans
