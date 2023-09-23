export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:~/bin
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

. "$HOME/.cargo/env"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
eval "$(/opt/homebrew/bin/brew shellenv)"
