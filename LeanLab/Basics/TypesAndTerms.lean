/-!
# 02 — Types and Terms: The Foundation of Everything

This file builds your understanding of Lean's type system — the backbone
of everything you'll do. If `HelloWorld.lean` was about saying "hello,"
this file is about understanding *the language Lean speaks.*

## Core philosophy
In Lean, **everything has a type**. Even types have types!
  - `42 : Nat`           — 42 is a term of type Nat
  - `Nat : Type`         — Nat itself is a term of type Type
  - `Type : Type 1`      — Type is a term of type Type 1 (universe levels)

Don't worry about universe levels for now. Just know the hierarchy exists.
The important thing is: **every expression in Lean has a type**, and Lean
always knows what it is.

## Learning objectives
After completing this file you will be able to:
  1. Identify and use the basic types: Nat, Int, Bool, String
  2. Understand product types (pairs) and function types (→)
  3. Define your own inductive types and pattern match on them
  4. Use structures (records with named fields)
  5. Explain the difference between `Prop` and `Type`

## Why types matter
Types prevent bugs. In Lean, if your code type-checks, it's *guaranteed*
to be consistent. This is why Lean can serve as a proof checker — same
mechanism, applied to mathematical statements instead of programs.
-/

-- ============================================================
-- SECTION 1: Basic types
-- ============================================================

-- The types you'll use most often
-- #check Nat           -- Natural numbers: 0, 1, 2, ...
-- #check Int           -- Integers: ..., -2, -1, 0, 1, 2, ...
-- #check Float         -- Floating point numbers
-- #check Bool          -- true or false
-- #check String        -- Text
-- #check Char          -- A single character

-- Product types (pairs, tuples)
-- #check (1, 2)           -- Nat × Nat
-- #check (1, "hi", true)  -- Nat × String × Bool

-- Function types
-- #check Nat → Nat         -- A function from Nat to Nat
-- #check Nat → Nat → Nat   -- A function taking two Nats, returning a Nat
-- Note: → is right-associative, so Nat → Nat → Nat = Nat → (Nat → Nat)
-- This is "currying" — every function technically takes one argument

-- ============================================================
-- SECTION 2: Inductive types (how Lean builds everything)
-- ============================================================

-- Lean's secret weapon: inductive types. Almost everything is built this way.
-- Instead of having "built-in" data structures like most languages, Lean
-- lets you BUILD them from scratch using `inductive`. Even `Bool` and `Nat`
-- are defined this way! This means you can define your own types that Lean
-- treats as first-class citizens — including types that represent
-- mathematical concepts.

-- Bool is defined as:
--   inductive Bool where
--     | false : Bool
--     | true : Bool

-- Nat is defined as:
--   inductive Nat where
--     | zero : Nat
--     | succ (n : Nat) : Nat
-- So: 0 = Nat.zero, 1 = Nat.succ Nat.zero, 2 = Nat.succ (Nat.succ Nat.zero)

-- Let's define our own! A simple color type:
inductive Color where
  | red
  | green
  | blue
deriving Repr  -- `deriving Repr` lets us use #eval to print values

-- #eval Color.red

-- Pattern matching: THE way to work with inductive types
def colorToString (c : Color) : String :=
  match c with
  | Color.red   => "Red"
  | Color.green => "Green"
  | Color.blue  => "Blue"

-- #eval colorToString Color.blue  -- "Blue"

-- ============================================================
-- SECTION 3: Option and Sum types (you'll see these everywhere)
-- ============================================================

-- These two types show up constantly in Lean (and in Mathlib).
-- Understanding them now will save you confusion later.

-- Option: "maybe there's a value, maybe not" (like Maybe in Haskell)
-- You'll see this whenever a function might not have an answer
-- (e.g., "what's the head of an empty list?" → `none`).
-- inductive Option (α : Type) where
--   | none : Option α
--   | some (val : α) : Option α

def safeDivide (a b : Nat) : Option Nat :=
  if b == 0 then none else some (a / b)

-- #eval safeDivide 10 3   -- some 3
-- #eval safeDivide 10 0   -- none

-- ============================================================
-- SECTION 4: Structures (product types with named fields)
-- ============================================================

-- Structures are like records/structs in other languages
structure Point where
  x : Float
  y : Float
deriving Repr

def origin : Point := { x := 0.0, y := 0.0 }
def p : Point := { x := 3.0, y := 4.0 }

-- #eval p.x          -- 3.0
-- #eval p.y          -- 4.0

-- A function on points
def distance (p : Point) : Float :=
  Float.sqrt (p.x * p.x + p.y * p.y)

-- #eval distance p   -- 5.0  (3-4-5 triangle!)

-- ============================================================
-- SECTION 5: Prop vs Type — the big distinction
-- ============================================================

-- This is one of the most important conceptual distinctions in Lean.
-- Take a moment to really understand it.
--
-- In Lean there are two "worlds":
--   - `Type`: computational data (Nat, String, List, ...)
--       → Values differ: `42` and `43` are different Nats
--       → You can inspect and compute with them
--
--   - `Prop`: logical propositions (statements that can be true or false)
--       → What matters is WHETHER a proof exists, not what it looks like
--       → Two proofs of the same fact are considered identical
--
-- This is called "proof irrelevance" — HOW you prove something doesn't matter,
-- only THAT you proved it. (Just like in real mathematics: two different proofs
-- of the Pythagorean theorem are both equally valid.)
--
-- 💡 ANALOGY: `Type` is like a library of books (each book is different).
--    `Prop` is like a checklist (each item is either done or not — you don't
--    care which pen you used to check it off).

-- #check (2 + 2 = 4)         -- Prop
-- #check (∀ n : Nat, n + 0 = n)  -- Prop
-- #check Nat                  -- Type

-- `True` and `False` are propositions (not to be confused with `true`/`false` : Bool)
-- #check True    -- Prop  (a proposition that is trivially provable)
-- #check False   -- Prop  (a proposition with no proof — it's absurd)
-- #check true    -- Bool  (a boolean value, for computation)

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- These exercises let you practice what you just learned.
-- Replace the `sorry` placeholders with real implementations.
-- Use the patterns from the Color and Point examples above!

-- 1. Define an inductive type `Weekday` with all 7 days
--    (Model it after the `Color` type above)
inductive Weekday where
  | monday
  | tuesday
  | wednesday
  | thursday
  | friday
  | saturday
  | sunday
deriving Repr

-- 2. Write a function `isWeekend : Weekday → Bool`
--    (Use pattern matching like `colorToString` above)
def isWeekend : Weekday → Bool
  | Weekday.saturday => true
  | Weekday.sunday => true
  | _ => false

-- Verify it works:
-- #eval isWeekend Weekday.saturday  -- true
-- #eval isWeekend Weekday.monday    -- false

-- 3. Define a structure `Student` with fields `name : String` and `age : Nat`
--    (Model it after the `Point` structure above)
structure Student where
  name : String
  age : Nat
deriving Repr

-- #eval ({ name := "Alice", age := 20 } : Student)

-- 💡 TIP: If you're unsure about syntax, look at the examples above
-- and modify them. Experimentation is encouraged!
