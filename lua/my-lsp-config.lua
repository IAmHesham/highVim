vim.lsp.config('*', {
	on_attach = function(client, bufnr)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr })
		vim.keymap.set('n', 'gra', vim.lsp.buf.rename, { buffer = bufnr })
	end,
	capabilities = {},
})

vim.diagnostic.config {
	virtual_text = true,
	signs = true,
	underline = true,
}

local lsps = {
	{ "ts_ls" },
	{ "clangd" },
	{ "ols" },
	{ "ocamllsp" },
	{ "zls" },
	{ "svelte" },
	{ "bashls" },
	{ "jdtls" },
	{
		"rust_analyzer",
		{}
	},
	{
		"lua_ls",
		{
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
							"${3rd}/busted/library",
						},
						checkThirdParty = false,
					},
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					telemetry = { enable = false },
				},
			},
		},
	},
}

for _, lsp in pairs(lsps) do
	local name, config = lsp[1], lsp[2]
	if config then
		vim.lsp.config(name, config)
	end
	vim.lsp.enable(name)
end

require('cmp').setup({
	sources = { { name = 'nvim_lsp' } },
	mapping = require('cmp').mapping.preset.insert({
		['<CR>'] = require('cmp').mapping.confirm({ select = true }),
	}),
})
