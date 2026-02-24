return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-cmdline',
		}
	},
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			-- Odinfmt gets its configuration from odinfmt.json. It defaults
			-- writing to stdout but needs to be told to read from stdin.
			formatters = {
				odinfmt = {
					-- Change where to find the command if it isn't in your path.
					command = "odinfmt",
					args = { "-stdin" },
					stdin = true,
				},
			},
			-- and instruct conform to use odinfmt.
			formatters_by_ft = {
				odin = { "odinfmt" },
			},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end
	},
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "jay-babu/mason-nvim-dap.nvim" },
		opts = {
			handlers = {},
			ensure_installed = {
				"codelldb"
			}
		},
		config = function(_, _)
			local dap = require("dap")
			dap.set_log_level("TRACE")
			dap.adapters.lldb = {
				type = 'executable',
				command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
				name = 'lldb'
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function ()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},
				}
			}
			dap.configurations.cpp = {
				{
					name = 'Launch',
					type = 'lldb',
					request = 'launch',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},
				},
			}
		end
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
	},
	-- {
	--   'VonHeikemen/lsp-zero.nvim',
	--   branch = "v1.x",
	--   dependencies = {
	--     -- LSP support
	--     'neovim/nvim-lspconfig',
	--
	--     -- Autocompletetion
	--     'hrsh7th/nvim-cmp',
	--     'hrsh7th/cmp-buffer',
	--     'hrsh7th/cmp-path',
	--     'saadparwaiz1/cmp_luasnip',
	--     'hrsh7th/cmp-nvim-lsp',
	--     'hrsh7th/cmp-nvim-lua',
	--     'hrsh7th/cmp-cmdline',
	--
	--     -- Snippets
	--     'L3MON4D3/LuaSnip',
	--     'rafamadriz/friendly-snippets',
	--   },
	-- },
	-- {
	--   "williamboman/mason.nvim",
	--   lazy = true,
	--   opts = {}
	-- },
	-- {
	--   "williamboman/mason-lspconfig.nvim",
	--   lazy = true,
	--   dependencies = {
	--     "williamboman/mason.nvim",
	--     "neovim/nvim-lspconfig",
	--     "nvim-lua/plenary.nvim"
	--   }
	-- },
	-- {
	--   "jose-elias-alvarez/null-ls.nvim",
	--   lazy = true,
	-- },
	-- {
	--   "folke/trouble.nvim",
	--   opts = {}, -- for default options, refer to the configuration section for custom setup.
	--   cmd = "Trouble",
	--   keys = {
	--     {
	--       "<leader>xx",
	--       "<cmd>Trouble diagnostics toggle<cr>",
	--       desc = "Diagnostics (Trouble)",
	--     },
	--     {
	--       "<leader>xX",
	--       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	--       desc = "Buffer Diagnostics (Trouble)",
	--     },
	--     {
	--       "<leader>cs",
	--       "<cmd>Trouble symbols toggle focus=false<cr>",
	--       desc = "Symbols (Trouble)",
	--     },
	--     {
	--       "<leader>cl",
	--       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	--       desc = "LSP Definitions / references / ... (Trouble)",
	--     },
	--     {
	--       "<leader>xL",
	--       "<cmd>Trouble loclist toggle<cr>",
	--       desc = "Location List (Trouble)",
	--     },
	--     {
	--       "<leader>xQ",
	--       "<cmd>Trouble qflist toggle<cr>",
	--       desc = "Quickfix List (Trouble)",
	--     },
	--   },
	-- }
}
