# スクリプトファイルへのパス通し
export PATH=$PATH:~/bin

# 環境変数
export LANG=ja_JP.UTF-8
export XDG_BASE_HOME='~/.config'

# OCaml の設定
eval $(opam env)

# nvm の設定
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

########################################
# 補完
# for zsh-completions
########################################
fpath=(/usr/local/share/zsh-completions $fpath)
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi
 
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
 
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
 
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# 補完候補を矢印キーなどで選択出来るようにする。'select=3'のように指定した場合は、補完候補が3個以上ある時に選択出来るようになる。
zstyle ':completion:*:default' menu select

#=============================
# source auto-fu.zsh
#=============================
if [ -f ~/.zsh/auto-fu.zsh/auto-fu.zsh ]; then
    source ~/.zsh/auto-fu.zsh/auto-fu.zsh
    function zle-line-init () {
	auto-fu-init
	}
    zle -N zle-line-init
    zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate
fi

# auto-fu.zsh での動作をちょっと変えるパッチ
# delete unambiguous prefix when accepting line
function afu+delete-unambiguous-prefix () {
    afu-clearing-maybe
    local buf; buf="$BUFFER"
    local bufc; bufc="$buffer_cur"
    [[ -z "$cursor_new" ]] && cursor_new=-1
    [[ "$buf[$cursor_new]" == ' ' ]] && return
    [[ "$buf[$cursor_new]" == '/' ]] && return
    ((afu_in_p == 1)) && [[ "$buf" != "$bufc" ]] && {
	there are more than one completion candidates
	zle afu+complete-word
	[[ "$buf" == "$BUFFER" ]] && {
	    the completion suffix was an unambiguous prefix
	    afu_in_p=0; buf="$bufc"
	}
	BUFFER="$buf"
	buffer_cur="$bufc"
    }
}
zle -N afu+delete-unambiguous-prefix
function afu-ad-delete-unambiguous-prefix () {
    local afufun="$1"
    local code; code=$functions[$afufun]
    eval "function $afufun () { zle afu+delete-unambiguous-prefix; $code }"
}
afu-ad-delete-unambiguous-prefix afu+accept-line
afu-ad-delete-unambiguous-prefix afu+accept-line-and-down-history
afu-ad-delete-unambiguous-prefix afu+accept-and-hold
# 「-azfu-」を表示させない
zstyle ':auto-fu:var' postdisplay $''

########################################
# zplug
########################################
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# 過去に入力したコマンドの履歴が灰色のサジェストで出る
zplug "zsh-users/zsh-autosuggestions", defer:2
# コマンド入力途中で上下キー押したときの過去履歴がいい感じに出るようになる
zplug "zsh-users/zsh-history-substring-search"
# 補完強化
zplug "zsh-users/zsh-completions"
# 256色表示にする
zplug "chrissicool/zsh-256color"

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

# exa 関連
if [[ $(command -v exa) ]]; then
  alias e='exa --icons --git'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons --git'
  alias la=ea
  alias ee='exa -aahl --icons --git'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
  alias l='clear && ls'
fi

#########################################
# homeshick の設定
#########################################
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

export PATH="/usr/local/opt/libpq/bin:$PATH"

# Starship
eval "$(starship init zsh)"