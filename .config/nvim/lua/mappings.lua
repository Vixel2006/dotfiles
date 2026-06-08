require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- DAP keymaps
local dap = require("dap")
local dapui = require("dapui")

map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional breakpoint" })
map("n", "<leader>dc", dap.continue, { desc = "Continue / Start" })
map("n", "<leader>dsi", dap.step_into, { desc = "Step into" })
map("n", "<leader>dso", dap.step_over, { desc = "Step over" })
map("n", "<leader>dsO", dap.step_out, { desc = "Step out" })
map("n", "<leader>dui", dapui.toggle, { desc = "Toggle DAP UI" })
map("n", "<leader>dq", dap.terminate, { desc = "Terminate session" })
map("n", "<leader>dr", dap.restart, { desc = "Restart session" })
map("n", "<leader>drc", dap.run_to_cursor, { desc = "Run to cursor" })
map("n", "<leader>dh", dapui.eval, { desc = "Hover eval" })
map("v", "<leader>dh", function()
  require("dapui").eval()
end, { desc = "Eval visual selection" })
