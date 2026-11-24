#!/usr/bin/env bash
# One-shot setup for the Desktop Clock plugin. Safe to re-run.
#   1. Install the Nunito font (ttf-nunito)
#   2. Restart the shell if the font is new (Quickshell loads fonts at startup)
#   3. Turn the clock on
set -euo pipefail

ID="dev.desktop-clock"
SHELL_JSON="$HOME/.config/omarchy/shell.json"
HERE="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
ok()   { printf '    \033[32m✓\033[0m %s\n' "$*"; }
die()  { printf '\n\033[31mError:\033[0m %s\n' "$*" >&2; exit 1; }

[ "$(id -u)" -ne 0 ] || die "run as your normal user, not root"
command -v omarchy >/dev/null || die "this script expects an Omarchy system"
[ -f "$HERE/manifest.json" ] || die "run this from the plugin folder (install with: omarchy plugin add <repo-url>)"

step "Installing the Nunito font"
restart=0
if fc-list : family | grep -i '^Nunito' >/dev/null; then
  ok "Nunito already installed"
else
  omarchy pkg add ttf-nunito
  fc-cache -f >/dev/null 2>&1 || true
  restart=1
  ok "installed ttf-nunito"
fi

if [ "$restart" -eq 1 ]; then
  step "Restarting the shell so it picks up the font"
  omarchy restart shell
  for _ in $(seq 1 20); do omarchy-shell shell ping >/dev/null 2>&1 && break; sleep 1; done
  omarchy-shell shell ping >/dev/null 2>&1 || die "the shell didn't come back; run: omarchy restart shell"
  ok "shell restarted"
fi

step "Turning on the clock"
if [ -f "$SHELL_JSON" ] && jq -e --arg id "$ID" 'any(.plugins[]?; .id == $id)' "$SHELL_JSON" >/dev/null 2>&1; then
  ok "already on"
else
  omarchy plugin enable "$ID"
  ok "enabled"
fi

step "Done"
echo "    The clock is in the bottom-right corner of the desktop on every monitor."
