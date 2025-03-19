return {
  "github/copilot.vim",
  lazy = false,
  config = function()
    vim.g.copilot_no_tab_map = true;
    vim.g.copilot_assume_mapped = true;
    vim.g.copilot_tab_fallback = "";
    vim.api.nvim_set_keymap("i", "<leader>i", "copilot#Accept('<CR>')", { silent = true, expr = true, noremap = true })
  end,
}
