return {
  "cocopon/iceberg.vim",
  lazy = false,    -- 起動時に読み込む
  priority = 1000, -- 最優先で適用
  config = function()
    vim.cmd([[colorscheme iceberg]])
  end,
}
