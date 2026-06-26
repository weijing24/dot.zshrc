####################################################
#                   ENV                            #
####################################################

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3,bold,underline'
ZSH_AUTOSUGGEST_USE_ASYNC=1
DISABLE_AUTO_TITLE="true"
# system env
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export DISABLE_MAGIC_FUNCTIONS=true
export EDITOR="nvim"
export AWS_PAGER=""
# fzf config
export FZF_BASE=/opt/homebrew/bin/fzf
export FZF_DEFAULT_OPTS='
        --height 90% --multi --layout=reverse
        --bind ctrl-t:toggle-preview
        --bind alt-t:toggle-preview
        --bind ctrl-f:page-down,ctrl-b:page-up
        --preview-window "right:60%:wrap"
        --bind alt-a:toggle-all
'
        # --preview "head -100 {}"
#forgit config
export FORGIT_LOG_GRAPH_ENABLE=false
export BAT_CONFIG_PATH="$HOME/.bat.conf"
# PATH is built by ~/github/dot.zshrc/path.zsh (_zsh_build_path) — no PATH lines here.
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

####################################################
#                  alias                           #
####################################################
command -v nvim &> /dev/null && alias vim='nvim'
if command -v bat &> /dev/null; then
    alias cat='bat'
elif command -v batcat &> /dev/null; then    # Debian/Ubuntu ships `bat` as `batcat`
    alias bat='batcat'
    alias cat='batcat'
fi
alias zshconfig="vim ~/.zshrc"
alias sshconfig="vim ~/.ssh/config"
alias aliasconfig="vim ~/github/dot.zshrc/env-alias.zshrc"
alias envconfig="vim ~/.zshenv"
alias awsconfig="vim ~/.aws/credentials"
alias surgeconfig="vim ~/Dropbox/应用/Surge\ Profiles/jim-surge.conf"
alias his="history -i"
alias wget="wget -c "
alias rgf="rg --no-heading --files | rg"
alias cp="rsync -ahP"
alias rm="rm -i"
alias src="zi delete env-alias -y && zi delete code-snippet -y && exec zsh"
alias tg-clean-cache='find . -type d \( -name ".terragrunt-cache" -o -name ".terraform" \) -prune -exec rm -rf {} \;'
alias fzf="fzf-tmux -p 80% --cycle"
alias tffmt="terraform fmt"
alias tmuxconf='$EDITOR $ZSH_TMUX_CONFIG'
# alias vimpluginstall="vim +PlugInstall! +qa!"
# alias vimplugupdate="vim +PlugUpdate! +qa!"
# alias vimplugclean="vim +PlugClean! +qa!"
# alias vimplugupgrade="vim +PlugUpgrade! +qa!"
# alias lock="m lock"
# alias gop="git remote prune origin"
# alias tf="terraform"
# alias tg-clean-cache='find . -type d \( -name ".terragrunt-cache" -o -name ".terraform" \) -prune -exec rm -rf {} \;'
# alias ssh_known_list="ssh-keygen -l -f ~/.ssh/known_hosts"
# alias ssh_known_delete="ssh-keygen -R"
# alias tf_x86="cd /opt/homebrew/Cellar/tfenv/2.2.0/versions/0.13.2.1 && cp terraform_x86 terraform && cd -"
# alias tf_arm="cd /opt/homebrew/Cellar/tfenv/2.2.0/versions/0.13.2.1 && cp terraform_arm terraform && cd -"

# j() {
#     local preview_cmd="ls {2}"
#     if command -v exa &> /dev/null; then
#         preview_cmd="exa -l {2}"
#     fi

#     if [[ $# -eq 0 ]]; then
#         cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// {print $1 " " $2}' | fzf --height 90% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | awk '{print $2}')"
#     else
#         cd $(autojump $@)
#     fi
# }

####################################################
#           Utility functions                      #
####################################################

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

awsp() {
    export AWS_PROFILE="$(cat ~/.aws/credentials | grep '\[' | grep -v '#' | tr -d '[' | tr -d ']' | fzf)"
}

# Run codex against an OpenAI-compatible proxy WITHOUT touching ~/.codex.
# Your company `codex login` (auth.json / config.toml) stays untouched; this
# wires up a separate `proxy` model_provider purely via -c flags and reads the
# API key from an env var. Just export the two vars, then use `codexp` like `codex`:
#
#   export CODEX_PROXY_BASE_URL="https://host/v1"   # base that serves /models
#   export CODEX_PROXY_KEY="sk-..."
#   codexp "hello"
#   codexp exec "do something"
#
# Optional overrides:
#   CODEX_PROXY_MODEL     (default: gpt-5.5)
#   CODEX_PROXY_WIRE_API  (default: responses — codex >=0.x dropped "chat";
#                          your proxy must implement the OpenAI Responses API)
codexp() {
  emulate -L zsh
  if [[ -z "$CODEX_PROXY_BASE_URL" || -z "$CODEX_PROXY_KEY" ]]; then
    print -u2 "codexp: export CODEX_PROXY_BASE_URL and CODEX_PROXY_KEY first, e.g.
  export CODEX_PROXY_BASE_URL=\"https://host/v1\"
  export CODEX_PROXY_KEY=\"sk-...\""
    return 1
  fi
  CODEX_PROXY_KEY="$CODEX_PROXY_KEY" command codex \
    -c "model_providers.proxy.name=\"proxy\"" \
    -c "model_providers.proxy.base_url=\"$CODEX_PROXY_BASE_URL\"" \
    -c "model_providers.proxy.env_key=\"CODEX_PROXY_KEY\"" \
    -c "model_providers.proxy.wire_api=\"${CODEX_PROXY_WIRE_API:-responses}\"" \
    -c "model_provider=\"proxy\"" \
    -c "model=\"${CODEX_PROXY_MODEL:-gpt-5.5}\"" \
    "$@"
}
