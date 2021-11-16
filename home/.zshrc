# スクリプトファイルへのパス通し
export PATH=$PATH:~/bin

# 環境変数
export LANG=ja_JP.UTF-8
export XDG_BASE_HOME='~/.config'

# OCaml の設定
eval $(opam env)

# 色を使用出来るようにする
autoload -Uz colors
colors

# 色の定義
local DEFAULT=$'%{e[m%}'$
local RED=$'%{e[1;31m%}'$
local GREEN=$'%{e[1;32m%}'$
local YELLOW=$'%{e[1;33m%}'$
local BLUE=$'%{e[1;34m%}'$
local PURPLE=$'%{e[1;35m%}'$
local LIGHT_BLUE=$'%{e[1;36m%}'$
local WHITE=$'%{e[1;37m%}'$
 
# emacs 風キーバインドにする
bindkey -e
 
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
 
# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
PROMPT="%{${fg[yellow]}%}[%n@%m]%{${reset_color}%} %~
$ "

PROMPT2='[%n]> '
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"

# setopt correctしてるときに使われるプロンプト。
# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
 
# nvm の設定
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

########################################
# 補完
# for zsh-completions
########################################
fpath=(/usr/local/share/zsh-completions $fpath)

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
 
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

########################################
# vcs_info
########################################
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
 
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
 
function _update_vcs_info_msg() {
LANG=en_US.UTF-8 vcs_info
RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

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
alias la='ls -a'
alias ll='ls -l'
 
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

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
# Mac
alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
# Linux
alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
# Cygwin
alias -g C='| putclip'
fi
 
########################################
# OS 別の設定
########################################
case ${OSTYPE} in
darwin*)
#Mac用の設定
export CLICOLOR=1
alias ls='ls -G -F'
;;
linux*)
#Linux用の設定
alias ls='ls -F --color=auto'
;;
esac

#########################################
# autojump
#########################################

[[ -s /Users/shogo-okazaki/.autojump/etc/profile.d/autojump.sh ]] && source /Users/shogo-okazaki/.autojump/etc/profile.d/autojump.sh

#########################################
# zsh-autosuggestions
#########################################
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#########################################
# homeshick の設定
#########################################
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
