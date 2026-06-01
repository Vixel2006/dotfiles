require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
