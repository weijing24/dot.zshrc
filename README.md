# dot.zshrc

Active zsh configuration (symlinked as `~/.zshrc`):

| File | Role |
|------|------|
| `zshrc_zi` | Main config (Zi plugin manager + p10k) |
| `path.zsh` | Cross-platform PATH builder |
| `env-alias.zshrc` | Env vars, aliases, and small utilities |

## Historical configs

Older plugin-manager configs (`zshrc_antigen`, `zshrc_ohmyzsh`, `zshrc_zinit`) live on the `archive` branch and are no longer maintained on `master`.

- **antigen** — short-lived; no async loading
- **oh-my-zsh** — became slow as plugins grew
- **zinit** — async and solid, but steep learning curve; upstream was discontinued (community fork exists)
