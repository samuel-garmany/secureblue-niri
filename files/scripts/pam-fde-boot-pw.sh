#!/usr/bin/bash
set -euo pipefail

COMMIT=49bf498fd8d13f73e4a24221818a8a5d2af20088
DEPS=(pam-devel keyutils-libs-devel)
SRC=$(mktemp -d)

dnf install -y "${DEPS[@]}"

git clone -q https://git.sr.ht/~kennylevinsen/pam_fde_boot_pw "$SRC"
git -C "$SRC" -c advice.detachedHead=false checkout -q "$COMMIT"

gcc -shared -fPIC -O2 -o /usr/lib64/security/pam_fde_boot_pw.so "$SRC/main.c" -lpam -lkeyutils

dnf remove -y "${DEPS[@]}"
rm -rf "$SRC"
