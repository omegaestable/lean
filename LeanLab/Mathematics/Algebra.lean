import Mathlib.Tactic
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Ring.Basic

/-!
# 08 — Algebra: Groups, Rings, and Fields in Lean

This is where Lean starts to feel like a real math textbook.
You'll work with the same abstract structures you studied in algebra
class — groups, rings, fields — but now Lean ensures every step
of your reasoning is correct.

## Mathlib's algebraic hierarchy
Mathlib has a rich hierarchy of algebraic structures.
You don't define "a group" from scratch — you use **typeclasses**:
  - `Monoid`, `Group`, `CommGroup`
  - `Ring`, `CommRing`, `Field`
  - `Module`, `Algebra`

When you write `[CommRing R]`, Lean automatically knows R is also
a Ring, an AddCommGroup, a Monoid, etc. — the whole hierarchy
is inferred for you.

## Learning objectives
After this file you will be able to:
  1. State and prove facts about abstract groups
  2. Use the `ring` tactic for polynomial identities
  3. Use `linarith` and `positivity` for inequalities
  4. Understand how Lean's typeclasses encode the algebraic hierarchy
  5. Prove things about concrete types (ℤ, ℚ) using abstract lemmas

## The power of abstraction
When you prove `(a + b)² = a² + 2ab + b²` for a CommRing,
that single proof works for ℤ, ℚ, ℝ, ℂ, polynomials, matrices,
and any future type that someone makes into a CommRing.
This is the payoff of abstract algebra — prove once, use everywhere.
-/

-- ============================================================
-- SECTION 1: Working with groups
-- ============================================================

-- In Lean, `Group G` means G is a group (with multiplicative notation).
-- The group operation is `*`, identity is `1`, and inverses are `⁻¹`.
--
-- For additive groups, use `AddGroup G` — then `+`, `0`, and `-` are used.
--
-- 💡 TIP: Most Mathlib lemmas exist in both multiplicative and additive
-- versions. If you can't find `add_comm`, try searching for `mul_comm`.
--
-- Lean knows all the group axioms as named lemmas. You'll use them
-- like building blocks:

-- Lean knows group axioms as lemmas:
-- `mul_assoc`   : a * b * c = a * (b * c)
-- `one_mul`     : 1 * a = a
-- `mul_one`     : a * 1 = a
-- `inv_mul_cancel` : a⁻¹ * a = 1

-- Let's prove things about abstract groups:
variable {G : Type*} [Group G]

-- The identity is unique (a consequence of the axioms)
example (a : G) : a * 1 = a := by
  exact mul_one a

-- Inverse is involutive: (a⁻¹)⁻¹ = a
example (a : G) : (a⁻¹)⁻¹ = a := by
  exact inv_inv a

-- Inverse of a product: (a * b)⁻¹ = b⁻¹ * a⁻¹
example (a b : G) : (a * b)⁻¹ = b⁻¹ * a⁻¹ := by
  exact mul_inv_rev a b

-- If ab = ac then b = c (left cancellation)
example (a b c : G) (h : a * b = a * c) : b = c := by
  exact mul_left_cancel h

-- ============================================================
-- SECTION 2: Working with rings
-- ============================================================

variable {R : Type*} [CommRing R]

-- The `ring` tactic is your best friend for ring equalities
example (a b : R) : (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 := by
  ring

example (a b : R) : (a + b) * (a - b) = a ^ 2 - b ^ 2 := by
  ring

example (a b c : R) : a * (b + c) = a * b + a * c := by
  ring

-- Something ring can't do — you need actual reasoning:
example (a b : R) (h : a = b) : a ^ 2 = b ^ 2 := by
  rw [h]

-- Proving things about specific rings
example : (3 : ℤ) ^ 2 + (4 : ℤ) ^ 2 = (5 : ℤ) ^ 2 := by
  norm_num

-- ============================================================
-- SECTION 3: Ordered fields and inequalities
-- ============================================================

-- Working with ℚ (or any ordered field)
-- Note: We use concrete types here for simplicity.

-- The `linarith` tactic handles linear arithmetic over ordered fields
example (a b : ℚ) (ha : a > 0) (hb : b > 0) : a + b > 0 := by
  linarith

example (a b : ℚ) (h : a ≤ b) : 2 * a ≤ 2 * b := by
  linarith

-- Positivity tactic — proves things are positive/nonneg
example (a : ℚ) : a ^ 2 ≥ 0 := by
  positivity

example (a b : ℚ) : a ^ 2 + b ^ 2 ≥ 0 := by
  positivity

-- ============================================================
-- SECTION 4: Subgroups (a taste of more advanced algebra)
-- ============================================================

-- Subgroups in Mathlib are predicates on the carrier set
-- bundled with closure proofs.

-- Note: Subgroup examples require additional Mathlib imports.
-- See Mathlib.GroupTheory.Subgroup.Basic for details.
-- For now, here's a simpler group theory example:

variable {G : Type*} [Group G]

example (a b : G) : a * b * b⁻¹ = a := by
  group

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Prove this ring identity
example (a b c : ℤ) : (a + b + c) ^ 2 = a^2 + b^2 + c^2 + 2*a*b + 2*b*c + 2*a*c := by
  sorry

-- 2. Prove this inequality
example (x : ℚ) (h : x ≥ 3) : 2 * x ≥ 6 := by
  sorry

-- 3. Left-multiply both sides of an equation
-- (hint: use `calc` or `congr` or just `group` tactic)
example (a b c : G) (h : a = b) : c * a = c * b := by
  sorry
