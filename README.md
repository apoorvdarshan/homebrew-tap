# Apoorv Darshan's Homebrew Tap

Homebrew packages for open-source apps and tools by
[Apoorv Darshan](https://github.com/apoorvdarshan).

## Install

Install a package directly; Homebrew adds the tap automatically:

```bash
brew install apoorvdarshan/tap/crossposter
brew install --cask apoorvdarshan/tap/tethershot
brew install --cask apoorvdarshan/tap/browser-cookie-bridge
```

Crossposter installs a production Node.js CLI and supports
`brew services start crossposter`. Its publishing data remains outside the
Homebrew prefix. Both Casks install their application into `/Applications` and
use immutable GitHub Release assets with SHA-256 verification.

## Upgrade

```bash
brew update
brew upgrade crossposter
brew upgrade --cask --greedy tethershot browser-cookie-bridge
```

The apps also include their own signed update checkers. Homebrew marks them as
self-updating Casks, so `--greedy` includes them in an explicit Homebrew
upgrade.

## Uninstall

```bash
brew uninstall crossposter
brew uninstall --cask tethershot
```

Use `--zap` only when you also want to remove local preferences and support
files:

```bash
brew uninstall --zap --cask browser-cookie-bridge
```

## Maintenance

The tap checks upstream npm and GitHub releases every six hours and updates
Formula/Cask versions and SHA-256 digests when a stable release changes. Every
push is audited with Homebrew's style, audit, livecheck, and runtime tests.

- [Crossposter](https://github.com/apoorvdarshan/crossposter)
- [TetherShot](https://github.com/apoorvdarshan/TetherShot)
- [Browser Cookie Bridge](https://github.com/apoorvdarshan/browser-cookie-bridge)
