import Mathlib.Tactic
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Ring.Basic

/-!
# 08 — Algebra: Groups, Rings, and Fields in Lean

## Mathlib's algebraic hierarchy
Mathlib has a rich hierarchy of algebraic structures.
You don't define "a group" from scratch — you use typeclasses:
  - `Monoid`, `Group`, `CommGroup`
  - `Ring`, `CommRing`, `Field`
  - `Module`, `Algebra`

This file shows you how to work with abstract algebra in Lean.
-/

-- ============================================================
-- SECTION 1: Working with groups
-- ============================================================

-- In Lean, `Group G` means G is a group.
-- The group operation is `*` (multiplicative notation) or `+` (additive notation).

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
