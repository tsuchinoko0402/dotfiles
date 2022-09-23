# dotfiles

各種設定ファイルを保管しておくためのリポジトリ。
[homeshick](https://github.com/andsens/homeshick) を利用することが前提で管理している。

## 導入方法

`homeshick` が未導入の場合は導入する。以下、zsh を使っている場合：

```shell
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.zshrc
source .zshrc
```

導入したら、以下のコマンドでリポジトリを取得：

```shell
homeshick clone tsuchinoko0402/dotfiles
```

自動的にホームディレクトリにシンボリックリンクを張ってくれる。

## 追加方法

dotfile を追加するには以下：

```shell
homeshick track dotfiles [追加するファイル1], [追加するファイル2],... 
```

## 個別設定

### neovim

最初にインストールする際は、 `.config/nvim/` 配下に入り、以下を実行する：

```shell
sh ./installer.sh ./dein
```

### Brewfile

Homebrew で新たにパッケージをインストールしたら、 `brew bundle dump --global --force` を実行して `.Brewfile` の内容を更新する