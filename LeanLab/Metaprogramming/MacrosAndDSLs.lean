import Lean
import Lean.Elab.Tactic
import Mathlib.Tactic

/-!
# Phase 3B — Macros, Syntax Extensions, and DSLs

## What this covers
- Lean 4's macro system (hygienic macros)
- Custom syntax (notations, commands, tactics)
- Building domain-specific languages (DSLs)
- Practical examples for mathematical proof automation

## Why this matters for the Aristotle program
Lean 4's extensibility is one of its key advantages over other proof assistants.
The ability to define custom syntax and automation means:
- AI agents can define new proof strategies as macros
- Domain-specific tactics can encode expert knowledge
- Custom notations make formalized math more readable
- This extensibility is what makes Lean a viable platform for MSI
-/

open Lean Elab Tactic Meta

-- ============================================================
-- SECTION 1: Simple macros
-- ============================================================

-- Macros are syntax-to-syntax transformations.
-- They run at elaboration time and expand into Lean code.

-- A simple proof macro
macro "qed" : tactic =>
  `(tactic| first
    | rfl
    | simp
    | omega
    | norm_num
    | decide
    | ring
    | trivial
    | assumption)

example : 2 + 3 = 5 := by qed
example (n : Nat) : n + 0 = n := by qed
example (a b : Int) : (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 := by ring

-- ============================================================
-- SECTION 2: Custom notation
-- ============================================================

-- Mathematical notation that Lean doesn't have by default
-- (Mathlib provides many, but here's how you'd add your own)

-- Notation for "divides"
-- (Mathlib already has ∣, but as an example:)
-- notation a " divides " b => a ∣ b

-- Notation for set builder (Mathlib uses { x | P x })
-- This is already built in, but you could customize it

-- Practical: define a shorthand for ∀ x ∈ S, P x patterns
-- These already exist in Mathlib but illustrate the mechanism

-- ============================================================
-- SECTION 3: Custom commands
-- ============================================================

-- You can define entirely new top-level commands

-- A command that checks if a proposition is decidable
elab "#decidable? " t:term : command => do
  let e ← Elab.Command.liftTermElabM do
    let e ← Term.elabTerm t (some (mkSort .zero))
    Term.synthesizeSyntheticMVarsNoPostponing
    return e
  try
    let _ ← Elab.Command.liftTermElabM do
      let inst ← synthInstance (mkApp (mkConst ``Decidable) e)
      return inst
    logInfo m!"{e} is decidable ✓"
  catch _ =>
    logInfo m!"{e} is NOT decidable (or instance not found)"

-- Test it:
-- #decidable? (2 + 2 = 4)        -- decidable ✓
-- #decidable? (∀ n : Nat, n > 0) -- not decidable

-- ============================================================
-- SECTION 4: Building a mini DSL for inequalities
-- ============================================================

/-!
## Example: A "chain inequality" DSL

Mathematicians often write: a ≤ b ≤ c ≤ d
and conclude a ≤ d by transitivity.

Let's build a tactic that automates chained inequality proofs.
-/

-- A tactic that chains linarith calls
macro "chain_ineq" : tactic =>
  `(tactic| (try linarith) <;> (try omega) <;> (try norm_num))

example (a b c : Int) (h1 : a ≤ b) (h2 : b ≤ c) : a ≤ c := by
  chain_ineq

example (a b c d : Int) (h1 : a ≤ b) (h2 : b ≤ c) (h3 : c ≤ d) : a ≤ d := by
  chain_ineq

-- ============================================================
-- SECTION 5: The elaboration pipeline
-- ============================================================

/-!
## How Lean processes your code

1. **Parsing**: Text → Syntax tree (CST)
2. **Macro expansion**: Macros transform syntax → syntax
3. **Elaboration**: Syntax → Expr (the internal representation)
4. **Type checking**: Verify types are correct
5. **Kernel checking**: Independent verification of the proof

This pipeline is important because:
- AI models typically interact at the tactic/elaboration level
- LeanDojo extracts data between steps 2-3
- Pantograph provides an API at the elaboration level
- Custom macros operate at step 2

Understanding this pipeline helps you:
- Debug why a tactic doesn't work
- Build tools that interact with proofs programmatically
- Design custom automation that integrates cleanly
-/

-- ============================================================
-- SECTION 6: Attributes and simp lemmas
-- ============================================================

-- You can tag theorems with attributes to make them usable by tactics

-- @[simp] makes a lemma available to the `simp` tactic
@[simp]
theorem my_custom_simp_lemma (n : Nat) : n + 0 + 0 = n := by omega

-- Now simp knows about this:
example (n : Nat) : n + 0 + 0 = n := by simp

-- This is how Mathlib builds its vast simplification database.
-- When you contribute to Mathlib, choosing the right attributes is crucial.

-- Other important attributes:
-- @[ext]    — for extensionality lemmas
-- @[norm_num] — for numerical normalization
-- @[aesop]  — for the aesop proof search

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Write a macro `contradict` that expands to `exfalso` followed by
--    trying `exact absurd` patterns
-- macro "contradict" : tactic => ...

-- 2. Write a custom command `#type_of` that prints the type of a term
--    (like #check but with a different format)
-- elab "#type_of " t:term : command => ...

-- 3. (Advanced) Write a tactic that automatically applies `Nat.succ_pos`
--    whenever the goal is of the form `0 < Nat.succ n`
