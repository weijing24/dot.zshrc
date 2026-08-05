# dot.zshrc

Active zsh configuration (symlinked as `~/.zshrc`):

| File | Role |
|------|------|
| `zshrc_zi` | Main config (Zi plugin manager + p10k) |
| `path.zsh` | Cross-platform PATH builder |
| `env-alias.zshrc` | Env vars, aliases, and small utilities |
| `p10k.zsh` | Powerlevel10k prompt (MacBook lean theme) |

### Powerlevel10k

- **MacBook:** `p10k.zsh` in this repo (wizard lean theme). Symlink as `~/.p10k.zsh`:

  ```bash
  ln -sf ~/github/dot.zshrc/p10k.zsh ~/.p10k.zsh
  ```

- **Servers (jp01/jp02/…):** server prompt lives in [`oracle-infra` `bootstrap/p10k.zsh`](https://gitlab.com/wjwjwj/oracle-infra); `install-zshrc.sh` installs it to `~/.p10k.zsh`. Do **not** put server p10k in this repo.
- `zshrc_zi` sources `~/.p10k.zsh` when present (same path on Mac and Linux).

## Historical configs

Older plugin-manager configs (`zshrc_antigen`, `zshrc_ohmyzsh`, `zshrc_zinit`) live on the `archive` branch and are no longer maintained on `master`.

- **antigen** — short-lived; no async loading
- **oh-my-zsh** — became slow as plugins grew
- **zinit** — async and solid, but steep learning curve; upstream was discontinued (community fork exists)

## Pre-commit secret scan

Staged changes are scanned by [gitleaks](https://github.com/gitleaks/gitleaks) via `.githooks/pre-commit` (`gitleaks git --staged`).

```bash
git config core.hooksPath .githooks    # once per clone
```

If `gitleaks` is not on `PATH`, the hook downloads a **pinned** binary (`v8.30.1`) for the current OS/arch from GitHub Releases into `~/.cache/gitleaks/8.30.1/` (or `$XDG_CACHE_HOME/gitleaks/8.30.1/`). Examples:

| Platform | Asset |
|----------|--------|
| Ubuntu x86_64 | `gitleaks_8.30.1_linux_x64.tar.gz` |
| macOS Apple Silicon | `gitleaks_8.30.1_darwin_arm64.tar.gz` |
| Linux arm64 | `gitleaks_8.30.1_linux_arm64.tar.gz` |

A system install (`brew install gitleaks`, etc.) is preferred when present.

- False positive on one line: append `# gitleaks:allow`
- Emergency bypass: `SKIP_SECRET_SCAN=1 git commit ...` or `git commit --no-verify`
