vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set nobackup")
vim.cmd("set nowritebackup")
vim.cmd("set noswapfile")
vim.cmd("set rnu")
vim.cmd("set cursorline")
vim.opt.shadafile = "NONE"

require("config.lazy")

require("catppuccin").setup()
vim.cmd.colorscheme("catppuccin-mocha")

-- Set the background transparency for Neovim
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })

-- Set keymap to float windows with error and warnings 
vim.keymap.set("n", "<leader>q", ":lua vim.diagnostic.open_float()<CR>", {})

--Set keymap for copilot chat
vim.keymap.set("n", "<leader>cp", ":CopilotChatOpen<CR>", {})

-- Set keymap for copilot chat toggle
vim.keymap.set("n", "<leader>ct", ":CopilotChatToggle<CR>", {})

-- Set the font color of line numbers
vim.api.nvim_set_hl(0, "LineNr", { fg = "#f7f5f5" })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
-- map :tabn and :tabp to F7 and F8
vim.keymap.set("n", "<F7>", ":tabn<CR>", {})
vim.keymap.set("n", "<F8>", ":tabp<CR>", {})

-- file navigation
vim.keymap.set("n", "<leader>e", ":Ex<CR>", {})

-- neotree
vim.keymap.set("n", "<leader>f", ":Neotree filesystem reveal toggle right<CR>", {})

-- here the configuration for dap ####################################################
local dap = require("dap")
local dapui = require("dapui")

-- Initialize DAP UI first
dapui.setup({
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			pause = "⏸",
			play = "▶",
			step_into = "⏎",
			step_over = "⏭",
			step_out = "⏮",
			terminate = "⏹",
		},
	},
	elements = {
		{ id = "scopes", size = 0.25 },
		{ id = "breakpoints", size = 0.25 },
		{ id = "stacks", size = 0.25 },
		{ id = "watches", size = 0.25 },
		{ id = "console", size = 0.25 },
		{ id = "repl", size = 0.5 },
	},
})

-- Then configure debug adapters
dap.adapters.coreclr = {
	type = "executable",
	command = "/usr/bin/netcoredbg/netcoredbg",
	args = { "--interpreter=vscode" },
}

-- .NET configurations (keep existing)
-- Then configure debug adapters
dap.adapters.coreclr = {
	type = "executable",
	command = "/usr/bin/netcoredbg/netcoredbg",
	args = { "--interpreter=vscode" },
}

-- Add this .NET configurations block
dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Launch .NET Core App",
		request = "launch",
		program = function()
			return vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/net9.0/", "file")
		end,
		cwd = "${workspaceFolder}",
		env = {
			ASPNETCORE_ENVIRONMENT = "Development",
			ASPNETCORE_URLS = "https://localhost:5001;http://localhost:5000",
		},
		console = "integratedTerminal",
	},
}

-- Modified listeners with vim.schedule
dap.listeners.after.event_initialized["dapui_config"] = function()
	vim.schedule(dapui.open)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	vim.schedule(dapui.close)
end
dap.listeners.before.event_exited["dapui_config"] = function()
	vim.schedule(dapui.close)
end

-- Basic controls
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<leader>b", function()
	require("dap").toggle_breakpoint()
end)

vim.keymap.set({ "n", "v" }, "<M-e>", function()
	require("dapui").eval()
end)

-- Advanced breakpoints
vim.keymap.set("n", "<leader>B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

vim.fn.sign_define("DapBreakpoint", {
	text = "🔴", -- Red dot symbol (or use 🔴/ for Nerd Font icons)
	texthl = "DapBreakpoint", -- Highlight group for the symbol
	linehl = "", -- Line highlight (optional)
	numhl = "", -- Number column highlight (optional)
})

-- Optional: Add conditional/logpoint variants
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
