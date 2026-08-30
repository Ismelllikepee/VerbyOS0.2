#!/bin/bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
log(){ printf '\n=== %s ===\n' "$*"; }
trap 'echo "BUILD ERROR: line $LINENO: $BASH_COMMAND" >&2' ERR
[[ $EUID -eq 0 ]] || { echo "Run as root (sudo ./build.sh)." >&2; exit 1; }
command -v lb >/dev/null || { echo "Missing live-build. Install live-build and rerun." >&2; exit 1; }
command -v xorriso >/dev/null || { echo "Missing xorriso. Install xorriso and rerun." >&2; exit 1; }

log "Building VerbyOS"
rm -f VerbyOS.iso VerbyOS.iso.sha256
log "Preparing live-build configuration"
if [[ ! -d config ]]; then echo "Missing config directory" >&2; exit 1; fi

log "Installing desktop and system packages"
# live-build reads config/package-lists and config/includes.chroot automatically.

log "Building ISO"
lb clean --purge >/dev/null 2>&1 || true
./config/auto/config
lb build

log "Verifying ISO"
ISO="$(find . -maxdepth 1 -type f -name '*.iso' -print -quit)"
[[ -n "$ISO" ]] || { echo "No ISO produced." >&2; exit 1; }
mv -f "$ISO" VerbyOS.iso
xorriso -indev VerbyOS.iso -toc >/tmp/verbyos-xorriso.txt 2>&1 || { cat /tmp/verbyos-xorriso.txt; exit 1; }
sha256sum VerbyOS.iso > VerbyOS.iso.sha256
ls -lh VerbyOS.iso VerbyOS.iso.sha256
log "VerbyOS ISO built successfully"
