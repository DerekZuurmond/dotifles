return {
  "mfussenegger/nvim-dap",
  config = function()
    -- Define custom breakpoint symbols
    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "Error", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "⚡", texthl = "Warning", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "Identifier", linehl = "Visual", numhl = "" })
  end,
}
