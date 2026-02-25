/-!
# 03 — Functions: The Building Blocks

## Key insight for mathematicians
Lean functions ARE mathematical functions.
`def f (x : Nat) : Nat := x + 1` is literally f : ℕ → ℕ, f(x) = x + 1.
The compiler just happens to also be able to *run* them.
-/

-- ============================================================
-- SECTION 1: Function syntax variations
-- ============================================================

-- Explicit style (most readable for beginners)
def square (n : Nat) : Nat := n * n

-- Lambda style
def square' : Nat → Nat := fun n => n * n

-- Pattern matching style
def isZero : Nat → Bool
  | 0     => true
  | _ + 1 => false

-- Multiple arguments
def power (base exp : Nat) : Nat :=
  match exp with
  | 0     => 1
  | n + 1 => base * power base n

#eval power 2 10   -- 1024

-- ============================================================
-- SECTION 2: Recursion
-- ============================================================

-- Lean requires all functions to terminate. It checks this automatically.
-- For simple structural recursion (peeling off `succ`), it just works:

def factorial : Nat → Nat
  | 0     => 1
  | n + 1 => (n + 1) * factorial n

#eval factorial 10   -- 3628800

-- Fibonacci (naive recursive version)
def fib : Nat → Nat
  | 0     => 0
  | 1     => 1
  | n + 2 => fib (n + 1) + fib n

#eval fib 10   -- 55

-- List operations (lists are fundamental in Lean)
def myLength : List Nat → Nat
  | []      => 0
  | _ :: xs => 1 + myLength xs

#eval myLength [1, 2, 3, 4, 5]  -- 5

def mySum : List Nat → Nat
  | []      => 0
  | x :: xs => x + mySum xs

#eval mySum [1, 2, 3, 4, 5]  -- 15

-- ============================================================
-- SECTION 3: Higher-order functions (functions taking functions)
-- ============================================================

-- `List.map` applies a function to every element
#eval [1, 2, 3].map (fun x => x * x)      -- [1, 4, 9]
#eval [1, 2, 3].map (· * 2)                -- [2, 4, 6]  (· is shorthand)

-- `List.filter` keeps elements satisfying a predicate
#eval [1, 2, 3, 4, 5].filter (· > 3)      -- [4, 5]

-- `List.foldl` accumulates a result (like reduce)
#eval [1, 2, 3, 4].foldl (· + ·) 0        -- 10

-- Writing your own higher-order function
def applyTwice (f : Nat → Nat) (x : Nat) : Nat := f (f x)

#eval applyTwice (· + 1) 0    -- 2
#eval applyTwice (· * 2) 3    -- 12

-- ============================================================
-- SECTION 4: Implicit arguments (very important in Lean!)
-- ============================================================

-- Sometimes Lean can figure out arguments from context.
-- Use curly braces {} for implicit arguments:

-- This works for ANY type, not just Nat:
def myId {α : Type} (x : α) : α := x

#eval myId 42          -- Lean infers α = Nat
#eval myId "hello"     -- Lean infers α = String

-- You can make the implicit explicit with @:
#eval @myId Nat 42     -- Explicitly passing the type

-- Most Mathlib functions use implicit arguments heavily.
-- When you see {α : Type} in a signature, it means "Lean figures this out".

-- ============================================================
-- SECTION 5: Local definitions with `let` and `where`
-- ============================================================

def hypotenuse (a b : Float) : Float :=
  let a2 := a * a
  let b2 := b * b
  Float.sqrt (a2 + b2)

#eval hypotenuse 3.0 4.0  -- 5.0

-- `where` puts definitions after the main expression (sometimes more readable)
def circleArea (r : Float) : Float :=
  pi * r * r
  where pi := 3.14159265

#eval circleArea 1.0  -- 3.14159265

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Write a function `sumUpTo : Nat → Nat` that computes 0 + 1 + ... + n
def sumUpTo : Nat → Nat := sorry

-- 2. Write a function that reverses a list (hint: use an accumulator)
def myReverse : List Nat → List Nat := sorry

-- 3. Write `compose` that takes two functions and composes them
-- def compose ... := sorry
