# Archived zsh configs

This branch keeps historical plugin-manager configs that are **no longer used**.
Active configuration lives on `master` (`zshrc_zi`, `path.zsh`, `env-alias.zshrc`).

## Files

| File | Plugin manager | Why it was dropped |
|------|----------------|--------------------|
| `zshrc_ohmyzsh` | Oh My Zsh | Startup got slow as more plugins were added; every new terminal paid the cost. |
| `zshrc_antigen` | Antigen | Short-lived experiment; no async loading, so open-to-prompt latency stayed high. |
| `zshrc_zinit` | Zinit (zdharma) | Async and capable, but a steep learning curve. Upstream deleted the original repo and discontinued the project; a community fork continues, but this tree was abandoned in favor of Zi. |

## Timeline (rough)

1. **oh-my-zsh** — first daily driver  
2. **antigen** — brief try for cleaner plugin declarations  
3. **zinit** — async loading, best of the three for speed/flexibility  
4. **zi** (`master` / `zshrc_zi`) — current setup; easier docs than zinit for day-to-day use  

Do not symlink these files as `~/.zshrc` unless you are deliberately recovering an old environment.
