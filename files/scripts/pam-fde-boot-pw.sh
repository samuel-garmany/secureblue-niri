#!/usr/bin/bash
# Builds pam_fde_boot_pw to allow for keyring unlock using the luks password. This means a full login is possible with only one password.
set -euo pipefail

COMMIT=49bf498fd8d13f73e4a24221818a8a5d2af20088
DEPS=(gcc git-core meson ninja-build pam-devel keyutils-libs-devel)
SRC=$(mktemp -d)

dnf install -y --setopt=install_weak_deps=False "${DEPS[@]}"

git -C "$SRC" init -q
git -C "$SRC" remote add origin https://git.sr.ht/~kennylevinsen/pam_fde_boot_pw
git -C "$SRC" fetch -q --depth 1 origin "$COMMIT"
git -C "$SRC" -c advice.detachedHead=false checkout -q FETCH_HEAD

meson setup --prefix=/usr "$SRC/build" "$SRC"
meson install -C "$SRC/build"

dnf remove -y "${DEPS[@]}"
dnf clean all
rm -rf "$SRC"

test -f /usr/lib64/security/pam_fde_boot_pw.so
