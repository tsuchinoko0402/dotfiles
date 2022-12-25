"バックアップファイルを作らない
set nobackup 
"スワップファイルを作らない
set noswapfile 
"init.vimを保存したら自動反映
autocmd BufWritePost  ~/.config/nvim/init.vim  so ~/.config/nvim/init.vim
"エンコーディング
set encoding=utf-8
scriptencoding utf-8
"ヤンクするとクリップボードに保存される
set clipboard+=unnamed
"必ず最初に書く（vi互換コードを解除）
set nocompatible
"行番号を表示
set number
"改行時に自動でインデントする
set autoindent
"タブを何文字の空白に変換するか
set tabstop=2
"自動インデント時に入力する空白の数
set shiftwidth=2
"タブ入力を空白に変換
set expandtab
"画面を縦分割する際に右に開く
set splitright
"検索した文字をハイライトする
set hls
"カーソル行をハイライト
set cursorline
" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start
" 自動でカッコ等を閉じる
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

"------------------------------------
" ステータスバーの表示変更
"------------------------------------
" タブラインも表示
let g:airline#extensions#tabline#enabled = 1

"" vim-airline
" ステータスラインに表示する項目を変更する
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ ['z']
  \ ]
let g:airline_section_c = '%t %M'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
" 変更がなければdiffの行数を表示しない
let g:airline#extensions#hunks#non_zero_only = 1 

" タブラインの表示を変更する
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_close_button = 0

"------------------------------------
" Fern（ファイルツリーの表示）
"------------------------------------
" 隠しファイルを表示Show hidden files
let g:fern#default_hidden=1

" Ctrl+nでファイルツリーを表示/非表示するShow file tree with Ctrl+n
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>

"------------------------------------
" Git 操作
"------------------------------------
" g]で前の変更箇所へ移動する
nnoremap g[ :GitGutterPrevHunk<CR>
" g[で次の変更箇所へ移動する
nnoremap g] :GitGutterNextHunk<CR>
" ghでdiffをハイライトする
nnoremap gh :GitGutterLineHighlightsToggle<CR>
" gpでカーソル行のdiffを表示する
nnoremap gp :GitGutterPreviewHunk<CR>
" 記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red

"" 反映時間を短くする(デフォルトは4000ms)
set updatetime=250

"------------------------------------
" dein.vim の設定
"------------------------------------
let s:dein_dir = expand('$HOME/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &compatible
    set nocompatible               " Be iMproved
endif
" dein.vimがない場合githubからDL
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" 設定開始
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    " プラグインリスト(toml)
    let g:rc_dir    = expand('$HOME/.config/nvim')
    let s:toml      = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
    " tomlのロード
    call dein#load_toml(s:toml,      {'lazy':0})
    call dein#load_toml(s:lazy_toml, {'lazy':1})
    " 設定終了
    call dein#end()
    call dein#save_state()
endif
" Required:
filetype plugin indent on
syntax enable
" 未インストールがあればインストール
if dein#check_install()
    call dein#install()
endif
