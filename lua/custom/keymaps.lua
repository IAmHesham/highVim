-- Helpers
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function mapfn(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Keymaps
mapfn('n', '<leader>rn', function() vim.o.relativenumber = not vim.o.relativenumber end, { desc = "Toggle relative line numbers" })
map('', '<C-s>', ':w<CR>', { desc = "Save buffer" })

-- Dismiss Noice Message
map("n", "<leader>nd", ":NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

-- File manager keymaps
map('', "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map('', "<leader>dd", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Telescope
do
	local telescopeBuiltin = require('telescope.builtin')
	mapfn('n', "<leader><leader>", telescopeBuiltin.find_files, { desc = "Fuzzy find file" })
	mapfn('n', '<leader>fg', telescopeBuiltin.live_grep, { desc = "ripgrep" })
	mapfn('n', '<leader>bb', telescopeBuiltin.buffers, { desc = "Find buffer" })
	mapfn('n', '<leader>fh', telescopeBuiltin.help_tags, { desc = "Help tags" })
end

-- lsp keymaps
mapfn("n", "K", vim.lsp.buf.hover, { desc = "Lsp Hover" })
mapfn("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
mapfn("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
mapfn("n", "[d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
mapfn("n", "]d", vim.diagnostic.goto_prev, { desc = "Goto prev diagnostic" })
mapfn("n", "<leader>ls", vim.lsp.buf.workspace_symbol, { desc = "Work Space Symbol" })
mapfn("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })
mapfn("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Lsp rename" })
mapfn("n", "<leader>lR", vim.lsp.buf.references, { desc = "Lsp references" })

-- DAP keymaps
map("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "Debuger toggle breakpoint" })
map("n", "<leader>dr", "<CMD>DapContinue<CR>", { desc = "Starts or Continue debuger" })
