# 環境変数
export LANG=ja_JP.UTF-8
export XDG_BASE_HOME='~/.config'

# OCaml の設定
eval $(opam env)

# nvm の設定
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# ヒストリー機能
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

########################################
# 補完を有効化する（カーソルで選択できるように）
########################################
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1

########################################
# zplug
########################################
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh

# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# 過去に入力したコマンドの履歴が灰色のサジェストで出る
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions", defer:2
# 補完強化
zplug "zsh-users/zsh-completions"
# コマンド入力途中で上下キー押したときの過去履歴がいい感じに出るようになる
zplug "zsh-users/zsh-history-substring-search"
# 256色表示にする
zplug "chrissicool/zsh-256color"

# インストールしていないプラグインがあればインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose

########################################
# オプション
########################################
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド
########################################
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
 
########################################
# エイリアス
######################################## 
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# vim で nvim 呼び出し
alias vim='nvim'

# 矢印キーを使える OCaml の立ち上げ
alias ocaml='rlwrap ocaml'

# lsd 関連
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

#########################################
# homeshick の設定
#########################################
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# Starship
eval "$(starship init zsh)"

#########################################
# pyenv の設定
#########################################
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

#########################################
# nodebrew の設定
#########################################
export PATH=$HOME/.nodebrew/current/bin:$PATH

# bun
export BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Created by `userpath` on 2024-06-20 14:50:41
export PATH="$PATH:/Users/shogo/Library/Application Support/hatch/pythons/3.12/python/bin"
