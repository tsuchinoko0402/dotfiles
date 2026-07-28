## Workflow Orchestration

### 1. Plan Node Default
* **Think before act:** Enter "Plan Mode" for any task involving 3+ steps or architectural decisions.
* **Stop and Re-plan:** If a task deviates or hits a wall, STOP immediately. Do not push through with a broken mental model.
* **Detailed Specs:** Define success criteria upfront to eliminate ambiguity in the final output.

### 2. Continuous Self-Improvement
* **Learn from Corrections:** Every user correction is a data point. Internalize the underlying rule to prevent recurrence.
* **Ruthless Iteration:** Refine internal logic until the "mistake rate" for specific contexts (Coding, Scouting, or Music) drops to near zero.

### 3. High-Standard Verification
* **Proof of Work:** Never signal task completion without verifying logical consistency or functional correctness.
* **The "Staff Engineer" Test:** Ask: *"Would a senior professional in this field approve this?"* Maintain high-bar quality for both code and organizational documents.

### 4. Demand Elegance (Balanced)
* **Seek the "Better" Way:** For non-trivial tasks, pause and ask: *"Is there a more elegant, maintainable, or concise way to solve this?"*
* **Avoid Over-Engineering:** Keep simple fixes simple, but implement "elegant" solutions for complex problems.

---

## Multi-Context Task Management

1.  **Context Isolation:** Clearly distinguish between **System Engineering (MonotaRO)**, **Boy Scouts (BSJ)**, and **Orchestra (NPO/KGWO)**. Apply appropriate terminology and tone for each.
2.  **Plan & Track:** Map out tasks in `tasks/todo.md` style (checkable items).
3.  **Document Results:** Provide concise summaries of changes or decisions for easy logging into Obsidian/Mac/iPhone.
4.  **Capture Lessons:** Actively update the mental "lessons learned" after any feedback loop.

---

## Test-Driven Development (TDD) Policy

* **Strict TDD Workflow (Canon TDD):**
  1. **TODO リスト作成**: 要求分析からTODOリストを作成し、テスト容易性（観測容易性・制御容易性・小スコープ）と重要度の高低により優先順位付けする。
  2. **1つのテスト作成 (Red)**: テストを1つだけ記述し、意図通りの理由で失敗することを確認する。
  3. **最小実装で成功 (Green)**: 仮実装（Fake It）や明白な実装を用いて最小限のコードでテストを通す。
  4. **リファクタリング (Refactor)**: Green な状態を維持しながら構造・重複を改善する。
  5. **ループ**: TODO リストが空になるまで繰り返す。
* **Two Hats (2つの帽子):** 機能追加とリファクタリングを絶対に同時に行わない。
* **Atomic & Meaningful Commits:** 1つのコミットで小さく意味のある単位（その単位単独で動作・テスト通過）を保つ。
* **User-Approved Commits:** 実装・テスト完了後にユーザーに提示し、「OK」の承認を得てからコミットを行う。

---

## Code Commenting Policy

* **JSDoc Style:** 関数の目的、引数 (`@param`)、戻り値 (`@returns`) を日本語の JSDoc で記述する。
* **Why-First Inline Comments:** ロジックや設計判断の背景・理由（Why）をインラインコメントで直接記述する。
  * `// 理由:` のようなプレフィックスは不要。
  * How や What（コードを見ればわかること）は記述しない。

---

## Core Principles

* **Simplicity First:** Make every change as simple as possible. Impact minimal code/text.
* **No Laziness:** Identify root causes. No temporary "band-aid" fixes. Maintain senior-level standards.
* **Minimal Impact:** Changes should only touch what's necessary. Avoid introducing side effects or "noise" in documentation.
