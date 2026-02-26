/-!
# 04 — Propositional Logic: Proofs as Programs

This is where Lean gets exciting. You're about to see that **proving a
theorem** and **writing a program** are literally the same activity.

Every logical connective (and, or, implies, not) corresponds to a
programming concept. Once you see this table, proofs in Lean "click":

## The Curry-Howard correspondence in action
| Logic              | Programming        | Lean          |
|--------------------|--------------------|---------------|
| Proposition        | Type               | `Prop`        |
| Proof              | Term/Program       | `term : Prop` |
| Implication P → Q  | Function P → Q     | `fun h => ..` |
| Conjunction P ∧ Q  | Product P × Q      | `⟨hp, hq⟩`   |
| Disjunction P ∨ Q  | Sum P ⊕ Q          | `.inl` / `.inr`|
| True               | Unit               | `trivial`     |
| False              | Empty              | impossible    |

## Learning objectives
After this file you will be able to:
  1. Prove implications using `intro` and `exact`
  2. Prove and use conjunctions with `constructor` and `obtain`
  3. Prove and use disjunctions with `left`/`right` and `cases`
  4. Work with negation (¬P = P → False)
  5. Prove biconditionals (↔) by splitting into both directions

## How to work through proofs
For EVERY proof below, do this:
  1. Read the theorem statement — what is it claiming?
  2. Put your cursor on the first tactic — what does the Infoview show?
  3. Move your cursor line by line — watch the goal change
  4. Try to predict what each tactic will do BEFORE you look at the Infoview
This active reading is how you build proof intuition.
-/

-- ============================================================
-- SECTION 1: Implication (→) = Functions
-- ============================================================

-- 💡 MENTAL MODEL: An implication P → Q is a PROMISE.
-- "If you give me a proof of P, I will give you back a proof of Q."
-- In programming terms, it's a function from P to Q.
--
-- To PROVE P → Q: use `intro` to receive the proof of P, then construct Q.
-- To USE  h : P → Q: use `apply h` to reduce the goal from Q to P.

-- Proving P → Q is the same as writing a function from P to Q.
-- "Given a proof of P, I produce a proof of Q."

-- Term-mode proof: literally a function
theorem imp_self_demo (P : Prop) : P → P :=
  fun hp => hp         -- Given a proof of P, return it

-- Tactic-mode proof: step-by-step
theorem imp_self' (P : Prop) : P → P := by
  intro hp             -- "assume P" — introduces hypothesis `hp : P`
  exact hp             -- "this is our proof" — provides the exact term

-- Transitivity of implication
theorem imp_trans (P Q R : Prop) : (P → Q) → (Q → R) → P → R := by
  intro hpq hqr hp    -- assume all three hypotheses
  apply hqr            -- suffices to show Q (because hqr : Q → R)
  apply hpq            -- suffices to show P (because hpq : P → Q)
  exact hp             -- we have P

-- ============================================================
-- SECTION 2: Conjunction (∧) = Pairs
-- ============================================================

-- 💡 MENTAL MODEL: A conjunction P ∧ Q is a BUNDLE — a pair containing
-- a proof of P and a proof of Q.
--
-- To PROVE P ∧ Q: use `constructor` to split into two goals, prove each.
-- To USE  h : P ∧ Q: use `obtain ⟨hp, hq⟩ := h` to unpack the pair.
--
-- The angle brackets ⟨ ⟩ are typed with \langle and \rangle (or \ang).

-- To prove P ∧ Q, you need a proof of P AND a proof of Q.
-- It's literally a pair.

theorem and_intro (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor          -- splits goal into two: ⊢ P and ⊢ Q
  · exact hp           -- prove the first part
  · exact hq           -- prove the second part

-- Alternative: use the anonymous constructor ⟨ ⟩
theorem and_intro' (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q :=
  ⟨hp, hq⟩

-- Extracting from a conjunction
theorem and_left (P Q : Prop) (h : P ∧ Q) : P := by
  obtain ⟨hp, _hq⟩ := h   -- destructure the pair
  exact hp

theorem and_comm_demo (P Q : Prop) : P ∧ Q → Q ∧ P := by
  intro ⟨hp, hq⟩     -- destructure in the intro
  exact ⟨hq, hp⟩     -- rebuild swapped

-- ============================================================
-- SECTION 3: Disjunction (∨) = Either/Or
-- ============================================================

-- 💡 MENTAL MODEL: A disjunction P ∨ Q is a CHOICE — you must pick
-- one side and prove that side.
--
-- To PROVE P ∨ Q: use `left` (then prove P) or `right` (then prove Q).
-- To USE  h : P ∨ Q: use `cases h` to handle both possibilities.

-- To prove P ∨ Q, you need to choose a side and prove it.

theorem or_left (P Q : Prop) (hp : P) : P ∨ Q := by
  left                 -- "I'll prove the left side"
  exact hp

theorem or_right (P Q : Prop) (hq : Q) : P ∨ Q := by
  right                -- "I'll prove the right side"
  exact hq

-- Using a disjunction: case analysis
theorem or_comm_demo (P Q : Prop) : P ∨ Q → Q ∨ P := by
  intro h
  cases h with         -- "consider both cases"
  | inl hp => right; exact hp   -- if we had P, put it on the right
  | inr hq => left; exact hq    -- if we had Q, put it on the left

-- ============================================================
-- SECTION 4: Negation (¬) = leads to contradiction
-- ============================================================

-- 💡 MENTAL MODEL: Negation ¬P is just a SPECIAL FUNCTION: P → False.
-- It says: "Give me a proof of P, and I'll derive absurdity."
--
-- To PROVE ¬P: use `intro hp` (assume P), then derive `False`.
-- To USE  h : ¬P: use `apply h` when the goal is `False`, or
--   use `exact h hp` when you have both h : ¬P and hp : P.
--
-- False is a proposition with NO proof. If your goal becomes False,
-- you need a contradiction in your hypotheses to close it.

-- ¬P is DEFINED as P → False.
-- "If you give me a proof of P, I can derive a contradiction."

-- #print Not  -- fun (a : Prop) => a → False

theorem not_false_demo : ¬False := by
  intro h              -- assume False
  exact h              -- False proves anything (we're done!)

-- Modus tollens: if P → Q and ¬Q, then ¬P
theorem modus_tollens (P Q : Prop) : (P → Q) → ¬Q → ¬P := by
  intro hpq hnq hp    -- assume all three
  apply hnq            -- suffices to show Q (to contradict ¬Q)
  apply hpq            -- suffices to show P
  exact hp             -- we have P

-- ============================================================
-- SECTION 5: Iff (↔) = logical equivalence
-- ============================================================

-- P ↔ Q means (P → Q) ∧ (Q → P)

theorem iff_self_demo (P : Prop) : P ↔ P := by
  constructor          -- split into → and ←
  · intro hp; exact hp
  · intro hp; exact hp

-- Shorter:
theorem iff_self' (P : Prop) : P ↔ P :=
  ⟨fun hp => hp, fun hp => hp⟩

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Prove that ∧ is associative
theorem and_assoc_demo (P Q R : Prop) : (P ∧ Q) ∧ R ↔ P ∧ (Q ∧ R) := by
  sorry

-- 2. Prove one of De Morgan's laws
theorem de_morgan (P Q : Prop) : ¬(P ∨ Q) → ¬P ∧ ¬Q := by
  sorry

-- 3. Prove: if P → Q and P → R then P → Q ∧ R
theorem imp_and_demo (P Q R : Prop) : (P → Q) → (P → R) → P → Q ∧ R := by
  sorry
