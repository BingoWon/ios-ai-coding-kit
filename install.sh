#!/bin/sh
# Safe, zero-dependency installer for ios-ai-coding-kit
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh
#   curl -fsSL https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main/install.sh | sh -s -- --cursor --claude --mcp
set -eu

REPO_RAW="https://raw.githubusercontent.com/BingoWon/ios-ai-coding-kit/main"
DO_CURSOR=0
DO_CLAUDE=0
DO_CODEX=0
DO_COPILOT=0
DO_SKILL=0
DO_MCP=0
DO_CHECKLIST=0
FORCE=0
ANY_FLAG=0

for arg in "$@"; do
  case "$arg" in
    --cursor) DO_CURSOR=1; ANY_FLAG=1 ;;
    --claude) DO_CLAUDE=1; ANY_FLAG=1 ;;
    --codex) DO_CODEX=1; ANY_FLAG=1 ;;
    --copilot) DO_COPILOT=1; ANY_FLAG=1 ;;
    --skill) DO_SKILL=1; ANY_FLAG=1 ;;
    --mcp) DO_MCP=1; ANY_FLAG=1 ;;
    --checklist) DO_CHECKLIST=1; ANY_FLAG=1 ;;
    --all)
      DO_CURSOR=1; DO_CLAUDE=1; DO_CODEX=1; DO_COPILOT=1; DO_SKILL=1; DO_MCP=1; DO_CHECKLIST=1; ANY_FLAG=1
      ;;
    --force) FORCE=1 ;;
    -h|--help)
      cat <<'EOF'
ios-ai-coding-kit installer

Flags (default: --all):
  --all        Install rules for Cursor, Claude Code, Codex, Copilot, Skill, .mcp.json, and checklist
  --cursor     Install .cursor/rules/*.mdc
  --claude     Install CLAUDE.md
  --codex      Install AGENTS.md
  --copilot    Install .github/copilot-instructions.md
  --skill      Install skills/apple-dev-docs/SKILL.md
  --mcp        Install .mcp.json (zero-key Apple RAG MCP)
  --checklist  Install checklists/app-store-preflight.md
  --force      Overwrite existing files (default: skip existing files safely)
EOF
      exit 0
      ;;
    *)
      echo "Unknown option: $arg (use --help)" >&2
      exit 2
      ;;
  esac
done

if [ "$ANY_FLAG" -eq 0 ]; then
  DO_CURSOR=1; DO_CLAUDE=1; DO_CODEX=1; DO_COPILOT=1; DO_SKILL=1; DO_MCP=1; DO_CHECKLIST=1
fi

install_file() {
  rel="$1"
  if [ -e "$rel" ] && [ "$FORCE" -eq 0 ]; then
    echo "  skip  $rel (already exists; pass --force to overwrite)"
    return
  fi
  dir=$(dirname "$rel")
  [ "$dir" != "." ] && mkdir -p "$dir"
  curl -fsSL "$REPO_RAW/$rel" -o "$rel"
  echo "  write $rel"
}

echo "Installing ios-ai-coding-kit into $(pwd)..."

if [ "$DO_CURSOR" -eq 1 ]; then
  install_file ".cursor/rules/01-swift6-concurrency.mdc"
  install_file ".cursor/rules/02-swiftui-modern.mdc"
  install_file ".cursor/rules/03-storekit2-swiftdata.mdc"
  install_file ".cursor/rules/04-apple-docs-verification.mdc"
fi
[ "$DO_CLAUDE" -eq 1 ] && install_file "CLAUDE.md"
[ "$DO_CODEX" -eq 1 ] && install_file "AGENTS.md"
[ "$DO_COPILOT" -eq 1 ] && install_file ".github/copilot-instructions.md"
[ "$DO_SKILL" -eq 1 ] && install_file "skills/apple-dev-docs/SKILL.md"
[ "$DO_MCP" -eq 1 ] && install_file ".mcp.json"
[ "$DO_CHECKLIST" -eq 1 ] && install_file "checklists/app-store-preflight.md"

echo ""
echo "Done! Reload your AI coding client to pick up the new rules and MCP tools."
echo "Live Apple docs change radar: https://apple-rag.com/updates"
