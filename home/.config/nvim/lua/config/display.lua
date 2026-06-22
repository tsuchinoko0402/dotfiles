local M = {}

function M.setup_transparent()
  local groups = {
    "Normal", "NonText", "LineNr", "Folded", "EndOfBuffer",
    "NormalFloat", "FloatBorder", "SignColumn", "StatusLine", "StatusLineNC"
  }
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
  end
end

-- ColorScheme イベントが発生した時に自動で実行されるようにする
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = M.setup_transparent,
})

return M
