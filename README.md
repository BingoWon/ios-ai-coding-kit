<div align="center">

# iOS AI Coding Kit

**Production-ready Swift 6, SwiftUI, StoreKit 2, and SwiftData rules for Cursor, Claude Code, Codex, and GitHub Copilot — paired with grounded Apple Developer docs.**

**English** · [简体中文](./README.zh-CN.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-22c55e)](./LICENSE)
[![Swift 6](https://img.shields.io/badge/Swift-6_Strict_Concurrency-F05138?logo=swift&logoColor=white)](./.cursor/rules/01-swift6-concurrency.mdc)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-Modern_Patterns-007AFF?logo=apple&logoColor=white)](./.cursor/rules/02-swiftui-modern.mdc)
[![MCP Ready](https://img.shields.io/badge/MCP-Apple_RAG_Ready-6366f1)](https://apple-rag.com/connect?ref=github_ios_kit)

</div>

---

## Why This Kit Exists

AI coding agents are great at shipping iOS & macOS apps fast — until they confidently generate:

| Common AI Hallucination | What This Kit Enforces Instead |
| --- | --- |
| Deprecated `NavigationView`, `.foregroundColor`, single-param `.onChange` | Modern `NavigationStack`, `.foregroundStyle`, `.clipShape`, two-param `.onChange` |
| Legacy `ObservableObject` / `@StateObject` boilerplate on iOS 17+ | Clean `@Observable` + `@State` / `@Bindable` |
| Swift 5 concurrency hacks (`@unchecked Sendable`, `DispatchQueue.main.async`) | Warning-free Swift 6 strict concurrency, `@MainActor`, structured `.task(id:)` |
| Legacy StoreKit 1 (`SKPaymentQueue`) or missing Restore Purchases | StoreKit 2 (`Transaction.currentEntitlements` & `Transaction.updates` at launch) |
| SwiftData models with no migration plan & `@Model` passed across threads | `VersionedSchema`, `SchemaMigrationPlan`, `@ModelActor`, `PersistentIdentifier` |
| Invented iOS 26/27 & WWDC APIs that fail to compile in Xcode | Mandatory verification against official Apple Developer docs & WWDC transcripts |

---

## 10-Second Install

Run from the root of your iOS / macOS project (skips any file that already exists unless you pass `--force`):

```bash
# Install everything (Cursor + Claude Code + Codex + Copilot + Skill + .mcp.json + App Store checklist)
curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh

# Or install only what your editor uses:
curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh -s -- --cursor --mcp
curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh -s -- --claude --mcp
curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh -s -- --codex --skill
```

Or install the bundled `apple-dev-docs` Agent Skill directly via [`skills.sh`](https://skills.sh):

```bash
npx skills add BingoWon/ios-ai-coding-kit
```

---

## What's Inside

| File | Target Client / Purpose |
| --- | --- |
| [`.cursor/rules/01-swift6-concurrency.mdc`](./.cursor/rules/01-swift6-concurrency.mdc) | Cursor — Swift 6 strict concurrency, `@MainActor`, `Sendable`, cancellation |
| [`.cursor/rules/02-swiftui-modern.mdc`](./.cursor/rules/02-swiftui-modern.mdc) | Cursor — `@Observable`, `NavigationStack`, modern modifiers, performance & A11y |
| [`.cursor/rules/03-storekit2-swiftdata.mdc`](./.cursor/rules/03-storekit2-swiftdata.mdc) | Cursor — StoreKit 2 entitlements/restore & SwiftData versioned migrations |
| [`.cursor/rules/04-apple-docs-verification.mdc`](./.cursor/rules/04-apple-docs-verification.mdc) | Cursor — Verify unfamiliar Apple SDK APIs against canonical docs before editing |
| [`CLAUDE.md`](./CLAUDE.md) | Claude Code — Complete Swift 6 + SwiftUI + StoreKit 2 + Docs verification guide |
| [`AGENTS.md`](./AGENTS.md) | OpenAI Codex, Antigravity, OpenCode, Cline — Universal Apple engineering contract |
| [`.github/copilot-instructions.md`](./.github/copilot-instructions.md) | VS Code & GitHub Copilot — Apple platform generation guardrails |
| [`skills/apple-dev-docs/SKILL.md`](./skills/apple-dev-docs/SKILL.md) | Agent Skill (`agentskills.io`) — Structured `search` → `browse` → `fetch` doc workflow |
| [`.mcp.json`](./.mcp.json) | Zero-key remote MCP config (`https://mcp.apple-rag.com`, 30 free calls/week) |
| [`examples/mcp-with-xcode-mcpbridge.json`](./examples/mcp-with-xcode-mcpbridge.json) | Power combo: Apple RAG cloud docs + Apple official `xcrun mcpbridge` local Xcode builds |
| [`checklists/app-store-preflight.md`](./checklists/app-store-preflight.md) | Pre-submission checklist (Privacy Manifest, StoreKit 2, Dark Mode, Dynamic Type, Review 5.1.1) |

---

## Grounded Apple Docs + Local Xcode Power Combo

Rules alone stop outdated patterns, while grounded retrieval stops API hallucinations on brand-new iOS/macOS releases.

1. **Cloud Apple Knowledge ([Apple RAG](https://apple-rag.com/connect?ref=github_ios_kit))** — Remote Streamable HTTP MCP (`https://mcp.apple-rag.com`) and CLI (`npm install -g apple-rag-cli`) indexing **376,000+ Apple Developer doc pages** and **1,880+ WWDC video transcripts** with hybrid search + decision reranking. Free 30 calls/week with zero API key required (Pro $1/week for 50,000 calls).
2. **Local Xcode Execution (`xcrun mcpbridge`)** — Pair `.mcp.json` with Apple's built-in Xcode 26.3+ MCP bridge ([example config](./examples/mcp-with-xcode-mcpbridge.json)) so your agent researches canonical Apple APIs first, then compiles, tests, and previews directly in Xcode.
3. **Live Apple Docs Change Radar** — Track silent Apple documentation diffs, deprecations, and beta changes every 5 minutes (with RSS/JSON feeds) at [**apple-rag.com/updates**](https://apple-rag.com/updates?ref=github_ios_kit).

---

## Contributing & License

Pull requests for new Apple framework rules (WidgetKit, AppIntents, RealityKit, FoundationModels, Metal, Vision, CloudKit) are welcome!

Licensed under the [MIT License](./LICENSE).
