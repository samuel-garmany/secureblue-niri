# secureblue-niri &nbsp; [![bluebuild build badge](https://github.com/samuel-garmany/secureblue-niri/actions/workflows/build.yml/badge.svg)](https://github.com/samuel-garmany/secureblue-niri/actions/workflows/build.yml)

The operating system image I run on my desktop: a
[niri](https://github.com/niri-wm/niri) + [noctalia](https://docs.noctalia.dev/)
desktop on top of [secureblue](https://secureblue.dev)'s `sericea-main-hardened`
image, built with [BlueBuild](https://blue-build.org).

The base is Fedora Sway Atomic, so it ships Sway's desktop set (Thunar, foot,
rofi, imv, ...) as top-level packages with no reverse dependencies. The recipe
removes the ones with a Noctalia, niri or GNOME replacement and leaves the rest
installed. Login is greetd plus noctalia-greeter; sddm stays installed but
masked.

Terra is build-time only, pinned to release 44 and limited by `includepkgs` to
the three packages Fedora does not carry (`ghostty`, `ghostty-terminfo`,
`noctalia-greeter`).

## Dotfiles

My shell, editor and desktop config, plus the Homebrew tools I install on top
of this image, are in my [dotfiles](https://github.com/samuel-garmany/dotfiles)
repo.

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/samuel-garmany/secureblue-niri:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/samuel-garmany/secureblue-niri:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/samuel-garmany/secureblue-niri
```
