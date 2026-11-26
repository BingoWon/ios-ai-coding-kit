# App Store Submission Preflight Checklist (iOS / macOS)

Run through this checklist before archiving and uploading a build to App Store Connect.

## 1. Privacy & Permissions
- [ ] Every protected capability (`Camera`, `Photo Library`, `Location`, `Microphone`, `Contacts`, `HealthKit`, `Tracking`) has a clear, user-facing `NS*UsageDescription` in `Info.plist` explaining **why** the app needs it.
- [ ] `PrivacyInfo.xcprivacy` declares required-reason APIs (`UserDefaults`, file timestamps, disk space, system boot time, active keyboards) if used by the app or any third-party SDK.
- [ ] App Store Connect Privacy Nutrition Labels match actual SDK and backend data collection.
- [ ] If the app supports account creation, it also provides an in-app **Delete Account** flow (App Store Review Guideline 5.1.1(v)).

## 2. In-App Purchases & Subscriptions (StoreKit 2)
- [ ] Prices, billing period, and auto-renewal terms are clearly stated before purchase.
- [ ] A working **Restore Purchases** button (`AppStore.sync()`) is accessible on the paywall or settings screen.
- [ ] Links to **Privacy Policy** and **Terms of Use (EULA)** are visible on the paywall and in App Store Connect metadata.
- [ ] `Transaction.updates` is observed at app launch and every verified transaction calls `transaction.finish()`.
- [ ] Tested with a StoreKit Configuration file in Xcode AND TestFlight Sandbox (purchase, renewal, cancellation, expiration, interrupted purchase).

## 3. UI, Accessibility & Device Matrix
- [ ] Tested in both **Light Mode** and **Dark Mode** — zero invisible text or hardcoded white/black backgrounds.
- [ ] Tested with larger **Dynamic Type** sizes — no truncated buttons or clipped labels.
- [ ] Tested on smallest supported iPhone screen AND iPad (if universal) without layout overflow.
- [ ] No placeholder text (`Lorem ipsum`, `TODO`, `Test`), broken links, or dead buttons remain.
- [ ] Network errors and offline states show helpful feedback with a retry action instead of an infinite spinner or blank screen.

## 4. Technical Hygiene
- [ ] Builds cleanly in **Release** configuration with Swift 6 strict concurrency enabled.
- [ ] No hardcoded API secrets, debug flags, or staging URLs bundled in the app binary.
- [ ] Minimum deployment target matches all used APIs (newer modifiers guarded with `if #available(...)`).
- [ ] App icons, launch screen, bundle identifier, version (`CFBundleShortVersionString`), and build number (`CFBundleVersion`) are finalized.
- [ ] Demo account credentials (if login is required) are included in App Store Review Notes.
