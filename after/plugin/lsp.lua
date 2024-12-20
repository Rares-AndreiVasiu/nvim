local lsp = require("lsp-zero")

-- Customize the LSP on_attach function to set up keymaps and features for each language server
lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Ensure the lua language server is configured for Neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

-- Add Verilog support by configuring the verible language server
lsp.ensure_installed({'pyright','lua_ls', 'rust_analyzer',  'verible' })  -- Ensures the Verilog LSP is installed

require("lspconfig").pyright.setup({
    on_attach = lsp.on_attach,
    flags = {
        debounce_text_changes = 150,
    }
})

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

require("lspconfig").verible.setup({
  on_attach = lsp.on_attach,  -- Attach the LSP key mappings
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    -- Customize Verilog LSP settings here, if needed
    verible = {
        lint= {enabled = true},
        completion = {enabled = true},
    }
}
})

require("lspconfig").rust_analyzer.setup({
    on_attach = lsp.on_attach,

    settings = {
        ["rust_analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },

            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            proMacro = {
                enable = true,
            },
        }
    }
})
-- Set up lsp-zero with any global settings
lsp.setup()

-- nvim-cmp setup for autocompletion

local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},

	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

