/-!
# 01 — Hello World: Your First Steps in Lean 4

Welcome! This is your very first Lean file. By the end of it, you will have
written your first function and proved your first theorem. Let's go!

## What is Lean?
Lean 4 is both a **programming language** and a **proof assistant**.
Think of it as: Haskell meets Coq. You can write programs AND prove theorems,
all in the same language.

## Key idea — the Curry-Howard correspondence
In Lean, **propositions are types** and **proofs are terms**.
  - The statement "2 + 2 = 4" is a *type* (specifically, a `Prop`).
  - A proof of that statement is a *term* inhabiting that type.
  - Writing a proof is the same as constructing a value of the right type.
You'll internalize this naturally as you work through the files. Don't worry
if it sounds abstract right now — the examples below will make it concrete.

## Learning objectives
After completing this file you will be able to:
  1. Use `#check` to ask Lean about types
  2. Use `#eval` to compute expressions
  3. Define constants and simple functions with `def`
  4. State and prove simple theorems using `rfl`
  5. Understand the difference between `theorem` and `example`

## How to read this file
- **Work top to bottom** — each section builds on the previous one
- **Move your cursor** through the code and watch the Lean Infoview panel
  (right side of VS Code). It updates in real time!
- **Experiment!** Change numbers, break things, see what happens
- Lines with `sorry` are exercises — replace them with real proofs
-/

-- ============================================================
-- SECTION 1: Basic commands you'll use constantly
-- ============================================================

-- These three commands (#check, #eval, #print) are your exploration tools.
-- Think of them as "asking Lean questions." You'll use them constantly
-- while learning, and even experts use them every day.

-- `#check` asks Lean: "What is the type of this expression?"
-- 💡 TIP: Place your cursor on each #check line and look at the Infoview.
#check 42              -- 42 : Nat
#check "hello"         -- "hello" : String
#check true            -- true : Bool
#check (1, "hi")       -- (1, "hi") : Nat × String

-- `#eval` asks Lean: "Compute this expression and show me the result"
-- Unlike #check (which shows the TYPE), #eval shows the VALUE.
#eval 2 + 3            -- 5
#eval "Hello" ++ " " ++ "World"   -- "Hello World"
#eval (10 : Int) - 20  -- -10  (note: Nat subtraction truncates at 0!)
#eval (10 : Nat) - 20  -- 0    (see? Nat can't go negative)
-- ⚠️  GOTCHA: Natural number subtraction never goes below zero!
-- This is a common source of bugs. If you need negative results, use Int.

-- `#print` shows the full definition of something
#print Nat             -- an inductive type with zero and succ
#print Nat.add         -- how addition is defined recursively

-- ============================================================
-- SECTION 2: Defining things
-- ============================================================

-- `def` introduces a definition (like `let` in other languages)
def myNumber : Nat := 42
def myString : String := "Lean is cool"

-- Lean can usually infer the type (but being explicit is good practice)
def inferredNumber := 42   -- Lean figures out it's a Nat

-- You can evaluate your definitions
#eval myNumber         -- 42
#check myNumber        -- myNumber : Nat

-- ============================================================
-- SECTION 3: Your first function
-- ============================================================

-- Functions are defined with `def` too
def double (n : Nat) : Nat := 2 * n

#eval double 5         -- 10
#eval double (double 3) -- 12

-- Multiple arguments
def add (a b : Nat) : Nat := a + b

#eval add 3 4          -- 7

-- Anonymous functions (lambdas) — just like math notation
#eval (fun x => x + 1) 5    -- 6
#check (fun x => x + 1)     -- Nat → Nat  (Lean infers the type)

-- ============================================================
-- SECTION 4: Your first theorem
-- ============================================================

-- 🎉 Here it is. Your first proof!
--
-- `theorem` is like `def`, but for propositions (things that are true/false).
-- Where `def` creates a value, `theorem` creates a proof.
--
-- `rfl` stands for "reflexivity" — it means "both sides are *definitionally*
-- equal." Lean unfolds the definitions, computes, and checks that the two
-- sides reduce to the same thing. If they do, the proof is done.
--
-- Put your cursor on `rfl` below and look at the Infoview. You should see:
--   "No goals" — meaning the proof is complete!

theorem two_plus_two : 2 + 2 = 4 := by rfl

-- That's it. You just proved something. The `by` keyword enters "tactic mode"
-- and `rfl` is a tactic that checks both sides reduce to the same thing.

-- You can also write it in "term mode" (without `by`):
theorem two_plus_two' : 2 + 2 = 4 := rfl

-- A slightly more interesting one:
theorem add_zero_demo (n : Nat) : n + 0 = n := by rfl

-- ============================================================
-- SECTION 5: The `example` keyword
-- ============================================================

-- `example` is like `theorem` but anonymous — great for practice
example : 1 + 1 = 2 := by rfl
example : "Hello " ++ "World" = "Hello World" := by rfl

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- Now it's your turn! Replace each `sorry` with an actual proof.
-- For all of these, `rfl` will work — Lean can compute both sides
-- and verify they're the same.
--
-- When you replace `sorry` with `rfl`, the yellow warning squiggle
-- should disappear. That means your proof is accepted!
--
-- 💡 TIP: If you get stuck on any exercise in this repo, try:
--   1. `rfl` (are both sides definitionally equal?)
--   2. `simp` (can Lean simplify this automatically?)
--   3. `omega` (is this arithmetic?)
--   4. `exact?` (ask Lean to search for a proof!)

example : 3 + 3 = 6 := by sorry

example : 10 * 2 = 20 := by sorry

example : "Lean" ++ "4" = "Lean4" := by sorry
