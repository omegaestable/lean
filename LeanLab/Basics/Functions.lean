/-!
# 03 — Functions: The Building Blocks

Functions are the heart of Lean. Every definition, every proof, every
computation — they all come down to functions. If you understand
functions in Lean, you understand 80% of the language.

## Key insight for mathematicians
Lean functions ARE mathematical functions.
`def f (x : Nat) : Nat := x + 1` is literally f : ℕ → ℕ, f(x) = x + 1.
The compiler just happens to also be able to *run* them.

## Key insight for programmers
If you know Haskell, OCaml, or F# — you already know most of this.
If you come from Python or JavaScript, the main new ideas are:
  - Functions must have **explicit types** (or Lean infers them)
  - All functions are **pure** (no side effects, no mutation)
  - All recursion must **terminate** (Lean checks this for you)

## Learning objectives
After completing this file you will be able to:
  1. Define functions using multiple syntax styles
  2. Write recursive functions with pattern matching
  3. Use higher-order functions (map, filter, fold)
  4. Understand implicit arguments `{α : Type}`
  5. Use `let` and `where` for local definitions
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

-- ⚠️ IMPORTANT: Lean requires ALL functions to terminate.
-- Unlike most programming languages, you can't write an infinite loop.
-- Lean verifies termination automatically by checking that recursive calls
-- are made on "smaller" arguments (structural recursion).
--
-- Why? Because Lean is also a proof assistant. If you could write
-- non-terminating functions, you could "prove" False and break everything.
-- This is a feature, not a bug!
--
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

-- This section is CRUCIAL for reading Mathlib code. If you've ever
-- looked at a Mathlib signature and been confused by {curly braces},
-- this is where you learn what they mean.
--
-- Sometimes Lean can figure out arguments from context. Rather than
-- making you spell out every type explicitly, Lean lets you mark
-- arguments as "implicit" using curly braces {}.
--
-- When you call the function, Lean fills in implicit arguments
-- automatically. You almost never need to provide them yourself.

-- Example: This identity function works for ANY type, not just Nat:
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

-- Replace `sorry` with real implementations. Test them with #eval!

-- 1. Write a function `sumUpTo : Nat → Nat` that computes 0 + 1 + ... + n
--    Example: sumUpTo 5 = 0 + 1 + 2 + 3 + 4 + 5 = 15
--    Hint: use pattern matching with | 0 => ... | n + 1 => ...
def sumUpTo : Nat → Nat := sorry
-- #eval sumUpTo 5    -- should be 15
-- #eval sumUpTo 100  -- should be 5050 (Gauss would be proud!)

-- 2. Write a function that reverses a list
--    Hint: use an accumulator pattern — define a helper function
--    `go (acc : List Nat) : List Nat → List Nat` that prepends each
--    element onto the accumulator.
def myReverse : List Nat → List Nat := sorry
-- #eval myReverse [1, 2, 3, 4]  -- should be [4, 3, 2, 1]

-- 3. Write `compose` that takes two functions and composes them
--    compose f g x = f (g x)
--    Hint: the type signature is (β → γ) → (α → β) → α → γ
-- def compose {α β γ : Type} (f : β → γ) (g : α → β) (x : α) : γ := sorry
-- #eval compose (· + 1) (· * 2) 5  -- should be 11 (5*2 + 1)

-- 💡 TIP: When defining recursive functions, make sure the recursive call
--    is on a "smaller" argument. For Nat, that means calling f n when
--    you're handling the case n + 1. For List, that means calling f xs
--    when you're handling x :: xs.
