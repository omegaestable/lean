/-!
# Phase 4C — Setting Up AI/Lean Tools

## This file is a guide (not executable Lean code for the most part)
## It documents how to set up and use the key AI/Lean tools.

The tools in this ecosystem require Python + Lean interop.
This file serves as a reference for setting them up.
-/

/-!
# ============================================================
# TOOL 1: LeanDojo-v2
# ============================================================

## What it does
Extracts training data from Lean repos and provides a Python API
for interacting with Lean programmatically.

## Installation
```bash
# Recommended: use uv for Python environment management
pip install uv
uv venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows

# Install LeanDojo-v2
pip install lean-dojo
```

## Basic usage (Python)
```python
from lean_dojo import LeanGitRepo, trace

# Trace a Lean repo to extract proof data
repo = LeanGitRepo(
    "https://github.com/leanprover-community/mathlib4",
    "commit_hash_here"
)
traced_repo = trace(repo)

# Get theorems and their proofs
for thm in traced_repo.get_traced_theorems():
    print(f"Theorem: {thm.full_name}")
    for step in thm.get_tactic_steps():
        print(f"  State: {step.state_before}")
        print(f"  Tactic: {step.tactic}")
```

## Key features
- Extracts (state, tactic, next_state) triples from ANY Lean repo
- Works with Mathlib and custom projects
- Provides pre-traced datasets for common repos
- Supports training ReProver (a tactic prediction model)

# ============================================================
# TOOL 2: PyPantograph
# ============================================================

## What it does
Provides a machine-to-machine REPL for Lean 4.
Think of it as "VS Code tactic mode, but as a Python API."

## Installation
```bash
pip install pantograph
```

## Basic usage (Python)
```python
from pantograph import Server

# Start a Pantograph server (connects to Lean)
server = Server()

# Start a proof
state = server.goal_start("∀ (n : Nat), n + 0 = n")
print(f"Initial state: {state}")

# Apply a tactic
new_state = server.goal_tactic(state, goal_id=0, tactic="intro n")
print(f"After intro: {new_state}")

# Apply another tactic
final_state = server.goal_tactic(new_state, goal_id=0, tactic="simp")
print(f"After simp: {final_state}")
# If goals_finished is True, the proof is complete!
```

## Key features
- Real-time proof interaction from Python
- Multiple goal management
- Tactic execution with error feedback
- File validation
- Constant inspection

# ============================================================
# TOOL 3: LeanCopilot
# ============================================================

## What it does
AI-powered VS Code extension that suggests tactics as you write proofs.

## Installation
Add to your lakefile.lean:
```lean
require LeanCopilot from git
  "https://github.com/lean-dojo/LeanCopilot" @ "main"
```

Then in your Lean files:
```lean
import LeanCopilot

-- Use `suggest_tactics` to get AI suggestions
example (n : Nat) : n + 0 = n := by
  suggest_tactics  -- AI will suggest tactics here
```

## Note
LeanCopilot requires downloading model weights (~2 GB).
It runs inference locally using ONNX or can connect to an API.

# ============================================================
# TOOL 4: Building Your Own AI/Lean Pipeline
# ============================================================

## Architecture of a basic AI theorem prover

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Problem    │────▶│   LLM/Model  │────▶│   Tactic    │
│  Statement   │     │  (Predictor) │     │  Candidate  │
└─────────────┘     └──────────────┘     └──────┬──────┘
                                                 │
                                                 ▼
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Success/  │◀────│  Lean Kernel │◀────│ Pantograph  │
│   Failure   │     │  (Verifier)  │     │   (REPL)    │
└─────────────┘     └──────────────┘     └─────────────┘
        │
        ▼
┌─────────────┐
│   Search    │  (Beam search, MCTS, best-first, etc.)
│  Strategy   │
└─────────────┘
```

## Steps to build a minimal AI prover

1. **Data extraction**: Use LeanDojo to get (state, tactic) pairs from Mathlib
2. **Model training**: Fine-tune an LLM (e.g., Llama, DeepSeek) on this data
   - Input: proof state as text
   - Output: next tactic as text
   - Method: LoRA fine-tuning for efficiency
3. **Proof search**: Use Pantograph to interact with Lean
   - Start proof → get state → predict tactic → apply → repeat
   - Use beam search or MCTS to explore multiple paths
4. **Evaluation**: Test on miniF2F or your own benchmark
   - Metric: % of problems solved within time/step budget

## Python skeleton (pseudocode)
```python
from pantograph import Server
from transformers import AutoModelForCausalLM

model = AutoModelForCausalLM.from_pretrained("your-fine-tuned-model")
server = Server()

def prove(theorem_statement, max_steps=100):
    state = server.goal_start(theorem_statement)

    for step in range(max_steps):
        # Get current proof state as text
        state_text = format_state(state)

        # Predict next tactic(s) using the model
        candidates = model.generate(state_text, num_return_sequences=8)

        # Try each candidate
        for tactic in candidates:
            try:
                new_state = server.goal_tactic(state, 0, tactic)
                if new_state.goals_finished:
                    return "QED"
                state = new_state
                break
            except:
                continue

    return "FAILED"
```

# ============================================================
# TOOL 5: Datasets and Fine-tuning
# ============================================================

## Pre-extracted datasets
- **LeanDojo Benchmark**: Pre-traced Mathlib proofs
  URL: huggingface.co/datasets/kaiyuy/LeanDojo_Benchmark_4
- **miniF2F-lean4**: Competition problems
  URL: github.com/openai/miniF2F

## Fine-tuning with LoRA
```python
from peft import LoraConfig, get_peft_model
from transformers import AutoModelForCausalLM

model = AutoModelForCausalLM.from_pretrained("deepseek-ai/deepseek-math-7b-base")

lora_config = LoraConfig(
    r=16,
    lora_alpha=32,
    target_modules=["q_proj", "v_proj"],
    lora_dropout=0.05,
    task_type="CAUSAL_LM"
)

model = get_peft_model(model, lora_config)
# Then train on (state → tactic) pairs
```

## Evaluation
```bash
# Run on miniF2F
python evaluate.py --benchmark miniF2F --model your-model --budget 600
```
-/

-- This file is primarily documentation. Here's a small executable section:

-- You can verify that your Lean setup works with AI tools by checking:
#check @Nat.add_comm  -- this should work if Mathlib is loaded
-- If this works, LeanDojo/Pantograph can interact with your project.
