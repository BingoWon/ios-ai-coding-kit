# iOS / macOS AI Engineering Guide (Claude Code)

Follow these standards whenever creating, refactoring, or debugging Swift, SwiftUI, UIKit, or Apple SDK code in this project.

## 1. Grounded Apple Documentation First
- Never invent unfamiliar SwiftUI, UIKit, Foundation, SwiftData, StoreKit 2, WidgetKit, AppIntents, RealityKit, or new OS release APIs from memory.
- If an Apple documentation MCP or CLI tool is configured (such as `apple-rag-mcp` via `.mcp.json` or `apple-rag-cli`), verify unfamiliar symbols, availability, and WWDC guidance before editing:
  1. `search` for API signatures, deprecations, and WWDC migration advice.
  2. `browse` to explore official SwiftUI / UIKit topic hierarchies instead of guessing URLs.
  3. `fetch` canonical `developer.apple.com` pages when you need full code samples and OS availability.
- If no Apple documentation MCP or CLI is connected, consult local Xcode SDK headers or official Apple Developer documentation via web search/fetch — or ask the user for access before generating code dependent on an unfamiliar API.
- Always cite canonical `developer.apple.com` URLs when resolving version-sensitive behavior.

## 2. Swift 6 Strict Concurrency
- Target warning-free compilation under Swift 6 strict concurrency (`complete`).
- Isolate UI models and SwiftUI observable stores with `@MainActor`.
- Prefer structured concurrency (`async let`, `withTaskGroup`, `.task(id:)`) over `Task.detached`.
- Never silence data-race errors with `nonisolated(unsafe)` or `@unchecked Sendable` unless synchronization is explicitly implemented and documented.
- Pass immutable `Sendable` value types or `PersistentIdentifier` across actor boundaries — never pass non-`Sendable` `@Model` or `NSManagedObject` instances across threads.

## 3. Modern SwiftUI Conventions
- Use `@Observable` (Observation framework) with `@State` / `@Bindable` on iOS 17+ / macOS 14+ instead of `ObservableObject` / `@Published` / `@StateObject`.
- Use `NavigationStack` / `NavigationSplitView` instead of deprecated `NavigationView`.
- Prefer `.foregroundStyle`, `.clipShape(.rect(cornerRadius:))`, two-parameter `.onChange(of:initial:_:)`, `ContentUnavailableView`, and `Button` (over `.onTapGesture`).
- Keep `body` concise (< 60 lines); extract cohesive subviews. Never run I/O or network calls inside `init` or `body`.
- Guard newer SDK APIs with `if #available(...)` when supporting older deployment targets.

## 4. StoreKit 2 & SwiftData Hygiene
- Use StoreKit 2 (`Product`, `Transaction.currentEntitlements`, `Transaction.updates`) and always start listening to `Transaction.updates` at app launch; call `await transaction.finish()` only after granting verified entitlements.
- Always ship a visible **Restore Purchases** (`AppStore.sync()`) and **Manage Subscription** action.
- Use SwiftData `VersionedSchema` + `SchemaMigrationPlan` for production models, and `@ModelActor` for background persistence work.

## 5. Verification Before Finishing
- Check build/compile errors (using Xcode or `xcrun mcpbridge` when available), Dark Mode & Light Mode contrast, Dynamic Type safety, and `checklists/app-store-preflight.md` before release builds.
