/-!
# 01 — Hello World: Your First Steps in Lean 4

## What is Lean?
Lean is both a **programming language** and a **proof assistant**.
Think of it as: Haskell meets Coq. You can write programs AND prove theorems.

## Key idea
In Lean, **propositions are types** and **proofs are terms**.
  - The statement "2 + 2 = 4" is a *type*.
  - A proof of that statement is a *term* inhabiting that type.
This is the Curry-Howard correspondence — you'll internalize it naturally.

## How to read this file
- Work top to bottom
- Hover over things in VS Code to see their types
- Use `#check` and `#eval` liberally — they're your best friends
- Comments with `sorry` are exercises for you to fill in
-/

-- ============================================================
-- SECTION 1: Basic commands you'll use constantly
-- ============================================================

-- `#check` asks Lean: "What is the type of this expression?"
#check 42              -- 42 : Nat
#check "hello"         -- "hello" : String
#check true            -- true : Bool
#check (1, "hi")       -- (1, "hi") : Nat × String

-- `#eval` asks Lean: "Compute this expression and show me the result"
#eval 2 + 3            -- 5
#eval "Hello" ++ " " ++ "World"   -- "Hello World"
#eval (10 : Int) - 20  -- -10  (note: Nat subtraction truncates at 0!)
#eval (10 : Nat) - 20  -- 0    (see? Nat can't go negative)

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

-- Here it is. Your first proof.
-- `theorem` is like `def`, but for propositions.
-- `rfl` means "both sides are definitionally equal" (reflexivity).

theorem two_plus_two : 2 + 2 = 4 := by rfl

-- That's it. You just proved something. The `by` keyword enters "tactic mode"
-- and `rfl` is a tactic that checks both sides reduce to the same thing.

-- You can also write it in "term mode" (without `by`):
theorem two_plus_two' : 2 + 2 = 4 := rfl

-- A slightly more interesting one:
theorem add_zero (n : Nat) : n + 0 = n := by rfl

-- ============================================================
-- SECTION 5: The `example` keyword
-- ============================================================

-- `example` is like `theorem` but anonymous — great for practice
example : 1 + 1 = 2 := by rfl
example : "Hello " ++ "World" = "Hello World" := by rfl

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- Replace `sorry` with an actual proof (hint: `rfl` works for all of these)

example : 3 + 3 = 6 := by sorry

example : 10 * 2 = 20 := by sorry

example : "Lean" ++ "4" = "Lean4" := by sorry
