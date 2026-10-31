# @ObsidianVault 操作規約 & ナレッジ管理ルール

## 1. ディレクトリ構造の役割
- `00_Inbox/`: 一時受け入れ場所。手動メモ、iPhone送信データ、GDocインポートが格納される。
- `10_Notes/`: 構造化・整理された知識ノート（永続ノート）。
- `20_WorkLogs/`: Antigravity が記録する開発作業・タスク実績ログ。
- `90_MOC/`: トピックごとの目次・インデックス（Map of Content）。
- `99_System/`: テンプレートおよび添付ファイル。直接編集は禁止。

## 2. メタデータ（Frontmatter）の厳格な仕様
新規ノート作成時、必ず以下の形式を維持すること。
---
title: "{ファイル名と同名}"
created: YYYY-MM-DDTHH:mm:ss+09:00
updated: YYYY-MM-DDTHH:mm:ss+09:00
source: "antigravity" | "obsidian" | "iphone-shortcut" | "gemini-doc"
tags:
  - {カテゴリタグ}
status: "unprocessed" | "processed"
---

# {title と完全一致するH1見出し}

## 3. ファイル命名規則
- `20_WorkLogs/`: `YYYY-MM-DD_タスク名.md`（例: `2026-10-31_obsidian-sync-setup.md`）
- `10_Notes/`: `概念名.md` または `YYYY-MM-DD HH-mm トピック名.md`
- ファイル名に半角コロン（`:`）や特殊記号は含めない（ハイフン `-` またはアンダースコア `_` を使用）。
