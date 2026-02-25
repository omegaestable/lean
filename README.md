# Lean Lab

**A hands-on learning repository for Lean 4 and mathematical proof formalization.**

Built for mathematicians and programmers who have zero Lean experience but want to learn theorem proving. Work through the files in order, fill in the `sorry`s, and build intuition one proof at a time.

---

## What is Lean?

[Lean 4](https://lean-lang.org/) is both a **programming language** and a **proof assistant**. It lets you:

- Write programs that the compiler can execute
- State mathematical theorems and construct machine-checked proofs
- Formalize entire branches of mathematics (via [Mathlib](https://leanprover-community.github.io/mathlib4_docs/))

The key insight: **propositions are types, proofs are programs** (the [Curry-Howard correspondence](https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence)). When you prove `P → Q`, you're literally writing a function that takes a proof of `P` and returns a proof of `Q`.

---

## Getting Started

### 1. Install Lean 4

Follow the official instructions: **[https://lean-lang.org/lean4/doc/setup.html](https://lean-lang.org/lean4/doc/setup.html)**

On most systems:
```bash
# Install elan (the Lean version manager)
curl https://elan.lean-lang.org/install.sh -sSf | sh
```

On Windows, download the installer from the link above.

### 2. Install VS Code + Lean Extension

- Install [VS Code](https://code.visualstudio.com/)
- Install the **lean4** extension (search "lean4" in extensions)
- The extension provides: syntax highlighting, type info on hover, goal view, error checking

### 3. Build this project

```bash
git clone <this-repo-url>
cd lean
lake update    # download Mathlib (this takes a while the first time!)
lake build     # build the project
```

> **Note:** The first `lake update` downloads Mathlib, which is large (~3 GB of compiled artifacts). This is normal. Subsequent builds are fast.

### 4. Open in VS Code

```bash
code .
```

Open any `.lean` file. The **Lean Infoview** panel (right side) shows you:
- The current proof state (goals + hypotheses)
- Type information on hover
- Errors and warnings

**This panel is your most important tool.** Put your cursor on different lines to see how the proof state changes.

---

## Repository Structure

```
LeanLab/
├── Basics/                   ← Start here!
│   ├── HelloWorld.lean          01 — #check, #eval, first theorems
│   ├── TypesAndTerms.lean       02 — Types, inductive types, Prop vs Type
│   └── Functions.lean           03 — Functions, recursion, higher-order
│
├── Logic/                    ← Core proof skills
│   ├── PropositionalLogic.lean  04 — ∧, ∨, →, ¬, ↔ and their proofs
│   ├── Quantifiers.lean         05 — ∀, ∃, equality, classical logic
│   └── Tactics.lean             06 — Full tactic reference and practice
│
├── Mathematics/              ← Real math in Lean
│   ├── NaturalNumbers.lean      07 — Induction, divisibility, modular arithmetic
│   ├── Algebra.lean             08 — Groups, rings, fields with Mathlib
│   └── Analysis.lean            09 — Sequences, metric spaces, ε-δ proofs
│
├── Exercises/                ← Test yourself
│   ├── Level1_Basics.lean       ⭐ Functions and simple proofs
│   ├── Level2_Logic.lean        ⭐⭐ Propositional and predicate logic
│   └── Level3_Math.lean         ⭐⭐⭐ Number theory, algebra, analysis
│
└── Sandbox.lean              ← Your playground — experiment freely!
```

---

## Learning Roadmap

### Phase 1: Foundations (Week 1-2)
- [ ] Work through `Basics/HelloWorld.lean` — get comfortable with `#check` and `#eval`
- [ ] Work through `Basics/TypesAndTerms.lean` — understand the type system
- [ ] Work through `Basics/Functions.lean` — write recursive functions
- [ ] Complete `Exercises/Level1_Basics.lean`
- [ ] Play in `Sandbox.lean` — break things, experiment

### Phase 2: Proving Things (Week 2-4)
- [ ] Work through `Logic/PropositionalLogic.lean` — learn intro/exact/apply/constructor/cases
- [ ] Work through `Logic/Quantifiers.lean` — master ∀, ∃, rewrite, calc
- [ ] Work through `Logic/Tactics.lean` — build your tactic toolbox
- [ ] Complete `Exercises/Level2_Logic.lean`
- [ ] Start reading the [Theorem Proving in Lean 4](https://lean-lang.org/theorem_proving_in_lean4/) book

### Phase 3: Real Mathematics (Week 4-8)
- [ ] Work through `Mathematics/NaturalNumbers.lean` — induction and number theory
- [ ] Work through `Mathematics/Algebra.lean` — abstract algebra with Mathlib
- [ ] Work through `Mathematics/Analysis.lean` — epsilon-delta proofs
- [ ] Complete `Exercises/Level3_Math.lean`
- [ ] Try formalizing a theorem from your own research area

### Phase 4: Independence (Ongoing)
- [ ] Contribute to [Mathlib](https://leanprover-community.github.io/contribute/)
- [ ] Formalize results from your papers
- [ ] Join the [Lean Zulip chat](https://leanprover.zulipchat.com/) community
- [ ] Tackle problems from the [Formal Abstracts](https://formalabstracts.github.io/) project

---

## Essential Commands

| Command | What it does |
|---------|-------------|
| `#check expr` | Show the type of an expression |
| `#eval expr` | Evaluate/compute an expression |
| `#print name` | Show the definition of a name |
| `exact?` | Search for a lemma that closes the goal |
| `apply?` | Search for a lemma to apply |
| `rw?` | Search for a rewrite rule |
| `simp?` | Show which simp lemmas were used |

---

## Key Tactics Quick Reference

| Tactic | Use when... |
|--------|------------|
| `intro` | Goal is `P → Q` or `∀ x, ...` — introduce the hypothesis |
| `exact h` | `h` is exactly what you need to prove |
| `apply h` | `h` proves something that implies your goal |
| `constructor` | Goal is `P ∧ Q` or `P ↔ Q` — split into parts |
| `cases h` | `h : P ∨ Q` — case split |
| `obtain ⟨a, b⟩ := h` | `h : P ∧ Q` or `h : ∃ x, ...` — destructure |
| `rw [h]` | `h : a = b` — replace `a` with `b` |
| `simp` | Simplify using the simp lemma database |
| `omega` | Linear arithmetic over ℕ and ℤ |
| `ring` | Polynomial ring identities |
| `linarith` | Linear arithmetic with hypotheses |
| `norm_num` | Numerical computation |
| `decide` | Decidable propositions |
| `aesop` | Automated proof search |
| `tauto` | Propositional tautologies |
| `positivity` | Prove something is ≥ 0 or > 0 |
| `induction n` | Proof by induction |

See [CHEATSHEET.md](CHEATSHEET.md) for the full reference.

---

## Resources

### Official Documentation
- [Lean 4 Homepage](https://lean-lang.org/)
- [Theorem Proving in Lean 4](https://lean-lang.org/theorem_proving_in_lean4/) — **the** book to read
- [Functional Programming in Lean](https://lean-lang.org/functional_programming_in_lean/) — for the programming side
- [Lean 4 Manual](https://lean-lang.org/lean4/doc/) — reference manual
- [Mathlib Documentation](https://leanprover-community.github.io/mathlib4_docs/) — searchable API docs

### Interactive Learning
- [Natural Number Game](https://adam.math.hhu.de/#/g/leanprover-community/NNG4) — brilliant beginner game, prove things about ℕ
- [Lean Game Server](https://adam.math.hhu.de/) — more games (Set Theory, Logic, etc.)
- [Mathematics in Lean](https://leanprover-community.github.io/mathematics_in_lean/) — tutorial with exercises

### Community
- [Lean Zulip Chat](https://leanprover.zulipchat.com/) — the main community hub, very welcoming
- [Mathlib Contributing Guide](https://leanprover-community.github.io/contribute/) — how to contribute
- [Lean 4 GitHub](https://github.com/leanprover/lean4) — source code and issues

### Videos and Talks
- [Lean 4 Metaprogramming Book](https://leanprover-community.github.io/lean4-metaprogramming-book/) — advanced
- Search YouTube for "Lean 4 tutorial" — several good lecture series exist
- Kevin Buzzard's talks and [Xena Project](https://xenaproject.wordpress.com/) blog

### For Mathematicians Specifically
- [Mathematics in Lean](https://leanprover-community.github.io/mathematics_in_lean/) — **start here** after this repo
- [The Mechanics of Proof](https://hrmacbeth.github.io/math2001/) — proof-writing course using Lean
- [Formalising Mathematics](https://www.ma.imperial.ac.uk/~buzzard/xena/formalising-mathematics-2024/) — Kevin Buzzard's course (Imperial College London)

---

## FAQ

**Q: Why Lean 4 and not Coq/Isabelle/Agda?**
Lean 4 has the most active mathematical library (Mathlib), a modern programming language, excellent tooling, and a welcoming community. It's also what the [Xena Project](https://xenaproject.wordpress.com/) and many recent formalization efforts use.

**Q: What's Mathlib?**
[Mathlib](https://github.com/leanprover-community/mathlib4) is a massive community-maintained library of formalized mathematics in Lean 4. It covers algebra, analysis, topology, number theory, combinatorics, and much more. This repo depends on it.

**Q: Why is `sorry` everywhere?**
`sorry` is a placeholder that tells Lean "trust me, this is true." It's used here to mark exercises for you to complete. Your job is to replace every `sorry` with an actual proof. A file with no `sorry`s means everything is fully proven!

**Q: What does the yellow underline mean?**
A yellow underline in VS Code means a warning — usually that you used `sorry`. Red means an actual error.

**Q: How do I search for lemmas?**
Inside a tactic proof, type `exact?`, `apply?`, or `rw?` and Lean will search for matching lemmas. You can also search the [Mathlib docs](https://leanprover-community.github.io/mathlib4_docs/) online.

**Q: I'm stuck on a proof. What do I do?**
1. Look at the Lean Infoview — what's your goal? What hypotheses do you have?
2. Try `exact?` or `apply?` to see if Lean can find a lemma
3. Try `simp` or `omega` or `ring` — automation solves many goals
4. Ask on [Lean Zulip](https://leanprover.zulipchat.com/) — the community is incredibly helpful

---

## License

This project is open source. Use it, share it, learn from it.
