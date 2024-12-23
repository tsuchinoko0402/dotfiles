local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- 背景透過
config.window_background_opacity = 0.7

-- カラースキームの設定
-- config.color_scheme = 'Darcula'
config.color_scheme = "iceberg-dark"

-- 最初からフルスクリーンで起動
-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function(cmd)
--     local tab, pane, window = mux.spawn_window(cmd or {})
--     window:gui_window():toggle_fullscreen()
-- end)

-- フォントの設定
config.font = wezterm.font("HackGen Console NF", {weight="Medium", stretch="Normal", style="Normal"})

-- フォントサイズの設定
config.font_size = 14

-- IME で日本語入力できるように
config.use_ime = true

-- タイトルバー削除
config.window_decorations = "RESIZE"

-- タブが1つしかない場合に非表示
config.hide_tab_bar_if_only_one_tab = true

-- タブバーを透明にする
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

-- タブに背景色をつける
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"
  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

-- ショートカットキー設定
local act = wezterm.action

-- キーバインド
config.keys = {
    -- ¥ではなく、バックスラッシュを入力する。おそらくMac固有
    {
        key = "¥",
        action = wezterm.action.SendKey { key = '\\' }
    },
    -- Altを押した場合はバックスラッシュではなく¥を入力する。おそらくMac固有
    {
        key = "¥",
        mods = "ALT",
        action = wezterm.action.SendKey { key = '¥' }
    },
    -- ⌘ + でフォントサイズを大きくする
    {
        key = "+",
        mods = "CMD|SHIFT",
        action = wezterm.action.IncreaseFontSize,
    },
    -- ⌘ w でペインを閉じる（デフォルトではタブが閉じる）
    {
        key = "w",
        mods = "CMD",
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    -- ⌘ Ctrl ,で下方向にペイン分割
    {
        key = ",",
        mods = "CMD|CTRL",
        action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } },
    },
    -- ⌘ Ctrl .で右方向にペイン分割
    {
        key = ".",
        mods = "CMD|CTRL",
        action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } },
    },
    -- ⌘ Ctrl oでペインの中身を入れ替える
    {
        key = "o",
        mods = "CMD|CTRL",
        action = wezterm.action.RotatePanes 'Clockwise'
    },
    -- ⌘ Ctrl hjklでペインの移動
    {
        key = 'h',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'j',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    -- ⌘ Ctrl Shift hjklでペイン境界の調整
    {
        key = 'h',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Left', 2 },
    },
    {
        key = 'j',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Down', 2 },
    },
    {
        key = 'k',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Up', 2 },
    },
    {
        key = 'l',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Right', 2 },
    },
    -- Alt(Opt)+Shift+Fでフルスクリーン切り替え
    {
      key = 'f',
      mods = 'SHIFT|META',
      action = wezterm.action.ToggleFullScreen,
    },
    -- Ctrl+Shift+tで新しいタブを作成
    {
      key = 't',
      mods = 'SHIFT|CTRL',
      action = act.SpawnTab 'CurrentPaneDomain',
    },
    -- Ctrl+Shift+dで新しいペインを作成(画面を分割)
    {
      key = 'd',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    -- Ctrl+左矢印でカーソルを前の単語に移動
    {
      key = "LeftArrow",
      mods = "CTRL",
      action = act.SendKey {
        key = "b",
        mods = "META",
      },
    },
    -- Ctrl+右矢印でカーソルを次の単語に移動s
    {
      key = "RightArrow",
      mods = "CTRL",
      action = act.SendKey {
        key = "f",
        mods = "META",
      },
    },
    -- Ctrl+Backspaceで前の単語を削除
    {
      key = "Backspace",
      mods = "CTRL",
      action = act.SendKey {
        key = "w",
        mods = "CTRL",
      },
    },
 }

-- マウス操作の挙動設定
config.mouse_bindings = {
    -- 右クリックでクリップボードから貼り付け
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
}

-- tab bar
config.use_fancy_tab_bar = false
config.colors = {
  cursor_bg= "#c6c8d1",
  tab_bar = {
    background = "#1b1f2f",

    active_tab = {
      bg_color = "#444b71",
      fg_color = "#c6c8d1",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    inactive_tab = {
      bg_color = "#282d3e",
      fg_color = "#c6c8d1",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    inactive_tab_hover = {
      bg_color = "#1b1f2f",
      fg_color = "#c6c8d1",
      intensity = "Normal",
      underline = "None",
      italic = true,
      strikethrough = false,
    },

    new_tab = {
      bg_color = "#1b1f2f",
      fg_color = "#c6c8d1",
      italic = false
    },

    new_tab_hover = {
      bg_color = "#444b71",
      fg_color = "#c6c8d1",
      italic = false
    },
  }
}

return config

