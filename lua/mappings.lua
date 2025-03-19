require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <CR>", { desc = "Save file" })

-- Window Navigation (Tmux Integration)
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Window left" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Window down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Window up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Window right" })

map("n", "-", "<cmd> Oil<CR>", { desc = "Window right" })

-- Scrolling & Centering
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Buffer & Splits
map("n", "<leader>v", "<C-w>v<C-w>l", { desc = "Vertical split and move right" })
map("n", "<leader>b", "<cmd> enew <CR>", { desc = "New buffer" })
map("n", "<leader>nf", "<cmd> enew <CR>", { desc = "New file" })

-- g€kl€klch & Highlights
map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })
map("n", "<leader>sr", ":%s//g<Left><Left>", { desc = "Search & Replace" })

-- Run Python Files
map("n", "py", ":!python3 %<CR>", { desc = "Run Python file" })
map(
  "n",
  "mpy",
  ":!python3 -m %:p:r | sed 's|/|.|g' | sed 's|\\.py$||' | sed 's|^.*src|src|' <CR>",
  { desc = "Run Python file as module" }
)

-- Copy & Paste
map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })

-- Line Numbers
map("n", "<leader>n", "<cmd> set nu! <CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd> set rnu! <CR>", { desc = "Toggle relative number" })

-- LSP Actions
map("n", "<leader>fm", function()
  vim.lsp.buf.format { async = true }
end, { desc = "LSP formatting" })
map("n", "gD", function()
  vim.lsp.buf.declaration()
end, { desc = "LSP declaration" })
map("n", "gd", function()
  vim.lsp.buf.definition()
end, { desc = "LSP definition" })
map("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "LSP hover" })
map("n", "gi", function()
  vim.lsp.buf.implementation()
end, { desc = "LSP implementation" })
map("n", "<leader>ls", function()
  vim.lsp.buf.signature_help()
end, { desc = "LSP signature help" })
map("n", "<leader>D", function()
  vim.lsp.buf.type_definition()
end, { desc = "LSP definition type" })
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP code action" })
map("n", "gr", function()
  vim.lsp.buf.references()
end, { desc = "LSP references" })

-- Diagnostics
map("n", "[d", function()
  vim.diagnostic.goto_prev { float = { border = "rounded" } }
end, { desc = "Goto prev diagnostic" })
map("n", "]d", function()
  vim.diagnostic.goto_next { float = { border = "rounded" } }
end, { desc = "Goto next diagnostic" })
map("n", "<leader>lf", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Floating diagnostic" })

-- Telescope
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })

-- Comments
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
map(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Toggle comment" }
)

-- NvimTree
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })

-- Terminal Mode
map("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Escape terminal mode" })
-- nvterm Terminal Toggles
map({ "n", "t" }, "<A-f>", function()
  require("nvterm.terminal").toggle "float"
end, { desc = "Toggle floating term" })
map({ "n", "t" }, "<A-h>", function()
  require("nvterm.terminal").toggle "horizontal"
end, { desc = "Toggle horizontal term" })
map({ "n", "t" }, "<A-v>", function()
  require("nvterm.terminal").toggle "vertical"
end, { desc = "Toggle vertical term" })
-- Close terminal in terminal mode
map("t", "<C-q>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true), "n", true)
  vim.cmd "q"
end, { desc = "Close terminal" })
-- Create new horizontal terminal
map("n", "<leader>h", function()
  require("nvterm.terminal").new "horizontal"
end, { desc = "New horizontal term" })

-- Debugging (DAP)
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint" })

map("n", "<F5>", "<cmd> DapContinue <CR>", { desc = "Continue Debugging" })
map("n", "<F10>", "<cmd> DapStepOver <CR>", { desc = "Step Over (F10)" })
map("n", "<F11>", "<cmd> DapStepInto <CR>", { desc = "Step Into (F11)" })
map("n", "<F12>", "<cmd> DapStepOut <CR>", { desc = "Step Out (F12)" })
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle Breakpoint" })
map("n", "<leader>dr", "<cmd> DapRestart <CR>", { desc = "Restart Debugging" })
map("n", "<leader>dq", "<cmd> DapTerminate <CR>", { desc = "Terminate Debugging" })

map("n", "<leader>dpr", function()
  require("dap-python").test_method()
end, { desc = "Run Python test method" })

-- Indenting in Visual Mode
map("v", "<", "<gv", { desc = "Indent line left" })
map("v", ">", ">gv", { desc = "Indent line right" })

-- Moving within Wrapped Lines
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })

-- Buffer Navigation
-- map("n", "<tab>", function() require("nvchad.tabufline").tabuflineNext() end, { desc = "Goto next buffer" })
-- map("n", "<S-tab>", function() require("nvchad.tabufline").tabuflinePrev() end, { desc = "Goto prev buffer" })
-- map("n", "<leader>x", function() require("nvchad.tabufline").close_buffer() end, { desc = "Close buffer" })

-- GitSigns
map("n", "<leader>ph", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
map("n", "<leader>gb", function()
  package.loaded.gitsigns.blame_line()
end, { desc = "Blame line" })

-- LSP Rename
map("n", "<leader>ra", function()
  require("nvchad.renamer").open()
end, { desc = "LSP rename" })

-- Find functions in the current file
map("n", "<leader>fu", function()
  require("telescope.builtin").lsp_document_symbols {
    symbols = { "function", "method" },
  }
end, { desc = "Find functions in current file" })
