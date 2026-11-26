# GitHub Copilot Instructions — Apple Platforms (Swift 6 & SwiftUI)

When generating or editing Swift, SwiftUI, UIKit, or macOS/iOS code in this repository:

1. **Verify Apple APIs**: Never hallucinate unfamiliar Apple SDK symbols, modifiers, or minimum OS versions. Use connected Apple documentation MCP/CLI tools (e.g. `apple-rag-mcp` / `apple-rag-cli`), local Xcode SDK headers, or official `developer.apple.com` documentation before introducing unfamiliar APIs.
2. **Swift 6 Concurrency**: Target strict concurrency (`complete`). Isolate UI state with `@MainActor`, prefer structured concurrency (`async let`, `TaskGroup`, `.task`), pass `Sendable` value types across actor boundaries, and avoid `@unchecked Sendable` hacks.
3. **Modern SwiftUI**: Prefer `@Observable`, `NavigationStack`, `.foregroundStyle`, `.clipShape(.rect(cornerRadius:))`, two-parameter `.onChange(of:initial:_:)`, `ContentUnavailableView`, and `Button` over deprecated SwiftUI APIs. Keep view `body` modular (< 60 lines) and side-effect-free.
4. **StoreKit 2 & SwiftData**: Use StoreKit 2 (`Product`, `Transaction.currentEntitlements`, `Transaction.updates`) with launch-time listener + restore purchases; use SwiftData `VersionedSchema` and `@ModelActor` for safe migrations and background writes.
5. **Availability & Accessibility**: Wrap newer SDK APIs in `if #available(...)`, support Dark Mode semantic colors and Dynamic Type, and verify App Store Review essentials (privacy descriptions, `PrivacyInfo.xcprivacy`, restore purchases, account deletion).
