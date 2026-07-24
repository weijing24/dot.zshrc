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
export FZF_BASE="${FZF_BASE:-$(command -v fzf)}"
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
alias surgeconfig="vim ~/Dropbox/Apps/Surge\ Profiles/jim-surge.conf"
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
