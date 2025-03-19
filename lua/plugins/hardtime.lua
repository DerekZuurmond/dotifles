return {
  "m4xshen/hardtime.nvim",
  event = { "BufRead", "BufNewFile", "VeryLazy" },
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require("hardtime").setup({
      -- Add your configuration here if needed
    })
  end,
}
