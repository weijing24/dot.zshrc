####################################################
#                   ENV                            #
####################################################

# ZSH config
HISTSIZE=10000000
SAVEHIST=10000000
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
# # https://stackoverflow.com/questions/11670935/comments-in-command-line-zsh/11873793#11873793
# setopt interactivecomments
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3,bold,underline'
ZSH_AUTOSUGGEST_USE_ASYNC=1
DISABLE_AUTO_TITLE="true"
# system env
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export DISABLE_MAGIC_FUNCTIONS=true
export EDITOR="vim"
export AWS_PAGER=""
# fzf config
export FZF_BASE=/usr/local/bin/fzf
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
export PATH="$HOME/.tgenv/bin:/opt/homebrew/bin:$PATH"
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

####################################################
#                  alias                           #
####################################################
alias vim="code"
alias zshconfig="vim ~/.zshrc"
alias sshconfig="vim ~/.ssh/config"
alias aliasconfig="vim ~/github/dot.zshrc/env-alias.zshrc"
alias miscconfig="vim ~/github/macdotfiles/misc.zsh"
alias envconfig="vim ~/.zshenv"
alias awsconfig="vim ~/.aws/credentials"
alias his="history -i"
alias wget="wget -c "
alias rgf="rg --no-heading --files | rg"
alias cat="bat"
alias cp="rsync -aP"
alias rm="rm -i"
alias src="zi delete env-alias -y && zi delete code-snippet -y && exec zsh"
alias tg-clean-cache='find . -type d \( -name ".terragrunt-cache" -o -name ".terraform" \) -prune -exec rm -rf {} \;'
alias fzf="fzf-tmux -p 80% --cycle"
alias t=tmux
# alias vimpluginstall="vim +PlugInstall! +qa!"
# alias vimplugupdate="vim +PlugUpdate! +qa!"
# alias vimplugclean="vim +PlugClean! +qa!"
# alias vimplugupgrade="vim +PlugUpgrade! +qa!"
# alias lock="m lock"
# alias gop="git remote prune origin"
# alias tf="terraform"
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
