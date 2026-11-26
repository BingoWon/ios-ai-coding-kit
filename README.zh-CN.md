<div align="center">

# iOS AI Coding Kit

**面向 Cursor、Claude Code、Codex、TRAE 与 GitHub Copilot 的现代 Swift 6、SwiftUI、StoreKit 2 与 SwiftData 工程规则库——开箱即用，告别 AI 写 iOS 代码时的过时 API 幻觉。**

[English](./README.md) · **简体中文**

[![License: MIT](https://img.shields.io/badge/License-MIT-22c55e)](./LICENSE)
[![Swift 6](https://img.shields.io/badge/Swift-6_严格并发-F05138?logo=swift&logoColor=white)](./.cursor/rules/01-swift6-concurrency.mdc)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-现代规范-007AFF?logo=apple&logoColor=white)](./.cursor/rules/02-swiftui-modern.mdc)
[![MCP Ready](https://img.shields.io/badge/MCP-Apple_RAG_已集成-6366f1)](https://apple-rag.com/connect?ref=github_ios_kit_zh)

</div>

---

## 为什么做这套规则库？

用 AI 写 iOS / macOS App 时，最消耗时间的往往不是业务逻辑，而是模型反复编造过时接口导致 Xcode 编译满屏报错：

| AI 常见“坑点” | 本规则库强制执行的现代标准 |
| --- | --- |
| 继续生成已废弃的 `NavigationView`、`.foregroundColor`、单参 `.onChange` | 强制使用 `NavigationStack`、`.foregroundStyle`、`.clipShape`、双参 `.onChange` |
| 在 iOS 17+ 项目里仍堆砌旧版 `ObservableObject` / `@StateObject` | 统一采用 `@Observable` + `@State` / `@Bindable` |
| 用 `@unchecked Sendable`、`DispatchQueue.main.async` 掩盖 Swift 6 并发报错 | 严格遵循 Swift 6 并发安全、`@MainActor` 与结构化 `.task(id:)` |
| 写出旧版 StoreKit 1（`SKPaymentQueue`）或漏掉“恢复购买”按钮导致被拒审 | 强制 StoreKit 2（启动监听 `Transaction.updates` + `AppStore.sync()`） |
| SwiftData 缺少版本迁移方案、跨线程传递 `@Model` 对象引发崩溃 | `VersionedSchema` + `SchemaMigrationPlan` + `@ModelActor` + `PersistentIdentifier` |
| 凭记忆编造新系统 / WWDC API 签名与最低系统版本要求 | 写代码前优先通过官方 Apple 文档与 WWDC 字幕核验并标注官方链接 |

---

## 10 秒一键安装

在你的 iOS / macOS 项目根目录运行（默认跳过已存在文件，绝不覆盖你现有配置；如需覆盖可加 `--force`）：

```bash
# 安装全套规则（Cursor + Claude Code + Codex + Copilot + Skill + .mcp.json + 提审自查清单）
curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh

# 或按你的客户端按需安装：
curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh -s -- --cursor --mcp
curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh -s -- --claude --mcp
curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh -s -- --codex --skill
```

也可直接通过 `skills.sh` 安装内置的 `apple-dev-docs` 智能体技能：

```bash
npx skills add BingoWon/ios-ai-coding-kit
```

---

## 目录说明

| 文件 | 适用客户端 / 作用 |
| --- | --- |
| [`.cursor/rules/01-swift6-concurrency.mdc`](./.cursor/rules/01-swift6-concurrency.mdc) | Cursor — Swift 6 严格并发、`@MainActor`、`Sendable` 与任务取消规范 |
| [`.cursor/rules/02-swiftui-modern.mdc`](./.cursor/rules/02-swiftui-modern.mdc) | Cursor — `@Observable`、`NavigationStack`、现代修饰符、性能与无障碍 |
| [`.cursor/rules/03-storekit2-swiftdata.mdc`](./.cursor/rules/03-storekit2-swiftdata.mdc) | Cursor — StoreKit 2 订阅/内购避坑与 SwiftData 版本迁移规范 |
| [`.cursor/rules/04-apple-docs-verification.mdc`](./.cursor/rules/04-apple-docs-verification.mdc) | Cursor — 遇陌生 Apple SDK API 先核验官方文档再改代码 |
| [`CLAUDE.md`](./CLAUDE.md) | Claude Code — 完整 Swift 6 + SwiftUI + StoreKit 2 工程规范 |
| [`AGENTS.md`](./AGENTS.md) | OpenAI Codex、Antigravity、OpenCode、Cline 通用智能体规范 |
| [`.github/copilot-instructions.md`](./.github/copilot-instructions.md) | VS Code / GitHub Copilot 规范文件 |
| [`skills/apple-dev-docs/SKILL.md`](./skills/apple-dev-docs/SKILL.md) | Agent Skill（`agentskills.io` 规范）— `search` → `browse` → `fetch` 检索工作流 |
| [`.mcp.json`](./.mcp.json) | 零配置远程 Apple RAG MCP 接入（`https://mcp.apple-rag.com`，免 Key 每周免费 30 次） |
| [`examples/mcp-with-xcode-mcpbridge.json`](./examples/mcp-with-xcode-mcpbridge.json) | 黄金组合：Apple RAG 云端知识库 + Apple 官方 `xcrun mcpbridge` 本地编译测试 |
| [`checklists/app-store-preflight.md`](./checklists/app-store-preflight.md) | App Store 提审前避坑自查清单（隐私清单、内购恢复、深浅色、动态字号、删号合规） |

---

## 规则 + 实时官方文档检索（黄金组合）

1. **云端官方知识大脑（[Apple RAG](https://apple-rag.com/connect?ref=github_ios_kit_zh)）**：内置 `.mcp.json` 直连 `https://mcp.apple-rag.com`（也支持 `npm install -g apple-rag-cli`），覆盖 **376,000+ Apple 官方文档页**与 **1,880+ WWDC 视频字幕**，中国大陆自动路由决策重排模型，免注册免费体验 30 次/周（Pro 支持支付宝 $1/周 享 50,000 次）。
2. **搭配本地 Xcode（`xcrun mcpbridge`）**：参考 [`examples/mcp-with-xcode-mcpbridge.json`](./examples/mcp-with-xcode-mcpbridge.json)，让 AI 先查官方最新规范再触发本地 Xcode 编译、单测与预览。
3. **实时文档动态雷达**：每 5 分钟追踪 Apple 官方文档新增、废弃与 Beta 变更，随时查看 [**apple-rag.com/updates**](https://apple-rag.com/updates?ref=github_ios_kit_zh)（支持 RSS）。

---

## 开源协议

基于 [MIT 协议](./LICENSE) 开源，欢迎提 PR 补充 WidgetKit、AppIntents、RealityKit、FoundationModels、Metal、CloudKit 等更多 Apple 框架规则。
