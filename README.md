# Lean Lab

**A structured path from zero Lean knowledge to AI-assisted theorem proving.**

This repository is a hands-on learning environment for Lean 4, designed for mathematicians and programmers who want to master interactive theorem proving and engage with the cutting edge of AI-integrated formal mathematics. The roadmap is aligned with the research themes of the [Harmonic Aristotle program](https://harmonic.fun/news) and the broader goal of Mathematical Superintelligence (MSI).

---

## Welcome, Learner!

If you've never used Lean before, you're in the right place. This repo is designed so that you can open any file, read it top to bottom, and learn by doing. Every concept is introduced with explanations, examples, and exercises.

**Three rules for success:**
1. **Read the Lean Infoview** — The panel on the right side of VS Code is your window into Lean's mind. *Always* look at it as you move your cursor through a proof.
2. **Try before you peek** — Every `sorry` is an exercise. Attempt it yourself before searching for hints. Struggling is how you build intuition.
3. **Experiment fearlessly** — Use `Sandbox.lean` to try wild ideas. You can't break anything; Lean will just tell you if something is wrong.

---

## What is Lean 4?

Lean 4 is both a **programming language** and a **proof assistant**. It lets you write executable programs AND machine-checked mathematical proofs — in the same language.

### The key insight: Propositions are Types, Proofs are Programs

This is the [Curry-Howard correspondence](https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence), and once it clicks, everything else follows naturally:

| Mathematics | Programming | In Lean |
|-------------|-------------|---------|
| A statement (e.g. "2+2=4") | A type | `2 + 2 = 4 : Prop` |
| A proof of that statement | A value of that type | `rfl : 2 + 2 = 4` |
| "If P then Q" | A function from P to Q | `P → Q` |
| "P and Q" | A pair (P, Q) | `P ∧ Q` |
| "P or Q" | Either P or Q | `P ∨ Q` |
| "For all x, P(x)" | A function taking any x | `∀ x, P x` |
| "There exists x, P(x)" | A pair (witness, proof) | `∃ x, P x` |

**Why does this matter?** It means that when you prove a theorem in Lean, the computer can *check* your proof mechanically. No hand-waving allowed. And when AI systems like Aristotle or AlphaProof generate proofs, Lean can verify them with 100% certainty.

### Why Lean 4 (and not Coq, Isabelle, or Agda)?

- **Largest mathematical library**: Mathlib has 200,000+ formalized theorems and growing
- **Best AI tooling**: LeanDojo, Pantograph, LeanCopilot — the ecosystem AI researchers use
- **Active community**: The [Lean Zulip chat](https://leanprover.zulipchat.com/) is welcoming and responsive
- **Modern language**: Lean 4 is fast, has a real compiler, and feels like a modern programming language
- **Industry momentum**: Aristotle, AlphaProof, DeepSeek-Prover — all use Lean 4

---

## Getting Started

### Prerequisites
- **A code editor**: VS Code is strongly recommended (Lean's tooling is built for it)
- **Basic programming experience**: If you've written functions in any language, you're ready
- **Mathematical curiosity**: Undergraduate-level math helps, but isn't strictly required for the early phases

### Installation (step by step)

**Step 1 — Install Lean 4** via [elan](https://lean-lang.org/lean4/doc/setup.html) (the Lean version manager):

```bash
# Linux / macOS
curl https://elan.lean-lang.org/install.sh -sSf | sh

# Windows: download the installer from https://lean-lang.org/lean4/doc/setup.html
# After installing, you may need to add elan to your PATH:
#   setx Path "%USERPROFILE%\.elan\bin;%Path%"
# Then restart your terminal.
```

**Step 2 — Install VS Code + the lean4 extension**:
1. Download [VS Code](https://code.visualstudio.com/)
2. Open VS Code → Extensions (Ctrl+Shift+X) → search "lean4" → Install
3. The extension provides syntax highlighting, the Infoview panel, and error diagnostics

**Step 3 — Clone and build this project**:
```bash
git clone https://github.com/omegaestable/lean.git
cd lean
lake update    # Downloads Mathlib (~3 GB the first time — be patient!)
lake build     # Compiles the project (takes a while the first build)
```

> **Tip for Windows users**: If `lake` is not recognized, make sure `%USERPROFILE%\.elan\bin` is on your PATH. You can set it temporarily with:
> ```powershell
> $env:Path = "$env:USERPROFILE\.elan\bin;" + $env:Path
> ```

**Step 4 — Open in VS Code and explore!**

Open the `lean` folder in VS Code. Open any `.lean` file. The **Lean Infoview** panel will appear on the right — this shows proof states, types, and errors in real time.

> **Your most important tool is the Infoview panel.** Place your cursor on different lines of a proof and watch the panel update. This is how you "see" what Lean is thinking.

### Troubleshooting

| Problem | Solution |
|---------|----------|
| `lake: command not found` | Add elan to PATH (see Step 1 above) |
| Build takes forever | First build downloads + compiles Mathlib. Subsequent builds are fast. |
| Red squiggles everywhere | Wait for the Lean server to finish loading (check the bottom status bar) |
| Infoview not showing | Ctrl+Shift+P → "Lean 4: Infoview: Toggle" |
| "unknown identifier" errors | Make sure you have the right `import` at the top of the file |

---

## Repository Structure

The repo is organized into 5 phases, each building on the previous. Files are numbered so you can work through them in order.

```
LeanLab/
│
├── Basics/                          ← PHASE 1: Lean Fundamentals
│   ├── HelloWorld.lean                 01 — #check, #eval, your first theorem
│   ├── TypesAndTerms.lean              02 — Types, Prop vs Type, inductive types
│   └── Functions.lean                  03 — Recursion, pattern matching, higher-order
│
├── Logic/                           ← PHASE 1 (continued): Proof Skills
│   ├── PropositionalLogic.lean         04 — ∧, ∨, →, ¬, ↔ (Curry-Howard in action)
│   ├── Quantifiers.lean                05 — ∀, ∃, equality, classical logic
│   └── Tactics.lean                    06 — Full tactic reference + practice
│
├── Mathlib/                         ← PHASE 2: Library Mastery
│   ├── SearchAndDiscovery.lean         07 — exact?, apply?, naming conventions, Loogle
│   └── WorkingWithMathlib.lean         08 — Typeclasses, proof engineering, contributing
│
├── Metaprogramming/                 ← PHASE 3: Extending Lean
│   ├── CustomTactics.lean              09 — TacticM monad, custom tactics, Expr type
│   └── MacrosAndDSLs.lean             10 — Macros, syntax extensions, elaboration
│
├── Mathematics/                     ← PHASE 4: Real Formalization
│   ├── NaturalNumbers.lean             11 — Induction, divisibility, modular arithmetic
│   ├── Algebra.lean                    12 — Groups, rings, fields via Mathlib
│   └── Analysis.lean                   13 — Sequences, metric spaces, ε-δ proofs
│
├── AIIntegration/                   ← PHASE 5: AI + Lean
│   ├── Overview.lean                   14 — Landscape, proof states, training data
│   ├── Autoformalization.lean          15 — Informal→formal, pitfalls, pipelines
│   └── ToolsSetup.lean                16 — LeanDojo, Pantograph, LeanCopilot setup
│
├── Exercises/                       ← Progressive Difficulty
│   ├── Level1_Basics.lean              ⭐ Functions and simple proofs
│   ├── Level2_Logic.lean               ⭐⭐ Propositional and predicate logic
│   ├── Level3_Math.lean                ⭐⭐⭐ Algebra, inequalities, induction
│   ├── Level4_Competition.lean         ⭐⭐⭐⭐ AMC/AIME/IMO-style problems
│   └── Level5_Research.lean            ⭐⭐⭐⭐⭐ Research-level formalization
│
└── Sandbox.lean                     ← Your playground — experiment freely!
```

### How to Navigate

- **If you're brand new to Lean**: Start with `Basics/HelloWorld.lean`. Read every comment. Move your cursor through the file and watch the Infoview.
- **If you know some programming**: Skim through `Basics/`, then spend time on `Logic/PropositionalLogic.lean`.
- **If you know some proof assistants**: Jump to `Mathlib/SearchAndDiscovery.lean` and `Mathematics/`.
- **If you're here for AI/Lean**: Read everything in order — the foundations matter for understanding how AI systems interact with Lean.

---

## Learning Roadmap

### Phase 1 — Foundations (4–6 weeks)
**Goal**: Fluency in Lean 4 syntax, types, and interactive proof.

*Think of this phase as learning to read and write in a new language. You need to be comfortable with the basic vocabulary (types, functions, propositions) before you can express complex ideas (theorems, proofs).*

| Task | File | What You'll Learn |
|------|------|-------------------|
| Explore `#check`, `#eval`, write first theorems | `Basics/HelloWorld.lean` | How Lean evaluates expressions, `rfl` |
| Understand Prop vs Type, build inductive types | `Basics/TypesAndTerms.lean` | Lean's type universe, pattern matching |
| Write recursive functions, use higher-order functions | `Basics/Functions.lean` | Structural recursion, `map`/`filter`/`fold` |
| Prove with ∧, ∨, →, ¬, ↔ | `Logic/PropositionalLogic.lean` | `intro`, `exact`, `cases`, `constructor` |
| Work with ∀, ∃, equality, `calc` | `Logic/Quantifiers.lean` | `use`, `obtain`, `rw`, `calc` blocks |
| Build your tactic toolbox | `Logic/Tactics.lean` | `simp`, `omega`, `ring`, `aesop`, `linarith` |
| Test yourself | `Exercises/Level1_Basics.lean` | Consolidation |
| Test yourself (logic) | `Exercises/Level2_Logic.lean` | Consolidation |

**Parallel activity**: Complete the [Natural Number Game](https://adam.math.hhu.de/#/g/leanprover-community/NNG4) — it's the best interactive introduction to Lean proofs. Also start reading [Theorem Proving in Lean 4](https://leanprover.github.io/theorem_proving_in_lean4/).

### Phase 2 — Mathlib & Proof Engineering (6–8 weeks)
**Goal**: Navigate and use Mathlib, the world's largest formalized math library.

*Mathlib has 200,000+ lemmas. Nobody memorizes them. The skill you're building here is how to FIND what you need — this is also exactly what AI models need to learn (premise selection).*

| Task | File | What You'll Learn |
|------|------|-------------------|
| Master `exact?`, `apply?`, Loogle, Moogle | `Mathlib/SearchAndDiscovery.lean` | Lemma discovery in a huge library |
| Work with typeclasses, proof patterns, contribution workflow | `Mathlib/WorkingWithMathlib.lean` | How real math is organized in Lean |
| Formalize results from a textbook | Your own files | Real formalization practice |
| Test yourself | `Exercises/Level3_Math.lean` | Applied math in Lean |

**Parallel activity**: Work through [Mathematics in Lean](https://leanprover-community.github.io/mathematics_in_lean/). Explore Tao's [Lean companion to Analysis I](https://github.com/teorth/analysis). Join the [Lean Zulip](https://leanprover.zulipchat.com/).

### Phase 3 — Metaprogramming & Automation (6–8 weeks)
**Goal**: Extend Lean itself with custom tactics, macros, and automation.

*This is where you go from being a Lean USER to a Lean BUILDER. The same APIs used here are what LeanDojo and Pantograph use under the hood — so understanding metaprogramming is essential for AI/Lean work.*

| Task | File | What You'll Learn |
|------|------|-------------------|
| Write custom tactics using TacticM | `Metaprogramming/CustomTactics.lean` | The tactic monad, `Expr` type |
| Build macros and syntax extensions | `Metaprogramming/MacrosAndDSLs.lean` | Lean's elaboration pipeline |
| Understand how AI tools read proof states | Both files | The bridge to AI integration |

**Parallel activity**: Read the [Lean 4 Metaprogramming Book](https://leanprover-community.github.io/lean4-metaprogramming-book/). Explore [LeanDojo](https://github.com/lean-dojo/LeanDojo-v2) and [PyPantograph](https://github.com/stanford-centaur/PyPantograph) source code.

### Phase 4 — Real Mathematics & AI Integration (8–12 weeks)
**Goal**: Formalize real math, then connect it to AI toolchains.

*Now you bring everything together. The Mathematics files show you what "real" formalization looks like — not toy examples, but actual mathematical structures and proofs. The AI Integration files show you how AI systems interact with these proofs.*

| Task | File | What You'll Learn |
|------|------|-------------------|
| Prove things about ℕ by induction | `Mathematics/NaturalNumbers.lean` | Foundational number theory |
| Work with groups, rings, fields | `Mathematics/Algebra.lean` | Abstract algebra in Lean |
| Work with limits, continuity, metric spaces | `Mathematics/Analysis.lean` | ε-δ proofs, Mathlib topology |
| Understand the AI/Lean landscape | `AIIntegration/Overview.lean` | Proof states, training data |
| Practice autoformalization | `AIIntegration/Autoformalization.lean` | Informal → formal translation |
| Set up LeanDojo, Pantograph, LeanCopilot | `AIIntegration/ToolsSetup.lean` | Python/Lean interop |
| Test yourself (competition) | `Exercises/Level4_Competition.lean` | AMC/AIME/IMO-style |

**Parallel activity**: Study the [Aristotle](https://arxiv.org/abs/2510.01346), [DeepSeek-Prover](https://arxiv.org/abs/2405.14333), and [FORMAL](https://arxiv.org/abs/2505.00629) papers.

### Phase 5 — Research & Portfolio (Ongoing)
**Goal**: Original contributions, collaborations, and Aristotle grant preparation.

| Task | File | What You'll Learn |
|------|------|-------------------|
| Formalize results from your own research | `Exercises/Level5_Research.lean` | Original formalization |
| Contribute to miniF2F / benchmark correction | External | Community impact |
| Build an autoformalization or proof search tool | External | Research engineering |
| Write a technical report or paper | External | Communication |
| Prepare Aristotle grant application | External | Grant writing |

---

## Your First 30 Minutes

Not sure where to begin? Here's a concrete plan:

1. **Open `LeanLab/Basics/HelloWorld.lean`** in VS Code
2. **Read the top comment** — it explains what Lean is and how to read the file
3. **Place your cursor on `#check 42`** — look at the Infoview panel on the right. It should say `42 : Nat`
4. **Move your cursor to `#eval 2 + 3`** — the Infoview shows `5`
5. **Find `theorem two_plus_two`** — put your cursor on `rfl` and read what the Infoview says
6. **Scroll to "TRY IT YOURSELF"** — replace `sorry` with `rfl` and see the error disappear
7. **Celebrate!** — you just proved your first theorem

When you're done with HelloWorld, move to `TypesAndTerms.lean`, then `Functions.lean`, and so on.

---

## Glossary for Beginners

| Term | What It Means | Example |
|------|---------------|---------|
| **Type** | A classification of values | `Nat`, `String`, `Bool` |
| **Term** | A value of some type | `42 : Nat`, `"hello" : String` |
| **Prop** | The type of propositions (true/false statements) | `2 + 2 = 4 : Prop` |
| **Theorem** | A named proof of a proposition | `theorem foo : 2 = 2 := rfl` |
| **Tactic** | A command that transforms proof goals | `intro`, `exact`, `simp` |
| **Goal** | What you still need to prove (shown in Infoview) | `⊢ n + 0 = n` |
| **Hypothesis** | Something you've already assumed or proved | `h : n > 0` |
| **`sorry`** | A placeholder meaning "proof goes here" | Every `sorry` is an exercise |
| **`rfl`** | "Both sides are the same by definition" | Proves `2 + 2 = 4` |
| **`by`** | Enters tactic mode (step-by-step proving) | `theorem foo : ... := by ...` |
| **Infoview** | VS Code panel showing current proof state | Your most important tool! |
| **Mathlib** | Lean's massive math library (200K+ theorems) | `import Mathlib.Tactic` |
| **`#check`** | Ask Lean "what is the type of this?" | `#check 42` → `42 : Nat` |
| **`#eval`** | Ask Lean "compute this for me" | `#eval 2+3` → `5` |

---

## Key AI/Lean Systems (2025)

| System | Organization | Key Achievement | Lean Version |
|--------|-------------|-----------------|-------------|
| **Aristotle** | Harmonic | IMO gold-medal equivalent | Lean 4 |
| **AlphaProof** | DeepMind | IMO silver-medal equivalent | Lean 4 |
| **DeepSeek-Prover-V2** | DeepSeek | Strong miniF2F performance | Lean 4 |
| **LeanCopilot** | Caltech/LeanDojo | VS Code AI integration | Lean 4 |
| **ReProver** | LeanDojo | Tactic prediction baseline | Lean 4 |

---

## Key Benchmarks

| Benchmark | Source | Size | Focus |
|-----------|--------|------|-------|
| **miniF2F** | OpenAI | 488 problems | AMC/AIME/IMO competition math |
| **ProofNet** | Research | Varies | Undergraduate mathematics |
| **FormL4** | Research | Varies | Autoformalization quality |
| **FormalMATH** | Research | Varies | Broad formal mathematics |
| **PutnamBench** | Research | Varies | Advanced competition math |

---

## Aristotle Grant — Research Directions

The [Harmonic Aristotle program](https://harmonic.fun/news) offers **Principal Investigator Awards** (~$100K) and **Rising Mathematician Awards** for work advancing Mathematical Superintelligence. Key themes:

1. **Autoformalization & Retrieval**: RAG/RAT systems for Lean 4, agentic feedback loops, benchmark curation
2. **Proof Search & RL**: MCTS/MCGS strategies, value models, test-time training
3. **Datasets & Benchmarks**: Correcting misformalizations, creating new benchmarks, evaluation metrics
4. **Model Fine-tuning**: LoRA on Lean proof data, premise selection, local deployment
5. **Human-AI Collaboration**: Mixed-initiative interfaces, interpretable suggestions

---

## Essential Tools at a Glance

### In Lean (inside proofs)
| Command | Purpose | When to Use |
|---------|---------|-------------|
| `#check expr` | Show the type of an expression | When you want to know what something IS |
| `#eval expr` | Compute an expression | When you want to see a RESULT |
| `#print name` | Show full definition | When you want to see HOW something is defined |
| `exact?` | Find a lemma that closes the goal | When you're stuck — try this first! |
| `apply?` | Find a lemma you can apply | When you need an intermediate step |
| `rw?` | Find a rewrite rule | When you want to transform the goal |
| `simp?` | Show which simp lemmas were used | When `simp` works but you want to understand why |

### External Search Tools
| Tool | URL | What It Does |
|------|-----|--------------|
| **Loogle** | [loogle.lean-lang.org](https://loogle.lean-lang.org/) | Search Mathlib by type signature |
| **Moogle** | [moogle.ai](https://www.moogle.ai/) | Search Mathlib in plain English |
| **Mathlib Docs** | [leanprover-community.github.io/mathlib4_docs](https://leanprover-community.github.io/mathlib4_docs/) | Browse all definitions and theorems |

### AI/Lean Tools (Python)
| Tool | Install | Purpose |
|------|---------|---------|
| **LeanDojo-v2** | `pip install lean-dojo` | Extract proof data for AI training |
| **PyPantograph** | `pip install pantograph` | Talk to Lean from Python |
| **LeanCopilot** | Lake dependency | AI-powered tactic suggestions in VS Code |

---

## Quick Reference: Top Tactics

| Tactic | What It Solves | Example |
|--------|----------------|---------|
| `rfl` | `a = a` (definitional equality) | `2 + 2 = 4` |
| `omega` | Linear arithmetic (ℕ, ℤ) | `n + 1 > n` |
| `ring` | Polynomial identities | `(a+b)² = a²+2ab+b²` |
| `simp` | Simplification using lemma database | `xs ++ [] = xs` |
| `norm_num` | Numerical computation | `2^10 = 1024` |
| `linarith` | Linear arithmetic with hypotheses | `a ≤ b → b ≤ c → a ≤ c` |
| `positivity` | Non-negativity proofs | `a² ≥ 0` |
| `nlinarith` | Nonlinear arithmetic | `(a-b)² ≥ 0` |
| `aesop` | Automated proof search | Various |
| `tauto` | Propositional tautologies | `P → Q → P` |
| `decide` | Decidable propositions | `¬(3 = 4)` |
| `exact?` | Find a closing lemma | When you're stuck |

Full reference: [CHEATSHEET.md](CHEATSHEET.md)

---

## FAQ

**Q: I've never used a proof assistant before. Is this for me?**
Yes! Phase 1 assumes no prior Lean knowledge. If you can write a function in any programming language, you can learn Lean. The hardest part is the first week — after that, patterns emerge and it gets much more natural.

**Q: Why Lean 4 and not Coq/Isabelle/Agda?**
Lean 4 has the most active mathematical library (Mathlib, 200K+ theorems), the strongest AI tooling ecosystem (LeanDojo, Pantograph, LeanCopilot), and a welcoming community. It's the platform of choice for Aristotle, AlphaProof, and most recent AI/Lean research.

**Q: What's `sorry`?**
A placeholder meaning "proof goes here." Every `sorry` in this repo is an exercise for you. Your job is to replace them with real proofs. A file with zero `sorry`s is fully proven. The Lean compiler will show a warning for every `sorry` — that's by design!

**Q: How do I find lemmas in Mathlib?**
Use `exact?` / `apply?` / `rw?` inside proofs (they search automatically). Use [Loogle](https://loogle.lean-lang.org/) for type-based search. Use [Moogle](https://www.moogle.ai/) for natural language search. See `Mathlib/SearchAndDiscovery.lean` for a full guide.

**Q: I'm stuck on a proof. What do I do?**
1. **Read the Infoview** — what's the current goal? What hypotheses do you have?
2. **Try the power tactics**: `exact?`, `simp`, `omega`, `ring`, `aesop`, `linarith`
3. **Use `#check`** to explore related lemmas
4. **Simplify the problem** — can you prove a special case first?
5. **Ask for help** on [Lean Zulip](https://leanprover.zulipchat.com/) — the community is very friendly

**Q: How long does it take to get comfortable with Lean?**
Most people feel productive after 2–4 weeks of regular practice. Fluency with Mathlib takes longer (2–3 months). Metaprogramming is its own learning curve. Be patient with yourself — even experienced mathematicians find the first week challenging.

**Q: How do I start with AI/Lean tools?**
See `AIIntegration/ToolsSetup.lean`. Start with `pip install lean-dojo` and extract proof data from your own files. This connects your Lean work to the AI pipeline.

**Q: Can I use this repo for a course or study group?**
Absolutely! The exercises are designed to be progressive. Level 1–2 work well for a week-long workshop. Level 3–4 can fill a semester project.

---

## Community

- [Lean Zulip Chat](https://leanprover.zulipchat.com/) — main community hub, very welcoming to beginners
- [Mathlib Initiative](https://mathlib-initiative.org/) — strategic support for the Mathlib ecosystem
- [Lean FRO](https://lean-fro.org/) — Lean Focused Research Organization
- [Harmonic](https://harmonic.fun/) — Aristotle program and AI/Lean research
- [Lean 4 Dev](https://lean4.dev/) — comprehensive learning platform

---

## License

This project is open source. Use it, share it, learn from it, build on it.
