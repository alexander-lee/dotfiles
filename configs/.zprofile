eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(pyenv init -)"

export PATH="$(pyenv root)/shims:$N_PREFIX/bin:$HOME/.poetry/bin:$PATH"
export PQ_LIB_DIR="$(brew --prefix postgresql)/lib"

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
