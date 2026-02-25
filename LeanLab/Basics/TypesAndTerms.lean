/-!
# 02 — Types and Terms: The Foundation of Everything

## Core philosophy
In Lean, **everything has a type**. Even types have types.
  - `42 : Nat`           — 42 is a term of type Nat
  - `Nat : Type`         — Nat is a term of type Type
  - `Type : Type 1`      — Type is a term of type Type 1 (universe levels)

Don't worry about universe levels for now. Just know the hierarchy exists.
-/

-- ============================================================
-- SECTION 1: Basic types
-- ============================================================

-- The types you'll use most often
#check Nat           -- Natural numbers: 0, 1, 2, ...
#check Int           -- Integers: ..., -2, -1, 0, 1, 2, ...
#check Float         -- Floating point numbers
#check Bool          -- true or false
#check String        -- Text
#check Char          -- A single character

-- Product types (pairs, tuples)
#check (1, 2)           -- Nat × Nat
#check (1, "hi", true)  -- Nat × String × Bool

-- Function types
#check Nat → Nat         -- A function from Nat to Nat
#check Nat → Nat → Nat   -- A function taking two Nats, returning a Nat
-- Note: → is right-associative, so Nat → Nat → Nat = Nat → (Nat → Nat)
-- This is "currying" — every function technically takes one argument

-- ============================================================
-- SECTION 2: Inductive types (how Lean builds everything)
-- ============================================================

-- Lean's secret weapon: inductive types. Almost everything is built this way.

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

#eval Color.red

-- Pattern matching: THE way to work with inductive types
def colorToString (c : Color) : String :=
  match c with
  | Color.red   => "Red"
  | Color.green => "Green"
  | Color.blue  => "Blue"

#eval colorToString Color.blue  -- "Blue"

-- ============================================================
-- SECTION 3: Option and Sum types (you'll see these everywhere)
-- ============================================================

-- Option: "maybe there's a value, maybe not" (like Maybe in Haskell)
-- inductive Option (α : Type) where
--   | none : Option α
--   | some (val : α) : Option α

def safeDivide (a b : Nat) : Option Nat :=
  if b == 0 then none else some (a / b)

#eval safeDivide 10 3   -- some 3
#eval safeDivide 10 0   -- none

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

#eval p.x          -- 3.0
#eval p.y          -- 4.0

-- A function on points
def distance (p : Point) : Float :=
  Float.sqrt (p.x * p.x + p.y * p.y)

#eval distance p   -- 5.0  (3-4-5 triangle!)

-- ============================================================
-- SECTION 5: Prop vs Type — the big distinction
-- ============================================================

-- In Lean there are two "worlds":
--   - `Type`: computational data (Nat, String, List, ...)
--   - `Prop`: logical propositions (statements that can be true or false)

-- Prop is special: all proofs of the same proposition are considered equal.
-- This is called "proof irrelevance" — HOW you prove something doesn't matter,
-- only THAT you proved it.

#check (2 + 2 = 4)         -- Prop
#check (∀ n : Nat, n + 0 = n)  -- Prop
#check Nat                  -- Type

-- `True` and `False` are propositions (not to be confused with `true`/`false` : Bool)
#check True    -- Prop  (a proposition that is trivially provable)
#check False   -- Prop  (a proposition with no proof — it's absurd)
#check true    -- Bool  (a boolean value, for computation)

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Define an inductive type `Weekday` with all 7 days
-- inductive Weekday where
--   | ...

-- 2. Write a function `isWeekend : Weekday → Bool`

-- 3. Define a structure `Student` with fields `name : String` and `age : Nat`
