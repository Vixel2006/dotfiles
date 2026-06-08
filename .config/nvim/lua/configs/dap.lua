local dap = require("dap")
local dapui = require("dapui")

-- Sign column icons (nerd font)
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })

-- DAP UI setup
dapui.setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
  mappings = {
    expand = { "o", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes",      size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks",      size = 0.25 },
        { id = "watches",     size = 0.25 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl",    size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = { close = { "q", "<Esc>" } },
  },
})

-- Highlight groups for DAP signs
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75" })
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e5c07b" })
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#be5046" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })

-- Auto open/close DAP UI
dap.listeners.after.event_initialised["dapui_config"] = function()
  dapui.open({ layout = 2 })
end
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- Virtual text
require("nvim-dap-virtual-text").setup()

-- Python
require("dap-python").setup("debugpy")

-- Go (handled by nvim-dap-go)
require("dap-go").setup()

-- C / C++ / Rust / Zig (via lldb-vscode)
local lldb = vim.fn.executable("lldb-vscode-19") ~= 0 and "lldb-vscode-19"
  or vim.fn.executable("lldb-vscode-18") ~= 0 and "lldb-vscode-18"
  or vim.fn.executable("lldb-vscode-17") ~= 0 and "lldb-vscode-17"
  or vim.fn.executable("lldb-vscode-16") ~= 0 and "lldb-vscode-16"
  or vim.fn.executable("lldb-vscode-15") ~= 0 and "lldb-vscode-15"
  or vim.fn.executable("lldb-vscode-14") ~= 0 and "lldb-vscode-14"
  or "lldb-vscode"

dap.adapters.lldb = {
  type = "executable",
  command = lldb,
  name = "lldb",
}

local lldb_config = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      local args_str = vim.fn.input("Arguments: ")
      return vim.split(args_str, " +")
    end,
  },
}

dap.configurations.c = lldb_config
dap.configurations.cpp = lldb_config
dap.configurations.rust = lldb_config
dap.configurations.zig = lldb_config
