eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(pyenv init -)"

export PATH="$(pyenv root)/shims:$N_PREFIX/bin:/Users/alexanderlee/.local/bin:/opt/homebrew/opt/libiconv/bin:$PATH"

