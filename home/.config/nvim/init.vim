"必ず最初に書く（vi互換コードを解除）
set nocompatible
"init.vimを保存したら自動反映
autocmd BufWritePost ~/.config/nvim/init.vim so ~/.config/nvim/init.vim

"------------------------------------
" 背景色をターミナルの背景色に揃える
"------------------------------------
highlight Normal ctermbg=NONE guibg=NONE  "setting the backgroud color to transparent.

"------------------------------------
" 表示に関する設定
"------------------------------------
"行番号を表示
set number
"検索した文字をハイライトする
set hls
"カーソル行をハイライト
set cursorline
" 不可視文字を表示
set list
" 不可視文字の表示記号指定
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start
" 対応する括弧を強調表示
set showmatch
" ステータス行を常に表示
set laststatus=2
" メッセージ表示欄を2行確保
set cmdheight=2

"------------------------------------
" カーソル移動関連の設定
"------------------------------------
" Backspaceキーの影響範囲に制限を設けない
set backspace=indent,eol,start
" 行頭行末の左右移動で行をまたぐ
set whichwrap=b,s,h,l,<,>,[,]
" 上下8行の視界を確保
set scrolloff=8
" 左右スクロール時の視界を確保
set sidescrolloff=16
" 左右スクロールは一文字づつ行う
set sidescroll=1

"------------------------------------
" ファイル処理関連の設定
"------------------------------------
" 保存されていないファイルがあるときは終了前に保存確認
set confirm
" 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set hidden
"外部でファイルに変更がされた場合は読みなおす
set autoread
" ファイル保存時にバックアップファイルを作らない
set nobackup
" ファイル編集中にスワップファイルを作らない
set noswapfile

"------------------------------------
" 検索/置換の設定
"------------------------------------
" 検索文字列をハイライトする
set hlsearch
" インクリメンタルサーチを行う
set incsearch
" 大文字と小文字を区別しない
set ignorecase
" 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set smartcase
" 最後尾まで検索を終えたら次の検索で先頭に移る
set wrapscan
" 置換の時 g オプションをデフォルトで有効にする
set gdefault

"------------------------------------
" 編集に関する設定
"------------------------------------
"エンコーディング
set encoding=utf-8
scriptencoding utf-8
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
" 自動でカッコ等を閉じる
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

"------------------------------------
" 動作環境との統合関連の設定
"------------------------------------
"ヤンクするとクリップボードに保存される
set clipboard+=unnamed
" マウスの入力を受け付ける
set mouse=a
" Windows でもパスの区切り文字を / にする
set shellslash

"------------------------------------
" コマンドラインの設定
"------------------------------------
" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full
" コマンドラインの履歴を10000件保存する
set history=10000

"------------------------------------
" ビープの設定
"------------------------------------
"ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

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
" coc.vim の設定
"------------------------------------
"LightLineにcoc.nvimのステータスを載せる
let g:lightline = {
  \'active': {
    \'right': [
      \['coc']
    \]
  \},
  \'component_function': {
    \'coc': 'coc#status'
  \}
\}

"Diagnosticsの、左横のアイコンの色設定
highlight CocErrorSign ctermfg=15 ctermbg=196
highlight CocWarningSign ctermfg=0 ctermbg=172

"以下ショートカット
"ノーマルモードで
"スペース2回でCocList
nmap <silent> <space><space> :<C-u>CocList<cr>
"スペースhでHover
nmap <silent> <space>h :<C-u>call CocAction('doHover')<cr>
"スペースdfでDefinition
nmap <silent> <space>df <Plug>(coc-definition)
"スペースrfでReferences
nmap <silent> <space>rf <Plug>(coc-references)
"スペースrnでRename
nmap <silent> <space>rn <Plug>(coc-rename)
"スペースfmtでFormat
nmap <silent> <space>fmt <Plug>(coc-format)
"スペースgyでTypeDefinition
nmap <silent> <space>gy <Plug>(coc-type-definition)
" スペースgiでImplementation
nmap <silent> <space>gi <Plug>(coc-implementation)

"------------------------------------
" Telescope の設定
"------------------------------------
" ctrl + p で find_files
nnoremap <C-p> <cmd>Telescope find_files<cr>
" ctrl + g で live_grep
nnoremap <C-g> <cmd>Telescope live_grep<cr>
" ctrl + f で全ファイルから grep
nnoremap <C-f> <cmd>Telescope frecency<cr>

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
