export DOTFILES="$HOME/dotfiles"

export HISTFILE=$HOME/.zhistory  # History filepath
export HISTSIZE=10000            # Maximum events for internal history
export SAVEHIST=10000            # Maximum events in history file

export N_PREFIX=$HOME/.n
export PNPM_HOME="$HOME/Library/pnpm"

# Options
setopt HIST_SAVE_NO_DUPS
autoload -U compinit; compinit

# Completion
_comp_options+=(globdots) # With hidden files
source $DOTFILES/zsh/completion.zsh

# Plugins
fpath=($DOTFILES/zsh/plugins/zsh-completions/src $fpath)
source $DOTFILES/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Prompt
# source $DOTFILES/zsh/git-prompt.zsh
fpath=($DOTFILES/zsh/prompt $fpath)
source $DOTFILES/zsh/prompt/setup_prompt.zsh

# Aliases
source $DOTFILES/aliases/git
source $DOTFILES/aliases/commands

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

# Golang
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# LibPQ
export PQ_LIB_DIR="$(brew --prefix libpq)/lib"

# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Kill Detached tmux Sessions
tmux list-sessions | grep -v attached | cut -d: -f1 |  xargs -t -n1 tmux kill-session -t

# Start tmux upon login
[ -z "$TMUX"  ] && { exec tmux new-session; }

# pnpm
export PNPM_HOME="/Users/alexanderlee/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Mise
eval "$(mise activate)"

# Conda
export CONDA_PATH="/opt/homebrew/anaconda3/bin"
export PATH="$CONDA_PATH:$PATH"
