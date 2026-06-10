####################################################################
#  PATH builder — single source of truth, cross-platform           #
#  (macOS + Linux). Lives in the shared dot.zshrc git repo so the   #
#  same logic reaches every host.                                   #
#                                                                   #
#  Sourced from:                                                    #
#    - ~/.zshrc (zshrc_zi)  : both OSes; on macOS this runs AFTER   #
#                             /etc/zprofile's path_helper, so our   #
#                             order wins on login shells.           #
#    - macOS ~/.zshenv      : also, so non-interactive shells get   #
#                             PATH (Ubuntu has no ~/.zshenv).        #
#                                                                   #
#  To change PATH, edit ONLY the `wanted` list (highest priority    #
#  first). Missing dirs and the wrong-OS Homebrew prefix are        #
#  skipped, so the same file is safe on macOS and Ubuntu.           #
####################################################################

typeset -gU path PATH   # keep PATH de-duplicated; makes re-invocation idempotent

_zsh_build_path() {
    local brew_prefix i
    for brew_prefix in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
        [[ -x $brew_prefix/bin/brew ]] && break || brew_prefix=""
    done
    local -a wanted=(
        $HOME/.local/bin
        ${brew_prefix:+$brew_prefix/opt/grep/libexec/gnubin}   # GNU grep (macOS only)
        $HOME/.tgenv/bin
        $HOME/.tfenv/bin
        $SNIPPETS_PATH
        ${brew_prefix:+$brew_prefix/bin}
        ${brew_prefix:+$brew_prefix/sbin}
    )
    for (( i = ${#wanted}; i > 0; i-- )); do
        [[ -n ${wanted[i]} && -d ${wanted[i]} ]] && path=( ${wanted[i]} $path )
    done
}
